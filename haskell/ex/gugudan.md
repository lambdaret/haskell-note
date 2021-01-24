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

```
pure (\x y -> (x,y, x*y)) <*> [2..9] <*> [2..9]
```

```
gugu :: Int -> Int -> (Int, Int, Int)
gugu x y= (x,y,x*y)

main :: IO ()
main = do
    print $ gugu <$> [2..9] <*> [2..9]
```

## list comprehension

```
[(x,y,x*y)|x<-[1..9],y<-[1..9]]
```
