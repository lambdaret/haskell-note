```
stack new my-project yesodweb/sqlite && cd my-project
stack install yesod-bin --install-ghc
stack build
stack exec -- yesod devel

```

```
sudo apt-get install -y build-essential zlib1g-dev
sudo apt-get install -y libmysqlclient-dev
sudo apt-get install -y libpq-dev
```

```
stack build classy-prelude-yesod persistent-sqlite
```

```
stack runghc yesod-example.hs
```

```
{-# LANGUAGE MyLanguageExtension #-}
{-# LANGUAGE OverloadedStrings, TypeSynonymInstances, FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}
```

```
{-# LANGUAGE QuasiQuotes #-}

[hamlet|<p>This is quasi-quoted Hamlet.|]
```

```
runhaskell helloworld.hs
```

```
stack runghc helloworld.hs
```
