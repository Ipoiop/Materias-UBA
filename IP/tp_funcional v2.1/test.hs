import Test.HUnit
import Solucion

main = runTestTT tests



tests = test [
    --1. NombresDeUsuarios
    "Caso General" ~: (nombresDeUsuarios redGeneral)  ~?= ["Jose","Maria","Pedro","Teresa","Osvaldo","Yuliana","Raquel","Gabriel"],

    "Nombre Repetido" ~: (nombresDeUsuarios redUsRepetidos)  ~?= ["Jose","Maria","Pedro","Teresa","Osvaldo","Yuliana","Raquel","Gabriel"],

    "Red sin usuarios" ~: (nombresDeUsuarios redSinUsuarios)  ~?= [],

    "Red Vacia" ~: (nombresDeUsuarios redVacia)  ~?= [],

   --2.AmigosDe
   "Caso General" ~: (amigosDe redGeneral us3)  ~?= [us2,us4,us7],

   "Sin amigos" ~: (amigosDe redGeneral us6)  ~?= [],

   "Red sin relaciones"  ~: (amigosDe redSinRelaciones us6)  ~?= [],

   "Red Espejada" ~: (amigosDe redEspejada us3)  ~?= [us2,us4,us7],

   --3.CantidadDeaAmigos
   "Caso General"  ~: (cantidadDeAmigos redGeneral us3)  ~?= 3,

   "Sin Amigos" ~: (cantidadDeAmigos redGeneral us6)  ~?= 0,

   "Red sin relaciones"  ~: (cantidadDeAmigos redSinRelaciones us6)  ~?= 0, 
   
   --4.UsuarioConMasAmigos
   "Caso General" ~: (usuarioConMasAmigos redGeneral)  ~?= us3, 

   "Sin Relaciones" ~: (usuarioConMasAmigos redSinRelaciones)  ~?= us2, --como no hay relaciones, devuelve el primero por default
   
   "Dos con la misma cantidad" ~: (usuarioConMasAmigos redMismaCantidadDeAmigos)  ~?= us3,

   --5.estaRobertoCarlos
   "Caso General"  ~: (nRobertoCarlos redGeneral 2)  ~?= True,

   "Cantidad exacta"  ~: (nRobertoCarlos redGeneral 3)  ~?= False,

   "Dos con la misma cantidad"  ~: (nRobertoCarlos redMismaCantidadDeAmigos 2)  ~?= True,
 
   --6.publicacionesDe
   "Caso General"  ~: (publicacionesDe redGeneral us5)  ~?= publicaciones5,
   
   "Usuario sin publicaciones"  ~: (publicacionesDe redGeneral us3)  ~?= [],

   "Red sin publicaciones"  ~: (publicacionesDe redSinPublicaciones us5)  ~?= [],

   "Dos publicaciones iguales"  ~: (publicacionesDe redParDePublicacionesIgual us5)  ~?= ,
   --Con distinto autor

   --7.publicacionesQueLeGustanA
   "Caso General"  ~: (publicacionesQueLeGustanA redGeneral us9)  ~?= [post6, post7]

   --10.existeSecuenciaDeAmigos
   "Caso General"  ~: (existeSecuenciaDeAmigos redGeneral us2 us5)  ~?= True, 
   --Hay una cadena de relaciones entre us2 y us5

   "Caso Simetrico"  ~: (existeSecuenciaDeAmigos redGeneral us5 us2)  ~?= True,
   --El input de usuarios al reves que el caso general

   "Relación directa"  ~: (existeSecuenciaDeAmigos redGeneral us8 us9)  ~?= True
   --Hay us8 y us9 estan relacionados

   "Red Espejada"  ~: (existeSecuenciaDeAmigos redEspejada us2 us5)  ~?= True,

   --""  ~: ()  ~?=
   
 ]

expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)


--variables

usuariosVacio = []
relacionesVacio = []
publicacionesVacio = []
redVacia = ([],[],[])
-- Aclaración: existen casos donde la especificación permite el uso de una red vacia 
{-(pd de ivo: me parece que red vacia no es valido. 
En un principio pusimos listas vacias porque algunos ejercicios no toman en cuenta las relaciones o publicaciones de la red
 pero al final usamos las generales para esos casos)
pd de ivo 2: Borren mis posdatas-}

--casos Genericos 
--Conjunto de casos sin grandes particularidades, que sirven para demostrar el funcionamiento propio de las funciones
redGeneral = (usuariosGeneral, relacionesGeneral, publicacionesGeneral)
usuariosGeneral = [us2, us3, us4, us5, us6, us7, us8, us9]
relacionesGeneral = [(us2,us3), (us3,us4), (us4,us5), (us3,us7), (us8,us9)]
publicacionesGeneral = [post1, post2, post3, post4, post5, post6, post7]

us1 = (1, "Jose")
us2 = (2, "Jose")
us3 = (3, "Maria")
us4 = (4, "Pedro")
us5 = (5, "Teresa")
us6 = (6, "Osvaldo")
us7 = (7, "Yuliana")
us8 = (8, "Raquel")
us9 = (9, "Gabriel")

post1 = (us2, "post 1", [us2, us3])
post2 = (us2, "post 2", [us2, us3])
post3 = (us5, "post 3", [])
post4 = (us5, "post 4", [])
post5 = (us5, "post 5", [])
post6 = (us8, "post 6", [us9])
post7 = (us8, "post 7", [us9])

--Casos especificos
--Variables utilizadas como parte del test suite de un ejercicio especifico

--ejercicio 1 
usuariosRepetidos = [us1, us2, us3, us4, us5, us6, us7, us8, us9]

redUsRepetidos = (usuariosRepetidos, relacionesGeneral, publicacionesGeneral)
--red social que contiene un usuario con el mismo nombre que otro, bajo distinta ID

redSinUsuarios = (usuariosVacio, relacionesGeneral, publicacionesGeneral)

--ejercicio 2 
redEspejada =  (usuariosGeneral, relacionesEspejadas, publicacionesGeneral)

relacionesEspejadas = [(us3,us2), (us4,us3), (us5,us4), (us7,us3), (us9,us8)]
--es una red que contiene el otro lado de las relaciones simetricas de la red General (x1 pasa a ser x2 y x2 pasa a x1)    

--ejercicio 3 
redSinRelaciones = (usuariosGeneral, relacionesVacio, publicacionesGeneral)

--ejercicio 4
mismaCantidadDeRelaciones = [(us2,us3), (us3,us4), (us4,us5), (us3,us7), (us8,us9), (us4,us2)]

redMismaCantidadDeAmigos = (usuariosGeneral, mismaCantidadDeRelaciones, publicacionesGeneral )

--ejercicio 6
publicaciones5 = [post3, post4, post5]

redSinPublicaciones = (usuariosGeneral, relacionesGeneral, publicacionesVacio)

publicacionIgualA_post4 = (us4, "post 4", [])

publicacionesUnParIgual =  [post1, post2, post3, post4, post5, post6, post7, publicacionIgualA_post4]

redParDePublicacionesIgual = (usuariosGeneral, relacionesGeneral, publicacionesUnParIgual)

--ejercicio 7
