{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Text (Text)
import Yesod

data App = App

mkYesod "App" [parseRoutes|
/       HomeR GET
/link1  Link1R GET
/link2  Link2R GET
/link3  Link3R GET
/link4  Link4R GET
|]

instance Yesod App where

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Redirects"
    [whamlet|
        <p>
            <a href=@{Link1R}>Click to start the redirect chain!
    |]

getLink1R, getLink2R, getLink3R :: Handler ()
getLink1R = redirect Link2R
getLink2R = redirect (Link3R, [("foo", "bar")])
getLink3R = redirect $ Link4R :#: ("baz"::Text)

getLink4R :: Handler Html
getLink4R = defaultLayout 
    [whamlet|
        <p>You made it!
    |]

main :: IO ()
main = warp 3000 App