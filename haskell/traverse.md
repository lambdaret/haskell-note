# traverse

## Traversable

```

```

## <\*>

```
[(+3),(+2),(+1)] <*> [3]
```

`[6,5,4]`

## sequenceA

```haskell
sequenceA [(+3),(+2),(+1)] 3
```

`[6,5,4]`

```haskell
sequenceA [Just 1, Just 2]
```

`Just [1,2]`

```haskell
sequenceA $ (\x-> Just (2+x)) <$> [2,3]
```

`Just [4,5]`

```haskell
mapM (\x->Just (2+x)) [2,3]
```

`Just [4,5]`

```haskell
traverse (\x->Just (2+x)) [2,3]
```

`Just [4,5]`
