{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where

import DBus
import DBus.Client

import qualified Services.Getter as Get
import qualified Services.Sender as Send
import qualified Services.Store  as Store
import qualified Services.Preferences as Prefs

someFunc :: IO ()
someFunc = do
    song <- Get.getSong
    Store.writeSong $ Store.song (Get.title song) (Get.artist song) (Get.genre song)
    Send.sendSong $ Send.song (Get.title song) (Get.artist song) (Get.genre song)
