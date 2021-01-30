# State & Reader

```haskell
{-# LANGUAGE FlexibleContexts #-}
import Control.Monad.State
    ( MonadState(get), evalState, evalStateT, State )
import Control.Monad.Reader
    ( runReader, MonadReader(ask), Reader, ReaderT(runReaderT) )

addS :: Int -> State Int Int
addS a = do
    n <- get
    return $ a * n


addR :: Int -> Reader String Int
addR a = do
    n <- ask
    let n' = (read n::Int)
    return $ a * n'


add :: (MonadState Int m, MonadReader String m) => Int -> m Int
add a = do
    n1 <- get
    n2 <- ask
    let n2' = (read n2::Int)
    return (a*n1*n2' :: Int)

main :: IO ()
main = do
    print $ evalState (addS 3) 2
    print $ runReader (addR 3) "2"
    print $ runReader (evalStateT (add 3) 2) "2"
    print $ evalState (runReaderT (add 3) "2") 2

```
