# 구구단

## 결과 출력

```haskell
-- ghci
(*) <$> [2..9] <*> [2..9]
```

## 입력값도 같이 출력

```
gugu :: [Int] -> [Int] -> [(Int, Int, Int)]
gugu a b = do
    x <- a
    y <- b
    return (x, y, x*y)

main :: IO ()
main = do
    print $ gugu [2..9] [2..9]
```

## Applicative 를 사용하여

```haskell
pure (\x y -> (x,y, x*y)) <*> [2..9] <*> [2..9]
```

```haskell
gugu :: Int -> Int -> (Int, Int, Int)
gugu x y= (x,y,x*y)

main :: IO ()
main = do
    print $ gugu <$> [2..9] <*> [2..9]
```

## list comprehension

```haskell
[(x,y,x*y)|x<-[1..9],y<-[1..9]]
```

## show gugudan

```haskell
import Text.Printf ( printf )

gugu :: Int -> Int -> (Int, Int, Int)
gugu x y= (x,y,x*y)

showGugu :: (Int,Int,Int) -> IO()
showGugu (x, y, z) = do
    printf "%d * %d = %2d\n" x y z

main :: IO ()
main = do
    mapM_ showGugu $ gugu <$> [2..9] <*> [2..9]
```

## shwo two cols gugudan

```haskell
import Text.Printf ( printf )
import Data.List ( intercalate )

printGu :: (Int,Int,Int) -> String
printGu (x,y,z) = printf "%d * %d = %2d" x y z

getData :: [[(Int, Int, Int)]]
getData =
    let gu0 = [2,4..8]
        gu1 = [3,5..9]
    in [[(x0, y, x0*y),(x1, y, x1*y)] | (x0,x1) <- zip gu0 gu1, y<-[1..9]]

main :: IO()
main =
    let
        rowStr row = do intercalate "\t" $ printGu <$> row
    in  do
        mapM_ putStrLn $ rowStr <$> getData

```

## add dash

```haskell
import Text.Printf ( printf )
import Data.List ( intercalate )

printGu :: (Int,Int,Int) -> String
printGu (x,y,z) = printf "%d * %d = %2d" x y z

getData :: [[(Int, Int, Int)]]
getData =
    let gu0 = [2,4..8]
        gu1 = [3,5..9]
    in [[(x0, y, x0*y),(x1, y, x1*y)] | (x0,x1) <- zip gu0 gu1, y<-[1..9]]

main :: IO()
main =
    let
        dash [(_, y, _), _] =
            if y == 9
            -- then "\n" ++ (take 5 $ repeat '-') ++ "\t----------"
            then "\n" ++ replicate 10 '-' ++ "\t" ++ replicate 10 '-'
            else ""

        rowStr row =
            intercalate "\t" (printGu <$> row) ++ dash row

    in  do
        mapM_ putStrLn $ rowStr <$> getData
```

## cols 변경

```haskell
import Text.Printf ( printf )
import Data.List ( intercalate )
import Control.Monad

n :: Int
n = 4  -- 1,2,3,4,5,6,7,8,9

printGu :: (Int,Int,Int) -> String
printGu (x,y,z) = printf "%d * %d = %2d" x y z

splitAt' :: Int -> [a] -> [[a]]
splitAt' n xs =
    let
        (x1, x2) = splitAt n xs
    in  case x2 of
        [] -> [x1]
        _ -> x1:splitAt' n x2

splitAt2 :: [Int] -> [a] -> [[a]]
splitAt2 (x:xn) xs =
    let
        (x1, x2) = splitAt x xs
    in  case x2 of
        [] -> [x1]
        _ -> x1:splitAt2 xn x2

spList :: [Int]
spList = replicate 9 . length =<< d


getData :: [[(Int, Int, Int)]]
getData =
    let
        p = splitAt' n ([2..9] ::[Int])
        f1 xs = (\y x ->(x,y,x*y)) <$> [1..9] <*> xs
    in
        splitAt2 spList (f1 =<< p)


dash :: (Eq a1, Num a1) => (a2, a1, c) -> [Char]
dash (_, y, _) =
    if y == 9
    then "\n" ++ intercalate "\t" (replicate n (replicate 10 '-'))
    else ""

rowStr :: [(Int, Int, Int)] -> [Char]
rowStr row =
    intercalate "\t" (printGu <$> row) ++ dash (head row)

cal :: Int -> Int -> (Int, Int, Int)
cal x y = (x, y, x*y)

d :: [[Int]]
d = splitAt' n [2..9] -- [[2,3,4],[5,6,7],[8,9]]

main :: IO()
main = mapM_ putStrLn $ rowStr <$> getData
```

