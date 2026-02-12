def contarlineas(nombre_archivo: str) -> int:
    archivo = open(nombre_archivo+".txt", "r")
    res: int = len(archivo.readlines())
    archivo.close()
    return res
#print("ej1-1, exp 5: "+ str(contarlineas("ejemplo")))

def existePalabra(palabra: str, nombre_archivo: str) -> bool:
    archivo = open(nombre_archivo+".txt", "r")
    res: bool = False
    lineas = archivo.readlines()
    for lin in lineas:
        res = res or (palabra in lin)
    archivo.close()
    return res
#print("ej1-2, exp true: "+ str(existePalabra("proband","ejemplo")))#cumple especificacion

def esComentario(linea: str) -> bool:
    res: bool = True
    i: int = 0
    while(res == True and i<len(linea) and linea[i] != "#"):
        res = res and (linea[i] == "#" or linea[i] == " ")
        i += 1
    return res

def agregarSaltoDeLinea(lineas: list):
    for lin in lineas:
        lin = lin + "\n"

def clonarSinComentarios(nombre_archivo : str):
    archivo = open(nombre_archivo+".txt", "r")
    lineas = archivo.readlines()
    for lin in lineas:
        if(esComentario(lin)):
            lineas.remove(lin)
    agregarSaltoDeLinea(lineas)
    res = open("resEj2.txt", "w")
    res.writelines(lineas)
    archivo.close()
    res.close()
#clonarSinComentarios("ejemplo")
#ej2 = open("resEj2.txt", "r")
#print("ej2: " + str(ej2.read()) + " :fin ej2")
#ej2.close()

def revierteArchivo(nombre_archivo : str):
    archivo = open(nombre_archivo+".txt", "r")
    lineas = archivo.readlines()
    lineas2 = []
    i: int = len(lineas)-1
    while i >= 0: #creo que ya tenia fciones para revertir la lista pero son dos renglones anyways
        lineas2.append(lineas[i])
        i -= 1
    agregarSaltoDeLinea(lineas2)
    res = open("resEj3.txt", "w")
    lineas2[0] = lineas2[0] + "\n" #por algun motivo se lo tengo que dar manualmente
    res.writelines(lineas2) 
    archivo.close()
    res.close()
#revierteArchivo("ejemplo")
#ej3 = open("resEj3.txt", "r")
#print("ej3: " + str(ej3.read()) + " :fin ej3")
#ej3.close()

def agregarFraseAlFinal(nombre_archivo: str, frase: str):
    archivo = open(nombre_archivo+".txt", "w+") 
    lineas = archivo.readlines() #¿¿¿¿not readable???????????
    agregarSaltoDeLinea(lineas)
    lineas.append(frase)
    archivo.writelines(lineas)
    archivo.close()


def agregarFraseAlPrincipio(nombre_archivo : str, frase: str):
    archivo = open(nombre_archivo+".txt", "w+")
    lineas = archivo.readlines()
    lineas.insert(0,frase)
    archivo.writelines(lineas)
    archivo.close()

def esMayus(t: str) -> bool:
    res: bool = "A"<=t and t<="Z"
    return res

def esMinus(t: str) -> bool:
    res: bool = "a"<=t and t<="z"
    return res

def esNum(t: str) -> bool:
    res: bool = "0"<=t and t<="9"
    return res

def esEspaciado(t: str) -> bool:
    res: bool = " "==t or t=="_"
    return res

def esTexto(t: str) -> bool:
    res: bool = esMayus(t) or esMinus(t) or esNum(t) or esEspaciado(t)
    return res

def legiblesEnBinario(nombre_archivo : str) -> list: # probar
    archivo = open(nombre_archivo+".txt", "rb")
    lineas = str(archivo.readlines())
    i: int = 0
    res = []
    for lin in lineas:
        while i<len(lin):
            if esTexto(lin[i]):
                texto: str = ""
                while esTexto(lin[i]):
                    texto = texto + lin[i]
                    i += 1
                if len(texto)>=5:
                    res.append(texto)
            i += 1
    archivo.close()
    return res

def csvAListas(lineas: list) -> list:
    res: list = []
    for lin in range(len(lineas)):
        elemento: str = ""
        i: int = 0
        while i < len(lineas[lin]):
            elemento = elemento + lineas[lin][i]
            i += 1
            if(lineas[lin][i] == ","):
                res[lin] += [elemento]
                elemento = ""
                i += 1
    return res

def promedioLista(notas: list) -> float: # probar
    res = sum(notas)/len(notas)
    return res

def promedioEstudiante(lu : str) -> float:
    notas = []
    archivo = open("notas_alumnos_ej7.csv", "r")
    lineas = archivo.readlines()
    luYNotas = csvAListas(lineas) #pasa 'lineas' a una lista de listas, separando cada valor entre comas
    for lin in luYNotas:
        if(lin[0] == lu):
            notas.append(lin[len(lin)-1])
    res = promedioLista(notas)
    archivo.close()
    return res

#diccionarios
def agruparPorLongitud(nombre_archivo : str) -> dict: #funciona pero incluye el paso de linea '\n'
    archivo = open(nombre_archivo+".txt", "r")
    lineas = archivo.readlines()
    palabras = []
    res: dict = {}
    for lin in lineas:
        i: int = 0
        palabra: str = ""
        while i < len(lin):
            if lin[i] == " ":
                if len(palabra)>0:
                    palabras.append(palabra)
                palabra = ""
            else:
                palabra = palabra + lin[i]
            i += 1
        if len(palabra)>0:
            palabras.append(palabra)
    for pal in palabras:
        if str(len(pal)) in res:
            res[str(len(pal))] = res[str(len(pal))] + 1
        else:
            res[str(len(pal))] = 1
    print(palabras)
    archivo.close()
    return res
#print(str(agruparPorLongitud("ejemplo")))

def promediosEstudiantes (nombre_archivo: str) -> dict:
    archivo = open("notas_alumnos_ej7.csv", "r")
    lineas = archivo.readlines()
    luYNotas = csvAListas(lineas)
    res: dict = {}
    for nota in luYNotas:
        if not (nota[0] in res):
            res[nota[0]] = promedioEstudiante(nota[0])
    archivo.close()
    return res

def laPalabraMasFrecuente(nombre_archivo: str) -> str:
    archivo = open(nombre_archivo+".txt", "r")
    lineas = archivo.readlines()
    palabras = []
    #copio algoritmo de "agruparPorLongitud" para conseguir las palabras (arrastra problema con "\n")
    for lin in lineas:
        i: int = 0
        palabra: str = ""
        while i < len(lin):
            if lin[i] == " ":
                if len(palabra)>0:
                    palabras.append(palabra)
                palabra = ""
            else:
                palabra = palabra + lin[i]
            i += 1
        if len(palabra)>0:
            palabras.append(palabra)
    res: str = "" #no va
    #contar apariciones etc bla
    return res