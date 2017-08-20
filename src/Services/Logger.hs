module Services.Logger(writeToLog) where

import qualified Services.Preferences as P

writeToLog :: (Show a) => a -> IO ()
writeToLog toWrite = do
    Just logName <- P.logFileName
    appendFile logName $ (++"\n") . show $ toWrite
