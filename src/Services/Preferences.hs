module Services.Preferences(playerName, annicomToken, logFileName) where

import Data.Configurator.Types
import qualified Data.Configurator as C

loadPreferences :: IO Config
loadPreferences = C.load [C.Required "$(HOME)/.annicomscrobbler"]

playerName :: IO (Maybe String)
playerName = loadPreferences >>= (\config -> C.lookup config "playerName")

annicomLogin :: IO (Maybe String)
annicomLogin = loadPreferences >>= (\config -> C.lookup config "annicomLogin")

annicomToken :: IO (Maybe String)
annicomToken = loadPreferences >>= (\config -> C.lookup config "annicomToken")

logFileName :: IO (Maybe String)
logFileName = loadPreferences >>= (\config -> C.lookup config"logFileName")
