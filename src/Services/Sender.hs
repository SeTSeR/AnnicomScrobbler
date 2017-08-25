module Services.Sender(sendSong) where

import Network.HTTP.Simple
import Network.HTTP.Client.MultipartFormData
import Data.ByteString.UTF8(fromString)

import qualified Services.Song as Song
import qualified Services.Preferences as P
import qualified Services.Logger as L

data SongRequest = SongRequest {
    login  :: String ,
    token  :: String ,
    title  :: String ,
    artist :: String ,
    genre  :: (Maybe String)
}

prepareRequest :: [Part] -> IO Request
prepareRequest params = do
    request <- return . parseRequest_ $ "POST https://annimon.com/json/nowplay"
    formDataBody params request

formBody :: String -> String -> Song.Song -> [Part]
formBody login token song | null . Song.genres $ song = [
    partBS "login"  $ fromString login ,
    partBS "token"  $ fromString token ,
    partBS "title"  $ fromString . Song.title $ song ,
    partBS "artist" $ fromString . head . Song.artists $ song ]
                          | otherwise = [
    partBS "login"  $ fromString login ,
    partBS "token"  $ fromString token ,
    partBS "title"  $ fromString . Song.title $ song ,
    partBS "artist" $ fromString . head . Song.artists $ song ,
    partBS "genre"  $ fromString . head . Song.genres  $ song ]

sendSong :: Song.Song -> IO ()
sendSong song = do
    Just login <- P.annicomLogin
    Just token <- P.annicomToken
    request <- prepareRequest $ formBody login token song
    answer <- httpLBS request
    L.writeToLog answer
    return ()
