{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import qualified Snap.Core as C
import qualified Snap.Http.Server as S
import qualified Data.ByteString.Char8 as B

main :: IO ()
main = S.quickHttpServe site

site :: C.Snap ()
site =
    C.route [ ("ask", C.method C.GET getAskHandler),
              ("ask", C.method C.PUT putAskHandler),
              ("echo/:echoparam", echoHandler)
            ] <|> (C.writeBS "Can't find it, busy doing the computer" >> C.modifyResponse (C.setResponseStatus 404 "i got nothin"))

--finishWith (setResponseCode 404 (setResponseBody "Can't find it, busy doing the computer" emptyResponse)

--getAskHandler :: Params -> B.ByteString





getAskHandler = echoHandler

putAskHandler = echoHandler

echoHandler :: C.Snap ()
echoHandler = do
    param <- C.getParam "echoparam"
    maybe (C.writeBS "argle bargle; must specify echo/param in URL" >> C.modifyResponse (C.setResponseStatus 400 "get it right"))
          (\ p -> C.writeBS p >> C.modifyResponse (C.setResponseStatus 200 "very well then")) param
