-- Completar con los datos del grupo
--
-- Nombre de Grupo: xx
-- Integrante 1: Nombre Apellido, email, LU
-- Integrante 2: Nombre Apellido, email, LU
-- Integrante 3: Nombre Apellido, email, LU
-- Integrante 4: Nombre Apellido, email, LU

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas

usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id 

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejercicios

nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios = undefined

-- describir qué hace la función: .....
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe = undefined

-- describir qué hace la función: .....
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red u = longitud (amigosDe red u)

-- describir qué hace la función: .....

--buscaUsuarioConMasAmigos :: RedSocial -> [Usuario] -> Usuario
--buscaUsuarioConMasAmigos _ [u] = u
--buscaUsuarioConMasAmigos r (u:us) | cantidadDeAmigos r u >= cantidadDeAmigos r (head us) = 
--                                     buscaUsuarioConMasAmigos r (u: (tail us))
--                                  | otherwise = buscaUsuarioConMasAmigos r us

usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos ([u], _, _) = u
usuarioConMasAmigos ((u:us), rs, ps) 
   | cantidadDeAmigos red u >= cantidadDeAmigos red (head us) = usuarioConMasAmigos ((u: (tail us)), rs, ps)
   | otherwise = usuarioConMasAmigos (us, rs, ps)
   where red = ((u:us), rs, ps)

--usuarios: [(1,a), (2,b), (3,c), (4,d), (5,e), (6,f), (7,g), (8,h), (9,i), (10,j)]
--          [(1,a)] sin relaciones
--relaciones: 
-- [((2,b),(3,c)), ((3,c),(4,d)), ((4,d),(5,e)), ((8,h),(2,b)), ((8,h),(7,g)), ((2,b),(10,j))]
-- [] no hay relaciones
-- [((2,b),(3,c)), ((3,c),(4,d)), ((4,d),(5,e))]
-- [((2,b),(3,c)),((4,d),(5,e))]
--publicaiones da igual ya que no se usan en estas funciones

-- describir qué hace la función: ..... La función compara la cantidad de amigos de dos usuarios
--    de la red, de manera recursiva, eligiendo el que tenga más; hasta que se acabe la lista
--    y solo queda el que más amigos tiene.

nRobertoCarlos :: RedSocial -> Integer -> Bool
nRobertoCarlos red n = cantidadDeAmigos red (usuarioConMasAmigos red) > n

estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = nRobertoCarlos red 1000000

--para testear todo habria que tener usuarios con 1m de amigos o cambiar el parámetro.
-- usar el anterior con paramteros 1 y 3

-- describir qué hace la función: .....
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe = undefined

-- describir qué hace la función: .....
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA = undefined

-- describir qué hace la función: .....
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones u1 u2 = mismosElementos (publicacionesQueLeGustanA u1) (publicacionesQueLeGustanA u2)

-- describir qué hace la función: .....
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel = undefined

-- describir qué hace la función: .....
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos = undefined
