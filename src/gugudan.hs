module Main where
import Data.List ( intercalate, transpose )
import Text.Printf ( printf )
import System.Environment ( getArgs )
import Control.Monad ( join )
import Control.Monad.Reader
import Control.Applicative

data Config = Config { colNum :: Int  -- 컬럼수
                     , maxNum :: Int  -- 9단
                     , colSep :: String
                     } deriving Show

getColNum :: Reader Config Int
getColNum = asks colNum

getMaxNum :: Reader Config Int
getMaxNum = asks maxNum

getColSep :: Reader Config String
getColSep = asks colSep

input :: Int -> [[(Int, Int)]]
input i = [[(x,y) | y<-[1..i]] | x<-[2..i]]

dim2 :: Int -> [a] -> [[a]]
dim2 n xs
    | null xs       = []
    | length xs < n = [take n xs]
    | otherwise     = take n xs: dim2 n (drop n xs)

input' :: Int -> Int -> [[[(Int, Int)]]]
input' n i = dim2 n $ input i


dash :: Reader Config String
dash = do
    nCol <- getColNum
    nMax <- getMaxNum
    sep <- getColSep
    let xyd = length $ show nMax
        zd = length $ show (nMax*nMax) 
    return $ "\n" ++ intercalate sep (replicate nCol (replicate (6+2*xyd+zd) '-'))

strOne :: (Int, Int) -> Reader Config String
strOne (x,y) = do
    nCol <- getColNum
    nMax <- getMaxNum
    let xyd = show.length $ show nMax
        zd = show.length $ show (nMax*nMax) 
    return (printf ("%" ++ xyd ++"d * %" ++ xyd ++ "d = %" ++ zd ++ "d") x y (x*y) :: String)

strRow :: [(Int, Int)] -> Reader Config String
strRow xs = do
    strOne' <- traverse strOne xs
    sep <- getColSep
    return $ intercalate sep strOne'

strGu :: [[(Int, Int)]] -> Reader Config String
strGu xs = do
    dash' <- dash
    strRow' <- traverse strRow (transpose xs)
    return $ intercalate "\n" strRow' ++ dash'

run :: Reader Config (IO ())
run = do
    
    nCol <- getColNum
    nMax <- getMaxNum
    dash' <- dash
    strGu' <- traverse strGu $ input' nCol nMax
    return $ mapM_ putStrLn $ dash':strGu'

main :: IO ()
main = do
    args <- getArgs
    let (nCol, nMax, sep) = case args of
            [x,y,z] -> (read x :: Int, read y :: Int, z :: String)
            _ -> (2, 9, "    ")  -- default
    runReader run $ Config nCol nMax sep
