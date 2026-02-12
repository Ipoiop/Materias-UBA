--Ejercicio 2

absoluto :: Integer -> Integer
absoluto x | x >= 0 = x
           | otherwise = -x

maximoAbsoluto :: Integer -> Integer -> Integer
maximoAbsoluto x y | absoluto x >= absoluto y = absoluto x
                   | otherwise = absoluto y

maximo3 :: Integer -> Integer -> Integer -> Integer
maximo3 x y z = maximoAbsoluto (maximoAbsoluto x y) z

algunoEs0 :: Float -> Float -> Bool
algunoEs0 a b | a == 0 || b == 0 = True 
                     | otherwise = False

ambosSon0 :: Float -> Float -> Bool
ambosSon0 a b = a == 0 && b == 0

mismoIntervalo :: (Float) -> Float -> Bool
mismoIntervalo a b | a <= 3 && b <= 3 = True
                   | a > 7 && b > 7 = True
                   | otherwise = a <= 7 && b <= 7 && a > 3 && b > 3

sumaDistintos :: Integer -> Integer -> Integer -> Integer
sumaDistintos x y z | x == y && x == z = x
                    | x == y = x + z
                    | x == z = x + y
                    | z == y = x + y
                    | otherwise = x + y + z

esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe a b = mod a b == 0

digitoUnidades :: Integer -> Integer
digitoUnidades n = mod n 10

digitoDecenas :: Integer -> Integer
digitoDecenas n = mod (div n 10) 10


--Ejercicio 3
estanRelacionados :: Integer -> Integer -> Bool
--Al despejar me queda 'a/b = -k' y como 'k' es cualquier entero le puedo sacar el '-'.
--Al final me queda que la division de a por b es entera 
--que es lo mismo que decir a multiplo de b.
estanRelacionados a b = esMultiploDe a b && a /= 0


--Ejercicio 4

moduloVec :: (Float, Float) -> Float
moduloVec (v1, v2) = sqrt (v1^2 + v2^2)

cosEntreVec :: (Float, Float) -> (Float, Float) -> Float
cosEntreVec (v1, v2) (u1, u2) = (v1*u1 + v2*u2)/ ((moduloVec (v1, v2)) * (moduloVec (u1, u2)))

prodInt :: (Float, Float) -> (Float, Float) -> Float
prodInt v u = moduloVec v * moduloVec u * cosEntreVec v u

todoMenor :: (Float, Float) -> (Float, Float) -> Bool
todoMenor (v1, v2) (u1, u2) = v1 < u1 && v2 < u2

distanciaPuntos :: (Float, Float) -> (Float, Float) -> Float
distanciaPuntos (v1, v2) (u1, u2) = sqrt (((u1 - v1) ^2) + ((u2 - v2) ^2))

sumaTerna :: (Integer, Integer, Integer) -> Integer
sumaTerna (x, y ,z) = x+y+z

multiploDe :: Integer -> Integer -> Integer
--Si x es multiplo de n me devuelve x, sino 0
multiploDe x n | esMultiploDe x n = x
               | otherwise = 0

sumarSoloMultiplos :: (Integer, Integer, Integer) -> Integer -> Integer
sumarSoloMultiplos (x, y ,z) n = multiploDe x n + multiploDe y n + multiploDe z n

esPar :: Integer -> Bool
esPar x = mod x 2 == 0

primerPar :: (Integer, Integer, Integer) -> Integer
primerPar (x, y ,z) | esPar x = x
                    | esPar y = y
                    | esPar z = z
                    | otherwise = 0

posPrimerPar :: (Integer, Integer, Integer) -> Integer
posPrimerPar t | primerPar t /= 0 = primerPar t
               | otherwise = 4

crearPar :: a -> b -> (a, b)
crearPar x y = (x, y)

invertir :: (a, b) -> (b, a)
invertir (x, y) = (y, x)