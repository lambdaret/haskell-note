# <|>

```
import Control.Applicatve
```

## <|>, Just

```
Nothing <|> Nothing
```

`Nothing`

```
Just 2 <|> Nothing
```

`Just 2`

```
Nothing <|> Just 2
```

`Nothing`

```
Just 1 <|> Just 2
```

`Just 1`

## <|>, List

```
[1] <|> [2] <|> [3,4]
```

`[1,2,3,4]`
