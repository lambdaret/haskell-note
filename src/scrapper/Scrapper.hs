{-# LANGUAGE OverloadedStrings #-}
module Scrapper where
  -- let url = "https://kr.indeed.com/jobs?q=" ++ term ++ "&limit=50"

import qualified Data.ByteString.Lazy.Char8 as L8

import qualified Data.ByteString.UTF8 as BSU

import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import           Network.HTTP.Simple
import Text.XML.Cursor
import Text.HTML.DOM
import Text.Printf
import Control.Exception
import Control.Monad
-- import Control.Monad.IO.Class
-- import Control.Monad.Catch
import Control.Monad.IO.Unlift

initManager :: IO ()
initManager = do
    manager <- newManager $ managerSetProxy noProxy tlsManagerSettings
    setGlobalManager manager


-- getPages :: Exception e => p -> IO (Either e Request)
getPages term = do
    request' <- parseRequest "httpsxx//kr.indeed.com1"
    -- let request = setRequestMethod "GET"
    --               $ setRequestPath "/jobs"
    --               $ setRequestQueryString [("q", Just (BSU.fromString term)), ("limit", Just "50")]
    --               request'
    return request'
    -- httpLBS request

    -- case req of
    --   Left _ -> print "abc"
    --   Right _ -> print "def"
    -- req <- try $ parseRequest "https://kr.indeed.com1"
    -- case req of
    --   Left e1 -> print (e1 :: Exception)
    --   Right r1 -> case r1 of
    --       Left e2 -> print (e2 :: Exception)
    --       Right r2 -> print $ show r2
    -- case req of 
    --   Left e -> print (e :: Request)
    --   Right r -> print $ show r
    -- setRequestMethod "GET"
    --               $ setRequestPath "/jobs"
    --               $ setRequestQueryString [("q", Just (BSU.fromString term)), ("limit", Just "50")]
    --               request'  
    
--     try $ httpLBS request


-- f = do
--   x <- getPages "python"
--   case x of
--     Left e -> print (e :: HttpException)
--     Right r -> print $ show r

    -- case x of
      -- Left e -> print (e :: HttpException)
    --   Right response -> L8.putStrLn $ getResponseBody response
    
      -- MonadIO a -> print $ show b
      -- MonadThrow a -> print $ show a


    
    -- case eresponse of
    --     Left e -> print (e :: HttpException)
    --     Right response -> do
    --       let 
    --         statusCode = getResponseStatusCode response
    --         doc = getResponseBody response
    --         contentType = getResponseHeader "Content-Type" response
    --         cursor = fromDocument $ parseLBS doc

    --         li = cursor 
    --           $// attributeIs "class" "pagination"
    --           &/ element "ul"
    --           &/ element "li"
    --       printf "contentType: %s" $ show contentType
    -- length $ filter (not.null.($// content)) li
    
-- f2 = do
--   a <- return 3
--   b <- return 4
--   Just $ a*b
  -- a <- return "Hello"
  -- b <- return ", World"
  -- putStrLn $ a ++ b