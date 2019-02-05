module Services.Preferences(playerName, fallbackPlayerName, annicomLogin, annicomToken, logFileName, storeFileName) where

import Data.Configurator.Types
import qualified Data.Configurator as C

import System.Environment.XDG.BaseDir (getUserConfigDir)

loadPreferences :: IO Config
loadPreferences = do
    configDir <- getUserConfigDir "AnnicomScrobbler"
    (conf, _) <- C.autoReload C.autoConfig [C.Required $ configDir ++ "/annicomscrobbler"]
    return conf

playerName :: IO (Maybe String)
playerName = loadPreferences >>= (\config -> C.lookup config "playerName")

fallbackPlayerName :: IO String
fallbackPlayerName = return "spotify"

annicomLogin :: IO (Maybe String)
annicomLogin = loadPreferences >>= (\config -> C.lookup config "annicomLogin")

annicomToken :: IO (Maybe String)
annicomToken = loadPreferences >>= (\config -> C.lookup config "annicomToken")

logFileName :: IO (Maybe String)
logFileName = loadPreferences >>= (\config -> C.lookup config "logFileName")

storeFileName :: IO (Maybe String)
storeFileName = loadPreferences >>= (\config -> C.lookup config "storeFileName")
