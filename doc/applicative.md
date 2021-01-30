```
fmap (+) (Just 2) <*> Just 3
(+) <$> Just 2 <*> Just 3
Just (+) <*> Just 2 <*> Just 3
```

`Just 5`

```
fmap (+) [1,2] <*> [3,4]
(+) <$> [1,2] <*> [3,4]
(+) <$> [1,2] <*> [3,4]
[(+)] <*> [1,2] <*> [3,4]
```

`[4,5,5,6]`

```
[(+), (*)] <*> [1,2] <*> [3,4]
```

`[4,5,5,6,3,4,6,8]`

## Applicative

```
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b
```

## Applicative Maybe

```
instance Applicative Maybe where
    pure = Just
    Just f  <*> m       = fmap f m
    Nothing <*> _m      = Nothing
```

## Applicative []

```
instance Applicative [] where
    pure x    = [x]
    fs <*> xs = [f x | f <- fs, x <- xs]
```
