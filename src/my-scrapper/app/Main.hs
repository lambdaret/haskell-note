module Main where
{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple ()

main :: IO ()
main = do 
    putStrLn "Hello World"