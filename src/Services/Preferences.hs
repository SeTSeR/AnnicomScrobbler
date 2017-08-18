module Services.Preferences(playerName, annicomToken, logFileName) where

data Preferences = Preferences {
    playerName   :: String ,
    annicomToken :: String ,
    logFileName  :: String }

loadPreferences :: IO Preferences
loadPreferences = undefined
