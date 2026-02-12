import Data.Ratio (Ratio)
valorAbsoluto :: Float -> Float
valorAbsoluto n = if n>0 then n else -n

inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1/n)

aEntero :: Either Int Bool -> Int
aEntero (Right True) = 1
aEntero (Right False) = 0
aEntero (Left n) = n

todosIguales :: [Int] -> Bool
todosIguales (x:xs) | length (x:xs) <= 1 = True
                    | otherwise = x == head xs && todosIguales xs

data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i r d) = Bin (negacionAB i) (not r) (negacionAB d)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin i r d) = productoAB i * r * productoAB d