# Maybe

```haskell
data Maybe a = Nothing | Just a
```

## null safety function

```haskell
safeDiv:: Double -> Double -> Maybe Double
safeDiv x y = if y == 0 then Nothing else Just (x/y)
```

## do, Just

```haskell
safeCalculate = do
    x <- safeDiv 1 3
    y <- safeDiv 5 6
    z <- safeDiv x y
    safeDiv x z
```

> do 안에서 null 체크를 하지 않아도 계산 중간에 Nothing이 나올경우 Nothing을 리턴.

> 계산마다 다음계산의 실행여부를 if 문으로 평가할 필요가 없어짐.

```c
// c 의 경우
x = safeDiv(1,3)
y = safeDiv(5,6)
if (y == null){
    return null
} else {
    z = safeDiv(x, y)
    return safeDiv (x, z)
}
```

---

- do 는 리턴 타입에 따라 동작 이 달라진다.

## catMaybes

`import Data.Maybe`

```
catMaybes [Just 1, Just 2]
```

`[1,2]`

```
isJust (Just 3)
```

`True`

```
isJust Nothing
```

`False`
