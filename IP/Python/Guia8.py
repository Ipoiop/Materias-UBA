import array 
import math

def pertenece(e, s) -> bool:
    res: bool = False
    for i in range(len(s)):
        res = res or s[i] == e
    return res

def pertenecePiola(e, s) -> bool:
    res: bool = s.count(e)>0
    return res
#lista1 = [1,2,3,4]
#cha = 'holaj'
#print(pertenece(lista1, 3))
#print(pertenece(lista1, 5))
#print(pertenece(cha, 'h'))
#print(pertenece(cha, 'o'))
#print(pertenece(cha, 'j'))
#print(pertenece(cha, 'p'))

def divideATodos(s: list, e: int) -> bool:
    res: bool = True
    for  i in range(len(s)):
        res = res and s[i] % e == 0
    return res

def sumaTotal(s: list) -> int:
    res: int = 0
    for num in s:
        res = res + s[num]
    return res

def ordenados(s: list) -> bool:
    res: bool = True
    for i in range(len(s) -1):
        res = res and s[i] <= s[i+1]
    return res

def esPalindroma(t: str) -> bool:
    res: bool = t == reversed(t)
    return res

def banco(ss: list) -> int:
    saldo: int = 0
    for i in range(len(ss)):
        if (ss[i][0] == 'I'):
            saldo = saldo + ss[i][1]
        if (ss[i][0] == 'R'):
            saldo = saldo - ss[i][1]
    return saldo

def cant_elem_en_comun(s, t) -> int:
    res: int = 0
    for elem in s:
        if(pertenece(elem, t)):
            res = res + 1
    return res

#Ejercicio 2
def es_multiplo_de(n: int, m: int) -> bool:
    res: bool = n == 0 or n % m == 0 
    return res

def es_par(n) -> bool:
    res: bool = es_multiplo_de(n, 2)
    return res

def pares_a_0(s: list):
    for i in range(len(s)):
        if(es_par(s[i])):
            s[i] = 0

def pares_a_0_2(s: list) -> list:
    res = s.copy()
    for i in range(len(res)):
        if(es_par(res[i])):
            res[i] = 0
    return res

def sin_vocales(t: str) -> str:
    res: str = ''
    vocales = "aeiouAEIOUáéíóúÁÉÍÓÚ"
    for i in range(len(t)):
        if (pertenece(t[i], vocales)):
            res += ''
        else:
            res += t[i]
    return res

def reemplazaVocales(t: str) -> str:
    res: str = ''
    vocales = "aeiouAEIOUáéíóúÁÉÍÓÚ"
    for i in range(len(t)):
        if (pertenece(t[i], vocales)):
            res += ' '
        else:
            res += t[i]
    return res

def daVueltaStr(s: str) -> str:
    res: str = ''
    for i in range(len(s)-1,-1,-1):
        res += s[i]
    return res

def listudiantes() -> list:
    res: list = []
    estudiante: str = str(input("Nombre: "))
    while(estudiante != "listo"):
        res += [estudiante]
        estudiante = str(input("Nombre: "))
    print(res)
    return res

def sube():
    res = []
    r: str = input("C para cargar, D para descontar, X para finalizar: ")
    #no considera mal input
    while(r != "X"):
        res += [(r, input("Monto a cargar/descargar: "))]
        r = input("C para cargar, D para descontar, X para finalizar: ")
    print(str(res))
    return res

import random

def sietemedio():
    res = []
    carta: int = random.randint(1,12)
    accion = 'carta'
    while(accion == 'carta'):
        if(carta != 8 and carta != 9):
            res += [carta]
            accion = input("'carta' para seguir, otra cosa para parar: ")
        carta = random.randint(1,12)
    total: float = 0
    figuras = [10,11,12]
    for num in res:
        if(pertenece(num, figuras)):
            total += 0.5
        else:
            total += num
    if(total > 7):
        print("Perdiste")
        print(total)
        print(res)
    else:
        print("Ganaste")
        print(total)
        print(res)
    return res

#Ejercicio4
def perteneceACadaUno(e: int, ss: list) -> list:
    res: list = []
    for lista in ss:
        res += [pertenece(e, lista)]
    return res

def esMatriz(ss: list) -> bool:
    res = True
    for lista in ss:
        res = res and len(ss[0]) == len(ss[lista])
    return res

def filasOrdenadas(m: list) -> list:
    res = []
    if(esMatriz(m)):
        for i in m:
            res += [ordenados(m[i])]
    return res

