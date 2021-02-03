
f1 :: Integer -> Bool
f1 = do
    a <- (>5)
    b <- (==6)
    return $ a && b

f2 = do
    n <- [1,2]
    x <- ['a', 'b']
    return (n, x)
