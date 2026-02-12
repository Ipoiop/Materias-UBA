longitud :: [t] -> Integer
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

ultimo :: [t] -> t
ultimo s | longitud s == 1 = head s
         | otherwise = ultimo (tail s)

principio :: [t] -> [t]
principio s | longitud s == 1 = []
            | otherwise = (head s:principio (tail s))

reverso :: [t] -> [t]
reverso [] = []
reverso s | longitud s == 1 = s
          | otherwise = ((ultimo s):(reverso (principio s)))

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece e (x:xs) = e == x || pertenece e xs

todosIguales :: (Eq t) => [t] -> Bool
todosIguales (x:xs) | longitud xs == 1 = x == head xs
                    | otherwise = x == head xs && todosIguales xs

todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = True
todosDistintos (x:xs) = not (pertenece x xs) && todosDistintos xs

hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos s = not (todosDistintos s)

quitar :: (Eq t) => t -> [t] -> [t]
quitar e (x:xs) | not (pertenece e (x:xs)) = (x:xs)
                | e == x = xs 
                | otherwise = (x:(quitar e xs))

quitarTodos2 :: (Eq t ) => t -> [t] -> [t]
quitarTodos2 e (x:xs) | not (pertenece e (x:xs)) = (x:xs)
                     | xs == [] = []
                     | e == x = quitarTodos e xs 
                     | otherwise = (x:(quitarTodos e xs))

quitarTodos :: (Eq t ) => t -> [t] -> [t]
quitarTodos e s | not (pertenece e s) = s
                | otherwise = quitarTodos e (quitar e s)

eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos (x:xs) | todosDistintos (x:xs) = (x:xs)
                         | pertenece x xs = (x:(eliminarRepetidos (quitarTodos x xs)))
                         | otherwise = (x:(eliminarRepetidos xs))

incluidoEn :: (Eq t) => [t] -> [t] -> Bool
incluidoEn [] _ = True
incluidoEn (x:xs) t = pertenece x t && incluidoEn xs t 

mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos s t = incluidoEn s t && incluidoEn t s

--capicua :: (Eq t) => [t] -> Bool 

-- ej 3

sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

productoria :: [Integer] -> Integer
productoria [] = 1
productoria (x:xs) = x*productoria xs

maximo :: [Integer] -> Integer
maximo (x:xs) | longitud (x:xs) == 1 = x
              | x > head xs = maximo (x:(tail xs))
              | otherwise = maximo xs

sumarN :: Integer -> [Integer] -> [Integer]
sumarN _ [] = []
sumarN n (x:xs) = ((n + x):(sumarN n xs))

sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero s = sumarN (head s) s

sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo s = sumarN (ultimo s) s

pares :: [Integer] -> [Integer]
pares [] = []
pares (x:xs) | xEsPar = (x:(pares xs))
             | otherwise = pares xs
             where xEsPar = mod x 2 == 0

multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN _ [] = []
multiplosDeN n (x:xs) | xMultiploDeN = (x:(multiplosDeN n xs))
                      | otherwise = multiplosDeN n xs
                      where xMultiploDeN = mod x n == 0

minimo :: [Integer] -> Integer
minimo (x:xs) | longitud (x:xs) == 1 = x
              | x < head xs = minimo (x:(tail xs))
              | otherwise = minimo xs

ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar s = ((minimo s):(ordenar (quitar (minimo s) s)))

--ej 4

sacarBlancosRepetidos :: [Char] -> [Char]
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos (x:xs) | longitud (x:xs) == 1 = (x:xs)
                             | x == ' ' && (head xs) == ' ' = 
                                sacarBlancosRepetidos xs
                             | otherwise = (x: (sacarBlancosRepetidos xs))

contarPalabrasUnBlanco :: [Char] -> Integer
contarPalabrasUnBlanco [] = 0
contarPalabrasUnBlanco (x:xs) | longitud (x:xs) == 1 = 1
                              | x /= ' ' && head xs == ' '  = 
                                1 + contarPalabrasUnBlanco (tail xs)
                              | otherwise = contarPalabrasUnBlanco xs

contarPalabras :: [Char] -> Integer
contarPalabras [] = 0
contarPalabras s = contarPalabrasUnBlanco (sacarBlancosRepetidos s)

--palabraMasLarga :: [Char] -> [Char] 

primerPalabra :: [Char] -> [Char]
primerPalabra [] = []
primerPalabra (x:xs) | head xs == ' ' = [x]
                     | otherwise = (x: (primerPalabra xs))

sacarPalabra :: [Char] -> [Char] -> [Char]
sacarPalabra _ [] = []
sacarPalabra (x:xs) t | head (sacarBlancosRepetidos t) == ' ' = 
                          tail (sacarBlancosRepetidos t)
                      | longitud (x:xs) == 1 = quitar x t
                      | otherwise = sacarPalabra xs (quitar x t)

sacarPrimerPalabra :: [Char] -> [Char]
sacarPrimerPalabra s = sacarPalabra (primerPalabra (sacarBlancosRepetidos s))
                          (sacarBlancosRepetidos s)

palabrasUnBlanco :: [Char] -> [[Char]]
palabrasUnBlanco [] = [[]]
palabrasUnBlanco s | contarPalabras s == 1 && ultimo s == ' ' = [principio s]
                   | contarPalabras s == 1 = [s]
                   | otherwise = ((primerPalabra s): 
                        palabrasUnBlanco (tail (sacarPrimerPalabra s)))

palabras :: [Char] -> [[Char]]
palabras s | head lista1Blanco == ' ' = palabrasUnBlanco (tail lista1Blanco)
           | otherwise = palabrasUnBlanco lista1Blanco
           where lista1Blanco = sacarBlancosRepetidos s
 
aplanar :: [[Char]] -> [Char]
aplanar [[]] = []
aplanar (xx:xxs) | longitud xx == 0 = aplanar xxs
                 | otherwise = ((head xx):(aplanar ((tail xx): xxs)))

aplanarConBlancos :: [[Char]] -> [Char]
aplanarConBlancos [[]] = []
aplanarConBlancos (xx:xxs) | longitud xx == 0 = (' ':(aplanarConBlancos xxs))
                 | otherwise = ((head xx):(aplanarConBlancos ((tail xx): xxs)))