## argumant

```haskell
import Text.Printf ( printf )
import Data.List ( intercalate )
import Control.Monad
import System.Environment ( getArgs )

gu :: [Int]
gu = [2..9]

printGu :: (Int,Int,Int) -> String
printGu (x,y,z) = printf "%d * %d = %2d" x y z

splitAt' :: Int -> [a] -> [[a]]
splitAt' n xs =
    let
        (x1, x2) = splitAt n xs
    in  case x2 of
        [] -> [x1]
        _ -> x1:splitAt' n x2

splitAt2 :: [Int] -> [a] -> [[a]]
splitAt2 (x:xn) xs =
    let
        (x1, x2) = splitAt x xs
    in  case x2 of
        [] -> [x1]
        _ -> x1:splitAt2 xn x2

spList :: Int -> [Int]
spList n = replicate 9 . length =<< d n


getData :: Int -> [[(Int, Int, Int)]]
getData n =
    let
        p = splitAt' n gu
        f1 xs = (\y x ->(x,y,x*y)) <$> [1..9] <*> xs
    in
        splitAt2 (spList n) (f1 =<< p)


dash :: (Eq a1, Num a1) => Int -> (a2, a1, c) -> [Char]
dash n (_, y, _) =
    if y == 9
    then "\n" ++ intercalate "\t" (replicate n (replicate 10 '-'))
    else ""

rowStr :: Int -> [(Int, Int, Int)] -> [Char]
rowStr n row =
    intercalate "\t" (printGu <$> row) ++ dash n (head row)

cal :: Int -> Int -> (Int, Int, Int)
cal x y = (x, y, x*y)

d :: Int -> [[Int]]
d n = splitAt' n gu -- [[2,3,4],[5,6,7],[8,9]]

main :: IO ()
main = do
    args <- getArgs
    let
        nCol = read $ head args :: Int
    do
        mapM_ putStrLn $ rowStr nCol <$> getData nCol


```

## 수정본 n\*n단

```haskell

-- stack runghci 6 19
-- 6 column 19단
import Text.Printf ( printf )
import Data.List ( intercalate )
import Control.Monad
import System.Environment ( getArgs )

splitAt' :: [Int] -> [a] -> [[a]]
splitAt' (x:xn) xs =
    let
        (x1, x2) = splitAt x xs
    in  case x2 of
        [] -> [x1]
        _ -> x1:splitAt' xn x2

spList :: Int -> Int -> [Int]
spList n nMax = replicate (last [1..nMax]) . length =<< splitAt' (repeat n) [2..nMax]

getData :: Int -> Int -> [[(Int, Int, Int)]]
getData n nMax =
    let
        p = splitAt' (repeat n) [2..nMax]
        f1 xs = (\y x ->(x,y,x*y)) <$> [1..nMax] <*> xs
    in
        splitAt' (spList n nMax) (f1 =<< p)

lenMax :: (Show a, Num a) => a -> Int
lenMax n = length $ show n

dash :: Int -> Int -> (a, Int, c) -> [Char]
dash n nMax (_, y, _) =
    let
        xyD = lenMax nMax
        zD = lenMax (nMax*nMax)
    in
        if y == nMax
        then "\n" ++ intercalate "\t" (replicate n (replicate (6+2*xyD+zD) '-'))
        else ""

printGu :: Int -> (Int,Int,Int) -> String
printGu nMax (x,y,z) =
    let xyD = show $ lenMax nMax
        zD = show $ lenMax (nMax*nMax)
    in printf ("%" ++ xyD ++ "d * %" ++ xyD ++ "d = %" ++ zD ++ "d") x y z

rowStr :: Int -> Int -> [(Int, Int, Int)] -> [Char]
rowStr n nMax row =
    intercalate "\t" (printGu nMax <$> row) ++ dash n nMax (head row)

main :: IO ()
main = do
    args <- getArgs
    let
        (nCol, nMax) = case args of
            [x,y] -> (read x :: Int, read y :: Int)
            _ -> (1, 9)  -- default
    do
        mapM_ putStrLn $ rowStr nCol nMax <$> getData nCol nMax

```

