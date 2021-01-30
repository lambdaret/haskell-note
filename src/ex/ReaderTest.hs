import Control.Monad.Reader
import Control.Applicative

newtype Config = Config { val :: Int} deriving Show

add :: Int -> Reader Config Int
add x = do
    config <- ask
    return $ x + val config

add' :: Int -> Reader Config Int
add' x = do
    a <- add 3
    -- xs <- traverse add [3,4]
    xs <- mapM add [3,4]
    -- config <- ask
    -- return $ x + a + sum ((`runReader` config) . add <$> [3,4])
    return $ x + a + sum xs

main :: IO ()
main = do
    print $ runReader (add 3) (Config 10)
    print $ runReader (add' 3) (Config 10)
