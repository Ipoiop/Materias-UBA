--Ej 3
esDivisible :: Integer -> Integer -> Bool
esDivisible n m | n - m == 0 = True
                | n - m < m = False
                | otherwise = esDivisible (n - m) m

--Ej 4
sumaImpares :: Integer -> Integer
sumaImpares n | n == 1 = 1
              | n > 1 = n_esimoImpar + sumaImpares (n - 1)
             where n_esimoImpar = 2*n-1

--Ej 5
medioFact :: Integer -> Integer
medioFact n | n <= 1 = 1
            | otherwise = n * medioFact (n-2)

--Ej 6

sumaDigitos :: Integer -> Integer
sumaDigitos 0 = 0
sumaDigitos n = mod n 10 + sumaDigitos (div n 10)

--Ej 7
todosDigitosIguales :: Integer -> Bool
todosDigitosIguales n | n < 100 = mod n 10 == div n 10 || n < 10
      | otherwise = mod n 10 == mod (div n 10) 10 && todosDigitosIguales (div n 10)

--Ej8
iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n i = mod (div n (10^((cantDigitos n) - i))) 10

cantDigitos :: Integer -> Integer
cantDigitos n | div n 10 == 0 = 1
              | otherwise = 1 + cantDigitos (div n 10)

--Ej16 
 -- a)
buscaDivisorDesde :: Integer -> Integer -> Integer
buscaDivisorDesde n i | mod n i == 0 = i 
                 | otherwise = buscaDivisorDesde n (i + 1)

menorDivisor :: Integer -> Integer
menorDivisor 1 = 1
menorDivisor n = buscaDivisorDesde n 2

 -- b)
esPrimo :: Integer -> Bool 
esPrimo n = menorDivisor n == n

 -- c)
algunDivisorIgual2 :: Integer -> Integer -> Integer -> Bool
algunDivisorIgual2 d b i | i == 2 = d == menorDivisor b
            | otherwise = d == buscaDivisorDesde b i || algunDivisorIgual2 d b (i-1)
--Dado un divisor de a, verifica igualdad con algun divisor de b

algunDivisorIgual1 :: Integer -> Integer -> Integer -> Bool
algunDivisorIgual1 a b j | j == 2 = algunDivisorIgual2 (menorDivisor a) b b
 | otherwise = algunDivisorIgual2 (buscaDivisorDesde a j) b b || algunDivisorIgual1 a b (j-1)
--Para cada divisor de a, verifica igualdad con divisores de b

sonCoprimos :: Integer -> Integer -> Bool
sonCoprimos a b = not (algunDivisorIgual1 a b a)

 -- d)
buscanEsimoPrimo :: Integer -> Integer -> Integer
buscanEsimoPrimo 2 _ = 3
buscanEsimoPrimo n i | esPrimo ((buscanEsimoPrimo (n-1) 2) + i) = i+ buscanEsimoPrimo (n-1) 2
                     | otherwise = buscanEsimoPrimo n (i + 2)

nEsimoPrimo :: Integer -> Integer
nEsimoPrimo 1 = 2
nEsimoPrimo n = buscanEsimoPrimo n 2





