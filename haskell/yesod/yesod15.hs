{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import Blaze.ByteString.Builder (Builder)
import Blaze.ByteString.Builder.Char.Utf8 (fromText)
import Control.Arrow ((***))
import Data.Monoid (mappend)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Network.HTTP.Types (encodePath)
import Debug.Trace
import Yesod
    ( Html,
      warp,
      mkYesod,
      whamlet,
      parseRoutes,
      Yesod(defaultLayout, cleanPath, joinPath),
      RenderRoute(renderRoute) )

data Slash = Slash deriving Show

mkYesod "Slash" [parseRoutes|
/ RootR GET 
/foo FooR GET 
|]
-- (Link3R, [("foo", "bar")])

instance Yesod Slash where
    -- joinPath :: Slash -> T.Text -> [T.Text] -> [(T.Text, T.Text)] -> Builder
    joinPath r ar pieces' qs' = 
        -- trace (show r ++ " " ++ show ar ++ " " ++ show pieces' ++ show qs') $
        fromText ar `mappend` encodePath pieces qs
      where
        qs = map (TE.encodeUtf8 *** go) qs'
        go "" = Nothing 
        go x = Just $ TE.encodeUtf8 x
        pieces = pieces' ++ [""]
    
    cleanPath _ [] = Right []
    cleanPath _ s
        | dropWhile (not . T.null) s == [""] =
            -- trace ("Rigth:" ++ show s) $ 
            Right $ init s
        | otherwise = 
            -- trace ("Left:" ++ show s) $ 
            Left $ filter (not . T.null) s

getRootR :: Handler Html 
getRootR = defaultLayout 
    [whamlet|
        <p>
            <a href=@{RootR}>RootR
        <p>
            <a href=@{FooR}>FooR
    |]

getFooR :: Handler Html 
getFooR = getRootR

main :: IO ()
main = warp 3000 Slash

