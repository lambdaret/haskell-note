{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
import Control.Exception (IOException, try)
import Control.Monad (when)
import Yesod
    ( logDebug,
      logError,
      logInfo,
      logWarn,
      warp,
      mkYesod,
      whamlet,
      parseRoutes,
      MonadIO(liftIO),
      Html,
      Yesod(defaultLayout, shouldLogIO),
      RenderRoute(renderRoute) )

data App = App
instance Yesod App where
    shouldLogIO App src level =
        return True

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

getHomeR :: Handler Html
getHomeR = do
    $logDebug "Trying to read data file"
    edata <- liftIO $ try $ readFile "datafile.txt"
    case edata :: Either IOException String of
        Left e -> do
            $logError "Could not read datafile.txt"
            defaultLayout [whamlet|An error occurred|]
        Right str -> do
            $logInfo "Reading of data file succeeded"
            let ls = lines str
            when (length ls < 5) $ $logWarn "Less than 5 lines of data"
            defaultLayout
                [whamlet|
                    <ol>
                        $forall l <- ls
                            <li>#{l}
                |]

main :: IO ()
main = warp 3000 App