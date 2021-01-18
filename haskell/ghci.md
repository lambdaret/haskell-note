## multiline

```
Prelude> :set +m
```

```
:{
:}
```

```
Prelude> :seti
base language is: Haskell2010
with the following modifiers:
  -XNoDatatypeContexts
  -XExtendedDefaultRules
  -XNoMonomorphismRestriction
  -XNondecreasingIndentation
GHCi-specific dynamic flag settings:
other dynamic, non-language, flag settings:
  -fexternal-dynamic-refs
  -fignore-optim-changes
  -fignore-hpc-changes
  -fimplicit-import-qualified
warning settings:
```

## ghci vs Main.hs

```
Prelude> import Text.Printf
Prelude> printf "%.2f" pi
```

`3.14`

```
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where
import Text.Printf

main = printf "%.2g\n" pi
```

`3.14`

## prompt setting

```
-- .ghci
:set prompt "ghci> "
```

```
-- type 이 같이 출력됨.
:set +t
```

```
-- type 출력 해제
:unset +t

```

## load script

```
-- load
:l learn.hs

-- reload
:r
```
