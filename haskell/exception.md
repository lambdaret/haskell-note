# Exception

- Maybe
- Either
- try

```
readFile "a.txt"
*** Exception: a.txt: openFile: does not exist (No such file or directory)
```

```
import Control.Exception (IOException, try)
import Control.Monad.IO.Class

```

```
try :: Exception e => IO a -> IO (Either e a)
```

```haskell
import Control.Exception ( try, IOException )
import Control.Monad.IO.Class ( MonadIO(liftIO) )

main :: IO ()
main = do
    d <- liftIO $ try $ readFile "a.txt"
    case d :: Either IOException String of
        Left x -> putStrLn $ "Left:" ++ show x
        Right x -> putStrLn $ "Right:" ++ show x
```
