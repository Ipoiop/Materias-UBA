{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Distribution.Simple.Command (OptDescr(BoolOpt))
{-# HLINT ignore "Use sum" #-}
{-# HLINT ignore "Use tuple-section" #-}
curry2 :: ((a, b) -> c) -> a -> b -> c
curry2 f x y = f (x, y)

max2 :: Ord a => (a, a) -> a
max2 (x, y) | x >= y = x
            | otherwise = y

uncurry2 :: (a -> b -> c) -> (a, b) -> c
uncurry2 f (x,y) = f x y

sum2 :: Num a => [a] -> a
sum2 = foldr (+) 0

elem2 :: Eq a => a -> [a] -> Bool
elem2 n = foldr (\x -> (||) (n == x)) False

masmas :: [a] -> [a] -> [a]
masmas = flip (foldr (:))

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f = foldr (\x -> if f x then (:) x else (++) []) []

map2 :: (a -> b) -> [a] -> [b]
map2 f = foldr ((:) . f) []

mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x y-> if f x y then x else y)
--no puede ser vacio

maximum2 :: Ord a => [a] -> a
maximum2 = mejorSegún (>)

sumasParciales2 :: Num a => [a] -> [a]
sumasParciales2 [] = []
sumasParciales2 [x] = [x]
sumasParciales2 (x:y:xs) = x : (if null xs then [x+y] else sumasParciales2 ((x+y):xs))

sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = foldr (\x rec -> (:) (sumHasta (length xs - length rec) xs) rec) [] xs

sumHasta :: Num a => Int -> [a] -> a
sumHasta n = sum.take n

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

sumaAltAlt :: Num a => [a] -> a
sumaAltAlt = sumaAlt.reverse

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z []       = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs rec ->if x == n then xs else x:rec) []

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs rec -> if n < x
                            then n:x:xs
                            else x:rec) [n]

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = foldr (\(x, y) rec -> f x y : rec) []

mapPares2 :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares2 f = foldr ((:).uncurry f) []

armarPares2 :: [a] -> [b] -> [(a,b)]
armarPares2 xs [] = []
armarPares2 [] ys = []
armarPares2 (x:xs) (y:ys) = (x,y):armarPares2 xs ys

armarPares :: [a] -> [b] -> [(a,b)]
armarPares = foldr (\x next ys -> if null ys then [] else (x, head ys) : next (tail ys)) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

foldNat :: (Integer -> Integer -> Integer) -> Integer -> Integer -> Integer
foldNat _ z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia n = foldNat (\x rec -> n*rec) 1

data AB a = Nil | Bin (AB a) a (AB a)

--una fcion para cada constr recurstivo, otra para cada constr base, entrada, salida
foldAB :: (a -> b -> b -> b) -> b -> AB a -> b
foldAB _ z Nil = z
foldAB f z (Bin i r d) = f r (rec i) (rec d)
                    where rec = foldAB f z

--como el anterior, pero la fcion tmbien tiene acceso a la "cola" del argumento
recAB :: (a -> AB a -> AB a -> b -> b -> b) -> b -> AB a -> b
recAB _ z Nil = z
recAB f z (Bin i r d) = f r i d (rec i) (rec d)
                    where rec = recAB f z

esNil :: AB a -> Bool
esNil x = case x of
    Nil -> True
    _ -> False

altura :: AB a -> Int
altura = foldAB (\_ ri rd -> 1 + max ri rd) 0

cantNodos :: AB a -> Int
cantNodos = foldAB (\_ ri rd -> 1 + ri + rd) 0

raizAB :: AB a -> a
raizAB (Bin _ r _) = r

--usa los hijos y lo aplica a la raiz
foldAB1 :: (a -> a -> a -> a) -> AB a -> a
foldAB1 _ (Bin Nil r Nil) = r
foldAB1 f (Bin i r Nil) = f r (foldAB1 f i) r
foldAB1 f (Bin Nil r d) = f r r (foldAB1 f d)
foldAB1 f (Bin i r d) = f r (foldAB1 f i) (foldAB1 f d)

mejorSegunAB :: (a -> a -> Bool) -> AB a -> a
mejorSegunAB f = foldAB1 (\r ri rd -> maxMS r (maxMS ri rd))
            where maxMS i d = if f i d then i else d
-- la entrada no puede ser Nil
coso :: AB Int
coso = Bin (Bin (Bin Nil 5 Nil) 2 (Bin Nil 1 Nil)) 4 (Bin Nil 3 (Bin Nil 4 Nil))

esABB :: Ord a => AB a -> Bool
esABB = recAB (\r i d ri rd -> case (i, d) of
                        (Nil, Nil) -> ri && rd
                        (Nil, d) -> (r < raizAB d) && ri && rd
                        (i, Nil) -> (raizAB i <= r) && ri && rd
                        (i, d) -> (raizAB i <= r) && (r < raizAB d) && ri && rd) True
-- recr, comparar raices && sus ramas son abb

data RoseTree a = Rose a [RoseTree a]

foldRT :: (a -> [b] -> b) -> RoseTree a -> b
foldRT f (Rose r hijos) = f r (map (foldRT f) hijos)

recRT :: (a -> [RoseTree a] -> [b] -> b) -> RoseTree a -> b
recRT f (Rose r hijos) = f r hijos (map (recRT f) hijos)

hojas :: RoseTree a -> [a]
hojas = foldRT (\r rec -> if null rec then [r] else concat rec)

distancias :: RoseTree a -> [Int]
distancias = foldRT (\_ rec ->if null rec then [1] else map (1+) (concat rec))

alturaRT :: RoseTree a -> Int
alturaRT = foldRT (\_ rec  -> if null rec then 1 else maximum rec + 1)