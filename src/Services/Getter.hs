module Services.Getter (getSong, getBusName) where

import qualified Services.Song as Song
import qualified Services.Logger as L
import qualified Services.Preferences as P

import qualified Data.Map.Strict as Map
import qualified Data.Maybe as Maybe

import DBus
import DBus.Client
import Data.Char(toLower)

getBusName :: String -> BusName
getBusName playername = busName_ $ (++) "org.mpris.MediaPlayer2." $ map toLower playername

processSongParameter :: String -> Variant -> Song.Song -> Song.Song
processSongParameter "xesam:title" currel sng = sng { Song.title = Maybe.fromJust $ fromVariant currel }
processSongParameter "xesam:artist" currel sng = sng { Song.artist = Maybe.fromJust $ fromVariant currel }
processSongParameter "xesam:genre" currel sng = sng { Song.genre = Maybe.fromJust $ fromVariant currel }
processSongParameter _ _ sng = sng

getCurrSong :: BusName -> IO (Maybe (Map.Map String Variant))
getCurrSong busName = do
    client <- connectSession
    reply <- call client $ getPropertyCall "org.mpris.MediaPlayer2.Player" "Metadata" `to` busName
    case reply of
        Left msg -> L.writeToLog msg >> return Nothing
        Right answer -> let body = methodReturnBody answer
                        in return (fromVariant (head body) >>= fromVariant)

getSong :: IO (Maybe Song.Song)
getSong = let
    getSong :: BusName -> IO (Maybe Song.Song)
    getSong busName = do
        songmap <- getCurrSong busName
        return $ do
            ansmap <- songmap
            return $ Map.foldrWithKey processSongParameter (Song.Song "" [] []) ansmap
          in do
            mPlayerName <- P.playerName
            case mPlayerName of
                Just name -> getSong . getBusName $ name
                Nothing -> return Nothing

getPropertyCall :: String -> String -> MethodCall
getPropertyCall interface property = (methodCall "/org/mpris/MediaPlayer2" "org.freedesktop.DBus.Properties" "Get")
    { methodCallBody = [toVariant interface, toVariant property] }

to :: MethodCall -> BusName -> MethodCall
to method bus = method { methodCallDestination = Just bus }
