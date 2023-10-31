{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NumericUnderscores #-}

{-# OPTIONS_GHC -fno-warn-orphans -fspecialise-aggressively #-}

module Main where

import Control.Monad (void)
import Control.Concurrent                   (forkIO, threadDelay)

import Data.Streaming.Network
import Network.Socket.ByteString

import qualified Network.Wai.Handler.Warp as Warp

-- | The @main@ function for an executable running this site.
main :: IO ()
main = do
  void $ forkIO $ do
    runTCPClient (clientSettingsTCP 3070 "localhost") $ \addr -> do
      sock <- maybe (error "sock") pure $ appRawSocket addr
      msg <- recv sock 1024
      print ("Received: ", msg)
      threadDelay 60_000_000

  do
    let addAutoShutdown = Warp.setInstallShutdownHandler (\closeSocket -> void $ forkIO $ threadDelay 2_000_000 >> closeSocket)
    let application _ _ = error "application"
    Warp.runSettings (addAutoShutdown Warp.defaultSettings) application
