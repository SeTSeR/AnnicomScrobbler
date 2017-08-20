module Services.Store(getLastSong, getAllSongs, writeSong) where

import qualified Services.Song as Song

getLastSong :: Maybe Song.Song
getLastSong = undefined

getAllSongs :: Maybe [Song.Song]
getAllSongs = undefined

writeSong :: Song.Song -> IO ()
writeSong = undefined
