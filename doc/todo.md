## const

```
const 1 2
```

`1`

```
length' = foldr (const (1+)) 0
```

## <$

```
42 <$ Just "boring"
```

`Just 42`

# (\*\*\*)

```
class Category a => Arrow a where
    arr :: (b -> c) -> a b c

    first :: a b c -> a (b,d) (c,d)
    first = (*** id)

    second :: a b c -> a (d,b) (d,c)
    second = (id ***)

    (***) :: a b c -> a b' c' -> a (b,b') (c,c')
        f *** g = first f >>> arr swap >>> first g >>> arr swap
        where swap ~(x,y) = (y,x)

```

```
[(+), (*)] <*> [2] <*> [3]
```
