module Services.Logger(writeToLog) where

import qualified Services.Preferences as P

writeToLog :: (Show a) => a -> IO ()
writeToLog = print
