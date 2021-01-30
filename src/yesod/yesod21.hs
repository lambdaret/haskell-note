{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
import Control.Applicative ((<$), (<*>))
import Data.Text (Text)
import Data.Time (Day)
import Yesod
    ( warp,
      mkYesod,
      whamlet,
      parseRoutes,
      defaultFormMessage,
      emailField,
      textField,
      urlField,
      aopt,
      areq,
      generateFormPost,
      renderDivs,
      runFormPost,
      Html,
      RenderMessage(..),
      Yesod(defaultLayout),
      RenderRoute(renderRoute),
      FormMessage,
      FormResult(FormSuccess),
      MForm )
import Yesod.Form.Jquery

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
/person PersonR POST
|]

instance Yesod App

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance YesodJquery App

data Person = Person
    { personName :: Text
    , personBirthday :: Day
    , personFavoriteColor :: Maybe Text
    , personEmail :: Text
    , personWebsite :: Maybe Text
    }
  deriving Show

personForm :: Html -> MForm Handler (FormResult Person, Widget)
personForm = renderDivs $ Person
    <$> areq textField "Name" Nothing
    <*> areq (jqueryDayField def
        { jdsChangeYear = True
        , jdsYearRange = "1900:-5"
        }) "Birthday" Nothing
    <*> aopt textField "Favorite color" Nothing
    <*> areq emailField "Email address" Nothing
    <*> aopt urlField "Website" Nothing    

getHomeR :: Handler Html
getHomeR = do
    (widget, enctype) <- generateFormPost personForm
    defaultLayout
        [whamlet|
            <p>
                The widget generated contains only the contents
                of the form, not the form tag itself. So...
                <form method=post action=@{PersonR} enctype=#{enctype}>
                    ^{widget}
                    <p>It also doesn't include the submit button.
                    <button>Submit
        |]

postPersonR :: Handler Html
postPersonR = do
    ((result, widget), enctype) <- runFormPost personForm
    case result of
        FormSuccess person -> defaultLayout [whamlet|<p>#{show person}|]
        _ -> defaultLayout
            [whamlet|
                <p>Invalid input, let's try again.
                <form method=post action=@{PersonR} enctype=#{enctype}>
                    ^{widget}
                    <button>Submit
            |]

main :: IO ()
main = warp 3000 App
