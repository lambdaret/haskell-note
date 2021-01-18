## data

```haskell
data Bool = False | True
```

`x = True`

`x = Flase`

```haskell
data Maybe a = Nothing | Just a
```

`x = Nothing`

`x = Just 1`

```haskell
data Person = Person {
    name :: String
    , age :: Int
}
```

`x = Person {name="haskell", age=1}`

```haskell
-- 재귀
data Tree a = EmptyTree | Node a (Tree a) (Tree a)
```

```haskell
data Point a = Point {
    x :: a
    , y:: a
} deriving Show
```

`print $ Point {x=1.12311111230, y=2.11111123123123123123} :: Point Float`

`print $ Point {x=1.12311111230, y=2.11111123123123123123} :: Point Double`

`print $ x Point {x=1.0, y=2.0}`

## type

- 기존 타입에 다른 이름을 부여

```haskell
type Person = [(String, Int)]
```

```haskell
type Point a = [(a, a)]

type Pointf = Point Float
```

`x = [(1.0, 2.0)] :: Pointf`

## newtype

- wrapping/unwrapping 을 하지 않아 data 보다는 속도가 빠르나, 하나의 생성자, 하나의 필드만 가능

```haskell
newtype Pair a b = Pair {
  getPair :: (a, b)
} deriving Show

```

`x = getPair $ Pair(1, 2)`

# type class
