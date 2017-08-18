module Services.Preferences(playerName, annicomToken, logFileName) where

data Preferences = Preferences {
    pName   :: String ,
    aToken :: String ,
    lFlileName  :: String }

loadPreferences :: IO Preferences
loadPreferences = return $ Preferences "Spotify" "" ""

playerName :: IO String
playerName = pName <$> loadPreferences

annicomToken :: IO String
annicomToken = undefined

logFileName :: IO String
logFileName = undefined
