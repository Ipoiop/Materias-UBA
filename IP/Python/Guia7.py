import math

# Ejercicio1
#1
def raizDe2() -> float:
    res : float = round(math.sqrt(2), 4)
    print(str(res))
    return res
#raizDe2()

#2 
def imprimir_hola ():
    print("hola")
# imprimir_hola()

#4 a 7
def factorial_de_dos() -> int:
    res: int = 2*1
    return res

def factorial_3() -> int:
    res: int = 3*factorial_de_dos()
    return res

def factorial_4() -> int:
    res: int = 4*factorial_3()
    return res

def factorial_5() -> int:
    res: int = 5*factorial_4()
    return res
# print(str(factorial_5()))


# Ejercicio 2
#1 
# nombre: str = (input("Nombre? "))
def imprimir_saludo(nom: str):
    print("Hola " + nom)
# imprimir_saludo(nombre)

#2
def raiz_cuadrada_de(n: int) -> float:
    res: float = math.sqrt(n)
    return res

#3
# estribillo: str = input("Estribillo? ")
def imprimir_dos_veces(estr: str):
    estr = estr*2
    print(estr)
# imprimir_dos_veces(estribillo)

#4
def es_multiplo_de(n: int, m: int) -> bool:
    res: bool = n == 0 or n % m == 0 
    return res

#5
def es_par(n) -> bool:
    res: bool = es_multiplo_de(n, 2)
    return res

def cantidad_de_pizzas(comensales: int, min_cant_de_porciones: int) -> int:
    if(es_multiplo_de((comensales* min_cant_de_porciones), 8)):
        sobra: int = 0
    else:
        sobra: int = 1
    res: int = sobra + (comensales* min_cant_de_porciones) // 8
    return res

#Ejercicio 4
#1
def alguno_es_0(a: float, b: float) -> bool:
    res: bool = a == 0 or b == 0
    return res

def ambos_son_0(a: float, b: float) -> bool:
    res: bool = a == 0 and b == 0
    return res

#Ejercicio 4
def metros_a_centimetros(m: float) -> int:
    res: int = int(m* 100)
    return res

#Recibe altura en metros y devuelve peso en kg
def peso_pino(metros: float) -> int:
    if(max(3, metros) == 3):
        res: int = 3* metros_a_centimetros(metros)
    else:
        res: int = 3* metros_a_centimetros(3) + 2* metros_a_centimetros(metros - 3)
    return res

def es_peso_util(peso: int) -> bool:
    res: bool = min(400, peso) == 400 and max(1000, peso) == 1000
    return res

def sirve_pino(altura_pino: float) -> bool:
    res: bool = es_peso_util(peso_pino(altura_pino))
    return res

#ejercicio 6
def uno_al_diez():
    i: int = 1
    while(i <= 10):
        print("Número: " + str(i))
        i += 1

def ecos():
    i: int = 1
    while(i <= 10):
        print("eco")
        i += 1

def cohete(inicio: int):
    while(inicio > 0):
        print(inicio)
        inicio -= 1
    print("Despegue")

#Ejercicio 7
def cohete_for(inicio: int):
    for i in range(inicio, 0, -1):
        print(i)
    print("Despegue")
