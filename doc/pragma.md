## ghci default option

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

```
:set -fprint-evld-with-show
:set -XPartialTypeSignatures -fno-warn-partial-type-signatures
```

```haskell
{-# LANGUAGE NoDatatypeContexts #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE NondecreasingIndentation #-}
{-# OPTIONS_GHC -fexternal-dynamic-refs #-}
{-# OPTIONS_GHC -fignore-optim-changes #-}
{-# OPTIONS_GHC -fignore-hpc-changes #-}
{-# OPTIONS_GHC -fimplicit-import-qualified #-}
```
