# State

```
import Control.Monad.State
```

## runState

```
runState :: State s a -> s -> (a, s)
```

- return 값 과 state 값 리턴

```
runState (return 'X') 1
```

`('X',1)`

```
runState get 1
```

`(1,1)`

```
runState (put 5) 1
```

`((),5)`

## evalState

```
evalState :: State s a -> s -> a
```

- return 값만 반환

```
evalState (return 'X') [1,2,3]
```

`'X'`

```
evalState get [1,2,3]
```

`[1,2,3]`

```
evalState (put [4]) [1,2,3]
```

`()`

## execState

```
execState :: State s a -> s -> s
```

- state만 반환

```
execState (return 'X') [1,2,3]
execState get [1,2,3]
```

`[1,2,3]`

```
execState (put [4]) [1,2,3]
```

`[4]`

---

```haskell
import Control.Monad.State
    ( MonadState(put, get), gets, runState, State )


sumList :: Int -> State [Int] Int
sumList x = do
    s <- get
    put $ s ++ [x]
    gets sum


totalList :: State [Int] Int
totalList = do
    sumList 1
    sumList 2
    sumList 3

main :: IO ()
main = do
    let (r, s) = runState totalList []
    print r
    print s
```

```
-- sumList
t <- get
return $ sum t
```

```
-- sumList
sum <$> get
```

```
-- sumList
gets sum
```

- sumList : [Int] 에 더한 값들을 추가 하고 총합을 리턴
- totalList : sumList를 여러번 호출하여 [Int] 에 추가함.
- runState totalList [] : 초기 상태를 [] 로 시작.
