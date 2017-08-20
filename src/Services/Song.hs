module Services.Song(Song(Song), title, artist, genre) where

data Song = Song {
    title  :: String   ,
    artist :: [String] ,
    genre  :: [String] }
    deriving (Read, Show, Eq)
