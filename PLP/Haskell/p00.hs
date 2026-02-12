module P00 where
--utiles

esPrimo :: Int -> Bool
esPrimo n = cantidadDivisores n 1 == 2

cantidadDivisores :: Int -> Int -> Int
cantidadDivisores n ac
    | ac > n = 0
    | mod n ac == 0 = 1 + cantidadDivisores n (ac+1)
    | otherwise = cantidadDivisores n (ac+1)

promedio :: [Float] -> Float
promedio xs = sum xs / fromIntegral (length xs)

{-ej1:
    null :: [a] -> Bool - ¿Lista vacia?
    head :: [a] -> a
    tail :: [a] -> [a]
    init :: [a] -> [a] - tail al reves
    last :: [a] -> a - como head pero el ultimo
    take :: Int -> [a] -> [a] - toma los primeros x elem
    drop :: Int -> [a] -> [a] - opuesto a take
    (++) :: [a] -> [a] -> [a] - junta dos listas
    concat :: [[a]] -> [a] - junta una lista de listas a una sola
    reverse :: [a] -> [a] - invierte orden
    elem :: a -> [a] -> Bool - pertenece
-}

--ej2:
valorAbsoluto :: Float -> Float
valorAbsoluto n
    | n < 0 = -n
    | otherwise = n

bisiesto :: Int -> Bool --entra un año
bisiesto n = mod n 4 == 0

factorial :: Int -> Int
factorial 0 = 1
factorial n = n*factorial (n-1)

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos n = cantDivPrim n 2

cantDivPrim :: Int -> Int -> Int --lista de primos <= a n
cantDivPrim n ac
    | ac > n = 0
    | esPrimo ac && mod n ac == 0 = 1 + cantDivPrim n (ac+1)
    | otherwise = cantDivPrim n (ac+1)

--ej3:
{-data Maybe a = Nothing | Just a
data Either a b = Left a | Right b-}

inverso :: Float -> Maybe Float
inverso n
    | n /= 0 = Just (1/n)
    | otherwise = Nothing

aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right b)
    | b = 1
    | otherwise = 0

--ej4:
limpiar :: String -> String -> String
limpiar _ [] = []
limpiar apar (x:xs)
    | x `elem` apar = limpiar apar xs
    | otherwise = x : limpiar apar xs

difPromedio :: [Float] -> [Float]
difPromedio xs = map (flip (-) (promedio xs)) xs

todosIguales :: [Int] -> Bool
todosIguales (x:xs)
    | length xs < 2 = True
    | head xs == x = todosIguales xs
    | otherwise = False

--ej5:
data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB Nil = True

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i r d) = Bin (negacionAB i) (not r) (negacionAB d)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin i r d) = productoAB i * r * productoAB d