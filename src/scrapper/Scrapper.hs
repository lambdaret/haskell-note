{-# LANGUAGE OverloadedStrings #-}
module Scrapper where

import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Simple

import Control.Monad.IO.Class
import Control.Monad.Catch

import Text.HTML.TagSoup
    ( (~==), parseTags, fromAttrib, Tag(TagOpen) )
import Text.Regex

import qualified Data.Text.Lazy as TL

import qualified Data.Text.Lazy.Encoding as TL

import Data.Maybe

data ExtractedJob = ExtractedJob 
    { uid :: String
    , title :: String
    , location :: String
    , salary :: String 
    , summary :: String
    } deriving Show


matches :: String -> String -> Bool
matches string regex = isJust $ mkRegex regex `matchRegex` string

-- findTag :: String -> [Char] -> ((Tag str -> Bool) -> Bool) -> Bool
-- findTag nm val tag = tag ((~== TagOpen "div" []) 
--           && ((fromAttrib nm tag) `matches` ("\b" ++ val ++ "\b")))


hasClass :: TL.Text -> [Tag TL.Text] -> Bool
hasClass nm x = elem nm $ TL.words $ fromAttrib "class" (head x)
-- f1 nm x = elem "jobsearch-SerpJobCard" $ words $ fromAttrib "class" (head x)

initManager :: IO ()
initManager = do
    manager <- newManager $ managerSetProxy noProxy tlsManagerSettings
    setGlobalManager manager


-- getPage :: (MonadThrow m, MonadIO m) => String -> m [[[Tag TL.Text]]]
-- getPage :: String -> m [[[Tag T.Text]]]
getPage :: (MonadThrow m, MonadIO m) => String -> m [Tag TL.Text]
getPage url = do
  -- request <- parseRequest "GET https://kr.indeed.com/jobs?q=python&limit=50"
  request <- parseRequest url
  response <- httpLBS request
  let
    doc = getResponseBody response
    tags = parseTags (TL.decodeUtf8 doc)
    -- fmap (findTag "class" "jobsearch-SerpJobCard") tags
    -- divs = (~== TagOpen "div" [] && fromAttrib "class" tag `matches` "") <$> tags
  return tags
    -- pages = filter (sections (hasClass "jobsearch-SerpJobCard")) divs
  -- return pages

-- parse = do
--   let 
--     request = getRequest "https://kr.indeed.com/jobs?q=python&limit=50" 
--     response = simpleHttp request

-- parse = do
--   request <- parseRequest "GET https://kr.indeed.com/jobs?q=python&limit=50"
--   response <- httpLBS request
--   let
--     doc = getResponseBody response
--   print doc
--     cursor = fromDocument $ parseLBS doc
--     -- p = cursor $// attributeIs "class" "pagination" &/ element "li"
--     f = elem "jobsearch-SerpJobCard" $ T.unwords . ($/attribute "class")
--     p = head $ filter f $ (cursor $// element "div")

    -- p = cursor $// attributeIs "data-tn-component" "organicJob"
                --  &| (=="jobsearch-SerpJobCard unifiedRow row result")

                --  &| (elem "jobsearch-SerpJobCard" . words)
                --  &| (any (== "abc") $ words)
      -- p = cursor $// attributeIs "class" "jobsearch-SerpJobCard unifiedRow row result"
      -- jobsearch-SerpJobCard unifiedRow row result clickcard
  -- print p
  --   c = head p
  --   title = T.unpack $ head $ 
  --           c $// attributeIs "class" "title" &/ element "a" &/ content
  --   location = T.unpack $ T.unwords $ 
  --           c $// attributeIs "class" "sjcl" &// element "span" &/ content

  -- putStrLn title
  -- putStrLn location
-- main = parse


-- f = (elem "jobsearch-SerpJobCard") . T.words . head . (++[""]) .($| attribute "class")

-- anyAttrValue (\x -> elem "cc" (words x)) [("class", "aa bb")]

-- elem "jobsearch-SerpJobCard" $ words (fromAttrib "class")

