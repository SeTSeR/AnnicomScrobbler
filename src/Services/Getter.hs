module Services.Getter (title, genre, artist, getSong, getBusName, getReply) where

import qualified Services.Store as S
import qualified Services.Logger as L
import qualified Services.Preferences as P

import qualified Data.Map.Strict as Map
import qualified Data.Maybe as Maybe

import DBus
import DBus.Client
import Data.Char(toLower)

data Song = Song { title :: String  ,
                   artist :: String ,
                   genre :: String  }
    deriving Show

song :: String -> String -> String -> Song
song t a g = Song {
    title  = t ,
    artist = a ,
    genre  = g }

getBusName :: String -> BusName
getBusName playername = busName_ $ (++) "org.mpris.MediaPlayer2." $ map toLower playername

getSong :: IO (Maybe Song)
getSong = do
    busName <- getBusName <$> P.playerName
    client <- connectSession
    reply <- call client $ getPropertyCall "org.mpris.MediaPlayer2.Player" "Metadata" `to` busName
    case reply of
        Left msg -> L.writeToLog msg >> return Nothing
        Right answer -> let body = methodReturnBody answer
                            currsong = case ((fromVariant (head body) >>= fromVariant) :: Maybe (Map.Map String Variant)) of
                                Nothing -> Nothing
                                Just ansmap -> Just $ Map.foldrWithKey (\key currel sng -> case key of
                                    "xesam:title" -> sng { title = Maybe.fromJust ((fromVariant currel) :: Maybe String) }
                                    "xesam:artist" -> sng { artist = head . Maybe.fromJust $ ((fromVariant currel) :: Maybe [String]) }
                                    "xesam:genre" -> sng { genre = head . Maybe.fromJust $ ((fromVariant currel) :: Maybe [String]) }
                                    otherwise -> sng ) (song "" "" "") ansmap
                        in return currsong

getPropertyCall :: String -> String -> MethodCall
getPropertyCall interface property = (methodCall "/org/mpris/MediaPlayer2" "org.freedesktop.DBus.Properties" "Get")
    { methodCallBody = [toVariant interface, toVariant property] }

to :: MethodCall -> BusName -> MethodCall
to method bus = method { methodCallDestination = Just bus }

getReply :: BusName -> IO (Maybe (Map.Map String Variant))
getReply bus = do
    client <- connectSession
    reply <- call client $ getPropertyCall "org.mpris.MediaPlayer2.Player" "Metadata" `to` bus
    case reply of
        Left msg -> L.writeToLog msg >> return Nothing
        Right x -> let body = methodReturnBody x
                   in return $ (fromVariant (head body) >>= fromVariant)
