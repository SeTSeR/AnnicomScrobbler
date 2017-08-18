module Services.Getter (title, genre, artist, getSong, getReply) where

import qualified Services.Store as S
import qualified Services.Logger as L

import DBus
import DBus.Client

data Song = Song { title :: String  ,
                   artist :: String ,
                   genre :: String  }

song :: String -> String -> String -> Song
song t a g = Song {
    title  = t ,
    artist = a ,
    genre  = g }

getSong :: IO Song
getSong = undefined

getPropertyCall :: String -> String -> MethodCall
getPropertyCall interface property = (methodCall "/org/mpris/MediaPlayer2" "org.freedesktop.DBus.Properties" "Get")
    { methodCallBody = [toVariant interface, toVariant property] }

to :: MethodCall -> BusName -> MethodCall
to method bus = method { methodCallDestination = Just bus }

getReply bus = do
    client <- connectSession
    reply <- call client $ getPropertyCall "org.mpris.MediaPlayer2.Player" "Metadata" `to` bus
    case reply of
        Left msg -> L.writeToLog msg >> return Nothing
        Right x -> return (Just x) 
