module Services.Store(title, genre, artist, song, getLastSong, getAllSongs, writeSong) where

data Song = Song {
    title  :: String ,
    artist :: String ,
    genre  :: String }

song :: String -> String -> String -> Song
song t a g = Song {
    title  = t ,
    artist = a ,
    genre  = g }

getLastSong :: Maybe Song
getLastSong = undefined

getAllSongs :: Maybe [Song]
getAllSongs = undefined

writeSong :: Song -> IO ()
writeSong = undefined
