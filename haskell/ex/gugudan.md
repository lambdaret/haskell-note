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

spList :: Int -> Int -> [Int]
spList n nMax = replicate (last [1..nMax]) . length =<< splitAt' n [2..nMax]

getData :: Int -> Int -> [[(Int, Int, Int)]]
getData n nMax =
    let
        p = splitAt' n [2..nMax]
        f1 xs = (\y x ->(x,y,x*y)) <$> [1..nMax] <*> xs
    in
        splitAt2 (spList n nMax) (f1 =<< p)

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

cal :: Int -> Int -> (Int, Int, Int)
cal x y = (x, y, x*y)

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
