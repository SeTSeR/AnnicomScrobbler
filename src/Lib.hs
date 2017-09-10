{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( mainFunc
    ) where

import Control.Monad(forever, guard)
import Control.Concurrent(threadDelay, forkIO)

import Data.Maybe(isJust, fromJust)

import qualified Services.Song as Song
import qualified Services.Getter as Get
import qualified Services.Sender as Send
import qualified Services.Store  as Store
import qualified Services.Preferences as Prefs

interval :: Int
interval = 2 * 60 * 1000 * 1000

processSong :: IO ()
processSong = do
    song <- Get.getSong
    guard $ isJust song
    Send.sendSong $ fromJust song
    _ <- threadDelay interval
    return ()

mainFunc :: IO ()
mainFunc = do
    forever $ processSong
