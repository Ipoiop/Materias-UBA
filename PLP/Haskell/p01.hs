

{-ej1:
I)
max2 :: (Float,Float) -> Float                     no curry
normaVectorial :: (Float,Float) -> Float           no curry
substract :: mismo que (-)                         curry
predecesor :: Float -> Float                       curry
evaluarEnCero :: b   ||  (donde f :: a -> b)       curry
dosVeces :: a -> a                                 depende de f?
flipAll :: [a -> b -> c] -> [b -> a -> c]          igual arriba
flipRaro :: b -> (a -> b -> c) -> a -> c           curry

II)
max2Curry = curry max2
normalVectorialCurry = curry normalVectorial
-}

--ej2:

curry2 :: ((a, b) -> c) -> a -> b -> c
curry2 f x y = f (x,y)

uncurry2 :: (a -> b -> c) -> (a, b) -> c
uncurry2 f (x,y) = f x y

--ej3:
sum2 :: Num a => [a] -> a
sum2 = foldr (+) 0

elem1 :: Eq a => a -> [a] -> Bool --recibe un elemento y una lista
                                  -- y devuelve True si está
elem1 _ [] = False -- Caso Base/lista vacia
elem1 e (x:xs) = e == x || elem1 e xs --Caso Recursivo

elem2 :: Eq a => a -> [a] -> Bool -- mismo tipo
elem2 e = foldr (\x rec -> x == e || rec) False

masmas2 :: [a] -> [a] -> [a]
masmas2 = flip (foldr (:))

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f = foldr (\x rec -> if f x then x:rec else rec) []

map2 :: (a -> b) -> [a] -> [b]
map2 f = foldr ((:) . f) []

mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x y -> if f x y then x else y)

mejorSegún2 :: (a -> a -> Bool) -> [a] -> a
mejorSegún2 f xs = foldr (\x rec -> if f x rec then x else rec) (head xs) xs
 --aca probe usando foldr normal
 --el c.b. funciona pq la lista de entrada contiene como minimo un elemento

sumasParciales :: Num a => [a] -> [a]
sumasParciales = foldl (\ac x ->
    ac ++ [x + if null ac then 0 else last ac]) []

sumasParciales2 :: Num a => [a] -> [a]
sumasParciales2 xs = reverse (foldr (\x rec ->
    x + (if null rec then 0 else head rec) : rec) [] (reverse xs))

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

sumaAlt2 :: Num a => [a] -> a
sumaAlt2 = sumaAlt.reverse


--ej4:

permutaciones :: [a] -> [[a]] --concatMap, take, drop
permutaciones = undefined

partes :: [a] -> [[a]]
partes = undefined

prefijos :: [a] -> [[a]]
prefijos = undefined

sublistas :: [a] -> [[a]]
sublistas = undefined


--ej5:

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) =
    if null xs then [x] else x : elementosEnPosicionesPares (tail xs)
    --no es estructural pq hace null xs

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys
                            then x : entrelazar xs []
                            else x : head ys : entrelazar xs (tail ys)
    --si es estructural

entrelazar2 :: [a] -> [a] -> [a]
entrelazar2 = foldr (\x rec ys -> if null ys
                            then x : rec []
                            else x : head ys : rec (tail ys)) id


--ej6:

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z []       = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs rec -> if n == x then xs else x:rec) []
-- no se puede rec. estr. pq no me dejaria devolver xs directamente

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs rec -> if n<x then n:x:xs else x:rec) [n]
--si llega al final se pone [n], si llega antes termina la recursion


--ej7:
mapPares :: (a -> c -> b) -> [(a,c)] -> [b]
mapPares f = map (uncurry f)

armarPares :: [a] -> [b] -> [(a,b)] --zip2
armarPares = foldr (\x rec ys ->
    if null ys then [] else (x, head ys) : rec (tail ys)) (const [])

mapDoble :: (a -> c -> b) -> [a] -> [c] -> [b] --zipWith2
mapDoble f xs ys = mapPares f (armarPares xs ys)


--ej8:
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
--mapPares f [([Int],[Int])] => uncurry f ([Int],[Int]) => f [Int] [Int]
sumaMat = zipWith (
        foldr (\x rec ys -> x + head ys : rec (tail ys)) (const []))

trasponer :: [[Int]] -> [[Int]]
trasponer = undefined


--ej9:

foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat _ z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia x = foldNat (const (x *)) 1
--para que entre primero el exponente


--ej10:

genLista :: a -> (a -> a) -> Integer -> [a]
genLista x f n = undefined --take n [x , f x ...]

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta n m = genLista n (+1) (m-n)


--ej11:

data Polinomio a = X
                | Cte a
                | Suma (Polinomio a) (Polinomio a)
                | Prod (Polinomio a) (Polinomio a)

foldPol :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPol cX cCte fSuma fProd p = case p of
                                    X        -> cX
                                    Cte a    -> cCte a
                                    Suma s t -> fSuma (rec s) (rec t)
                                    Prod s t -> fProd (rec s) (rec t)
                            where rec = foldPol cX cCte fSuma fProd


evaluar :: Num a => a -> Polinomio a -> a
evaluar n = foldPol n id (+) (*)


--ej12:

data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (a -> b -> b -> b) -> AB a -> b
foldAB cNil _ Nil = cNil
foldAB cNil cBin (Bin i r d) = cBin r (rec i) (rec d)
                        where rec = foldAB cNil cBin

recAB :: b -> (a -> AB a -> AB a -> b -> b -> b) -> AB a -> b
recAB cNil _ Nil = cNil
recAB cNil cBin (Bin i r d) = cBin r i d (rec i) (rec d)
                        where rec = recAB cNil cBin

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

raizAB :: AB a -> a -- no toma Nil
raizAB (Bin _ r _) = r

altura :: AB a -> Int
altura = foldAB 0 (\r ri rd -> 1 + max ri rd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\r ri rd -> 1 + ri + rd)

mejorSegúnAB :: (a -> a -> Bool) -> AB a -> a
mejorSegúnAB p ab = recAB (raizAB ab) (\r i d ri rd ->
                        if esNil i then mejor r rd else
            (if esNil d then mejor r ri else mejor r (mejor ri rd))) ab
                where mejor x y = if p x y then x else y

esABB :: Ord a => AB a -> Bool
esABB = recAB True (\r i d ri rd -> and [ri,rd,
                    esNil i || (raizAB i < r), esNil d || (r < raizAB d)])
    --recAB pq no puedo comparar con Nil


--ej13:



--ej15:

data RoseTree a = Rose a [RoseTree a] deriving Show

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose f (Rose n rs) = f n (map (foldRose f) rs)

hojas :: RoseTree a -> [a]
hojas = foldRose (\x rs -> if null rs then [x] else concat rs)

distancias :: RoseTree a -> [Int]
distancias = foldRose (\x rs -> if null rs then [0] else concatMap (map (+1)) rs)

alturaRose :: RoseTree a -> Int
alturaRose = foldRose (\x rs -> if null rs then 1 else 1 + maximum rs)