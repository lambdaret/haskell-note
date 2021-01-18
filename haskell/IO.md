# IO

## putStrLn

```haskell
putStrLn :: String -> IO ()
```

## getLine

```haskell
getLine :: IO String
```

## getContents

```haskell
getContents :: IO String
```

```haskell
-- Main.hs
import Data.Char ( toUpper )

main :: IO ()
main = do
    contents <- getContents
    putStr (map toUpper contents)
```

```sh
cat sample.txt | runhaskell Main.hs
```

```haskell
import System.IO
    ( IOMode(ReadMode), hClose, hGetContents, openFile )

main :: IO ()
main = do
    handle <- openFile "sample.txt" ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle
```

```haskell
data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
```
