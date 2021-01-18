## unwords

```
unwords ["Hello", "World"]
```

`"Hello World"`

## read

```
read "1" :: Int
```

`1`

```
read "True" :: Bool
```

`True`

```
read "1" + 2
```

`3`

## succ

```
succ 1
```

`2`

```
succ 'a'
```

`'b'`

## min

```
min 3 4
```

`3`

## max

```
max 3 4
```

`4`

## maximum

```
maximum [3, 8, 5, 1]
```

`8`

## minimum

```
minimum [3, 8, 5, 1]
```

`1`

## div

```
div 11 3
11 `div` 3
```

`3`

## mod

```
mod 11 3
11 `mod` 3
```

`2`

`3`

## head

```
head [1,2,3]
```

`1`

## tail

```
tail [1,2,3]
```

`[2,3]`

## last

```
last [1,2,3]
```

`3`

## init

```
init [1,2,3]
```

`[1,2]`

## length

```
length [1,2,3]
```

`3`

## null

```
null [1,2,3]
```

`False`

```
null []
```

`True`

## take

```
take 3 [1,2,3,4,5]
```

`[1,2,3]`

## drop

```
drop 3 [1,2,3,4,5]
```

`[4,5]`

## reverse

```
reverse [1,2,3,4,5]
```

`[5,4,3,2,1]`

## sum

```
sum [1,2,3,4,5]
```

`15`

## product

```
product [2,3,4]
```

`24`

## elem

```
elem 3 [1,2,3,4]
3 `elem` [1,2,3,4]
```

`True`

## [1 .. 5]

```
[1 .. 5]
```

`[1,2,3,4,5]`

```
[2,4 .. 8]
```

`[2,4,6,8]`

## cycle

```
cycle [1,2,3]
```

`1,2,3,1,2,3 ... `

```
take 4 (cycle [1,2,3])
take 4 $ cycle [1,2,3]
```

## list comprehension

```
[x*2 | x <-[1,2,3,4]]
[x*2 | x <-[1 .. 4]]

```

`[2,4,6,8]`

```
[x*2 | x <- [1,2,3,4], x*2 > 4]
```

`[6,8]`

```
[x*y | x <- [1,2], y <- [3,4]]
```

`[3,4,6,8]`

```
[x*y | x <- [1,2], y <- [3,4], x*y > 4]
```

`[6,8]`

## odd

```
odd 1
```

`True`

```
odd 2
```

`False`

## even

```
even 2
```

`True`

```
even 1
```

`False`

## takeWile

```
takeWhile (<3) [1,2,3,4]
```

`[1,2]`

## filter

```
filter odd [1,2,3,4]
```

`[1,3]`