## 다시 짠 코드

```haskell
module Main where
import Data.List ( intercalate, transpose )
import Text.Printf ( printf )
import System.Environment ( getArgs )
import Control.Monad ( join )

input :: Int -> [[(Int, Int)]]
input i = [[(x,y) | y<-[1..i]] | x<-[2..i]]

dim2 :: Int -> [a] -> [[a]]
dim2 n xs
    | null xs       = []
    | length xs < n = [take n xs]
    | otherwise     = take n xs: dim2 n (drop n xs)

input' :: Int -> Int -> [[[(Int, Int)]]]
input' n i = dim2 n $ input i

strOne :: (Int, Int) -> String
strOne (x,y) = printf "%1d * %1d = %2d" x y (x*y) :: String

strRow :: [(Int, Int)] -> String
strRow xs = intercalate "\t" $ strOne <$> xs

strGu :: [[(Int, Int)]] -> [Char]
strGu xs = intercalate "\n" (strRow <$> transpose xs) ++ "\n"

main :: IO ()
main = do
    args <- getArgs
    let (nCol, nMax) = case args of
            [x,y] -> (read x :: Int, read y :: Int)
            _ -> (2, 9)  -- default
    sequence_ $ putStrLn . strGu <$> input' nCol nMax
```

## Reader 로 config 적용

```haskell
module Main where
import Data.List ( intercalate, transpose )
import Text.Printf ( printf )
import System.Environment ( getArgs )
import Control.Monad ( join )
import Control.Monad.Reader
import Control.Applicative

data Config = Config { colNum :: Int  -- 컬럼수
                     , maxNum :: Int  -- 9단
                     } deriving Show

getColNum :: Reader Config Int
getColNum = asks colNum

getMaxNum :: Reader Config Int
getMaxNum = asks maxNum

input :: Int -> [[(Int, Int)]]
input i = [[(x,y) | y<-[1..i]] | x<-[2..i]]

dim2 :: Int -> [a] -> [[a]]
dim2 n xs
    | null xs       = []
    | length xs < n = [take n xs]
    | otherwise     = take n xs: dim2 n (drop n xs)

input' :: Int -> Int -> [[[(Int, Int)]]]
input' n i = dim2 n $ input i


dash :: Reader Config String
dash = do
    nCol <- getColNum
    nMax <- getMaxNum
    let xyd = length $ show nMax
        zd = length $ show (nMax*nMax)
    return $ "\n" ++ intercalate "    " (replicate nCol (replicate (6+2*xyd+zd) '-'))

strOne :: (Int, Int) -> Reader Config String
strOne (x,y) = do
    nCol <- getColNum
    nMax <- getMaxNum
    let xyd = show.length $ show nMax
        zd = show.length $ show (nMax*nMax)
    return (printf ("%" ++ xyd ++"d * %" ++ xyd ++ "d = %" ++ zd ++ "d") x y (x*y) :: String)

strRow :: [(Int, Int)] -> Reader Config String
strRow xs = do
    strOne' <- traverse strOne xs
    return $ intercalate "    " strOne'

strGu :: [[(Int, Int)]] -> Reader Config [Char]
strGu xs = do
    dash' <- dash
    strRow' <- traverse strRow (transpose xs)
    return $ intercalate "\n" strRow' ++ dash'

run :: Reader Config (IO ())
run = do
    nCol <- getColNum
    nMax <- getMaxNum
    strGu' <- traverse strGu $ input' nCol nMax
    return $ mapM_ putStrLn strGu'

main :: IO ()
main = do
    args <- getArgs
    let (nCol, nMax) = case args of
            [x,y] -> (read x :: Int, read y :: Int)
            _ -> (2, 9)  -- default
    runReader run $ Config nCol nMax
```
