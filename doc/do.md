## >>=

```
(>>=) :: Monad m => m a -> (a -> m b) -> m b
```

## Just, >>=, do

```
(Just 5) >>= \x->return (x*2)
```

`Just 10`

```
do
    x <- Just 5
    Just (x*2)
```

```
do
    x <- Just 5
    return (x*2)
```
