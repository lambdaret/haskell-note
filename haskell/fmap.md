# fmap, liftA, liftM

## fmap, Maybe

```
fmap (+2) (Just 3)
```

`Just 5`

```
(+2) <$> (Just 3)
```

`Just 5`

## fmap, List

```
fmap (+2) [1,2,3,4]
```

`[3,4,5,6]`

```
(+2) <$> [1,2,3,4]
```

`[3,4,5,6]`

## liftA, Just

```
import Control.Applicative
liftA (+2) (Just 3)
```

`Just 5`

## liftA, List

```
import Control.Applicative
liftA (+2) [1,2,3,4]
```

`[3,4,5,6]`

## liftM, Just

```
import Control.Monad
liftM (+2) (Just 3)
```

`Just 5`

## liftM, List

```
import Control.Monad
liftM (+2) [1,2,3,4]
```

`[3,4,5,6]`

## <\*>, Just

```
(Just (+2)) <*> (Just 3)
```

`Just 5`

## <\*>, List

```
[(+2)] <*> [1,2,3,4]
```

`[3,4,5,6]`

---

## <$>

### 함수를 boxing 된 값에 적용 하여 boxing된 값을 리턴

(+2) `3` = `5`

---

## <\*>

### boxing된 함수를 boxing된 값에 적용 하여 boxing된 값을 리턴

`(+2)` `3` = `5`

---
