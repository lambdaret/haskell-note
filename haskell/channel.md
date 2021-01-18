```
stack install async
cabal install --lib async
```

```haskell
import Control.Concurrent
  (Chan, newChan, readChan, writeChan)
import Control.Concurrent.Async (async)

job :: [Int] -> Chan Int -> IO()
job x ch = do
    writeChan ch (sum x :: Int)

main :: IO ()
main = do
    ch <- newChan
    async $ job [1,2,3,4] ch
    async $ job [5,6] ch

    x1 <- readChan ch
    x2 <- readChan ch
    print $ x1+x2

```

```
stack install BoundedChan
cabal install --lib BoundedChan
```

```haskell
import Control.Concurrent.BoundedChan
  ( BoundedChan, newBoundedChan, writeChan, readChan
  , getChanContents )
import Control.Concurrent.Async (async)
import Data.Maybe ( catMaybes, isJust )


job :: [Int] -> BoundedChan Int -> IO()
job x ch = do
    writeChan ch (sum x :: Int)


main :: IO ()
main = do
    let sizeCh = 2
    ch <- newBoundedChan sizeCh

    async $ job [1,2,3,4] ch
    async $ job [5,6] ch
    async $ job [8,9] ch
    async $ job [3,3] ch

    ctns <- getChanContents ch
    print $ sum $ take 4 ctns
```
