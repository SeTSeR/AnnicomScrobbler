module Services.Logger(writeToLog) where

import qualified Services.Preferences as P

writeToLog :: (Show a) => a -> IO ()
writeToLog toWrite = do
    log <- P.logFileName
    case log of
        Just logName -> appendFile logName $ (++"\n") . show $ toWrite
        Nothing -> return ()
