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
    printf "% 2d * % 2d = %02d\n" x y z

main :: IO ()
main = do
    mapM_ showGugu $ gugu <$> [2..9] <*> [2..9]
```

## shwo two cols gugudan

```haskell
import Text.Printf ( printf )
import Data.List ( intercalate )

pringGu :: (Int,Int,Int) -> String
pringGu (x,y,z) = printf "% 2d * % 2d = % 2d" x y z

getData :: [[(Int, Int, Int)]]
getData =
    let gu0 = [2,4..8]
        gu1 = [3,5..9]
    in [[(x0, y, x0*y),(x1, y, x1*y)] | (x0,x1) <- zip gu0 gu1, y<-[1..9]]

main :: IO()
main =
    let
        rowStr n = intercalate "\t" $ fmap pringGu $ getData!!n
    in  do
        print $ length getData
        mapM_ putStrLn $ fmap rowStr [0..(length getData-1)]

```
