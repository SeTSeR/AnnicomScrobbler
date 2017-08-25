module Services.Song(Song(Song), title, artists, genres) where

data Song = Song {
    title  :: String   ,
    artists :: [String] ,
    genres  :: [String] }
    deriving (Read, Show, Eq)
