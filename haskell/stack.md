## stack

```
-- install async
stack install --resolver=ghc-8.4.4 async

stack config set system-ghc --global true
```

```
stack exec ghc-pkg -- list
```

## cabal

```
cabal --version
cabal install cabal-install
cabal update
```

```
cabal install --force-reinstalls async
cabal install --reinstall async
cabal install --lib async
cabal install --global clientsession
```

```
cabal list --installed
```

## ghc-pkg

```
ghc-pkg list
```

```
ghcup list

# install the recommended GHC version
ghcup install ghc

# install a specific GHC version
ghcup install ghc 8.2.2

# set the currently "active" GHC version
ghcup set ghc 8.4.4

# install cabal-install
ghcup install cabal

# update ghcup itself
ghcup upgrade

```
