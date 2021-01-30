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

##

```haskell

import Control.Exception ( SomeException, try )

x :: Integer
x = 5 `div` 0

test :: IO (Either SomeException ())
test = try (print x) :: IO (Either SomeException ())

test2 :: IO ()
test2 = do
    f <- test
    case f of
        Left e -> print e
        Right r -> print r
```

##

```
try :: Exception e => IO a -> IO (Either e a)
try a = catch (a >>= \ v -> return (Right v)) (\e -> return (Left e))
```

##

```
catch   :: Exception e
        => IO a         -- ^ The computation to run
        -> (e -> IO a)  -- ^ Handler to invoke if an exception is raised
        -> IO a
catch (IO io) handler = IO $ catch# io handler'
    where handler' e = case fromException e of
                       Just e' -> unIO (handler e')
                       Nothing -> raiseIO# e
```
