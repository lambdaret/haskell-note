import Control.Exception ( try, IOException )
import Control.Monad.IO.Class ( MonadIO(liftIO) )

main :: IO ()
main = do
    d <- liftIO $ try $ readFile "a.txt" 
    case d :: Either IOException String of
        Left x -> putStrLn $ "Left: " ++ show x
        Right x -> putStrLn $ "Right: " ++ show x