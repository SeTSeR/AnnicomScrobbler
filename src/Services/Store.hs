module Services.Store(getLastSong, getAllSongs, writeSong) where

import qualified Services.Preferences as P
import qualified Services.Song as Song

getLastSong :: IO (Maybe Song.Song)
getLastSong = (fmap . fmap) head getAllSongs

getAllSongs :: IO (Maybe [Song.Song])
getAllSongs = do
    Just fileName <- P.storeFileName
    content <- readFile fileName
    return . Just $ map read $ lines content

writeSong :: Song.Song -> IO ()
writeSong song = do
    Just fileName <- P.storeFileName
    appendFile fileName $ (++"\n") . show $ song
