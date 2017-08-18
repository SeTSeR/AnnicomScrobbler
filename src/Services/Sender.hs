module Services.Sender(title, genre, artist, song, sendSong) where

import qualified Services.Store as S

data Song = Song {
    title  :: String ,
    artist :: String ,
    genre  :: String }

song :: String -> String -> String -> Song
song t a g = Song {
                title  = t ,
                artist = a ,
                genre  = g }

sendSong :: Song -> IO ()
sendSong = undefined
