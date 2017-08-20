{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where

import DBus
import DBus.Client

import qualified Services.Song as Song
import qualified Services.Getter as Get
import qualified Services.Sender as Send
import qualified Services.Store  as Store
import qualified Services.Preferences as Prefs

someFunc :: IO ()
someFunc = do
    song <- Get.getSong
    case song of
        Just song -> do
            Store.writeSong song
            Send.sendSong song
        otherwise -> return ()
