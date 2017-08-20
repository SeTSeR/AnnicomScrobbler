module Services.Preferences(playerName, annicomLogin, annicomToken, logFileName, storeFileName) where

import Data.Configurator.Types
import qualified Data.Configurator as C

loadPreferences :: IO Config
loadPreferences = do
    (conf, _) <- C.autoReload C.autoConfig [C.Required "$(HOME)/.annicomscrobbler"]
    return conf

playerName :: IO (Maybe String)
playerName = loadPreferences >>= (\config -> C.lookup config "playerName")

annicomLogin :: IO (Maybe String)
annicomLogin = loadPreferences >>= (\config -> C.lookup config "annicomLogin")

annicomToken :: IO (Maybe String)
annicomToken = loadPreferences >>= (\config -> C.lookup config "annicomToken")

logFileName :: IO (Maybe String)
logFileName = loadPreferences >>= (\config -> C.lookup config "logFileName")

storeFileName :: IO (Maybe String)
storeFileName = loadPreferences >>= (\config -> C.lookup config "storeFileName")
