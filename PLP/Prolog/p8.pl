%ej1

padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).

padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

hijo(X,Y) :- padre(Y,X).

hermano(X,Y) :- padre(X,Z), padre(Y,Z).

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(X,Z), descendiente(Z,Y). %se cuelga? no

%ej3

natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

%ej4

%juntar(?Lista1,?Lista2,?Lista3) == append
juntar([],YS,YS).
juntar([X|XS],YS,[X|L]) :- juntar(XS,YS,L).

%ej5
%last2(?L, ?U)
last2(L, U) :- append(_, [U], L).

%reverse(+L, ?R)
reverse2([], []).
reverse2([X|L], R) :- reverse2(L, R1), append(R1, [X], R).

%prefijo(?P, +L)
prefijo(P,L) :- append(P,_,L).

%sufijo(?S, +L)
sufijo(S,L) :- append(_,S,L).

%sublista(?S, +L)
sublista(S,L) :- sufijo(P,L), prefijo(S,P), S \= [].

%pertenece(?X, +L) == member
pertenece(X,L) :- append(_,[X|_],L).

%ej6
%aplanar(+Xs, -Ys)
aplanar([], []).
aplanar([X|XS], [X|YS]) :- atom(X), aplanar(XS, YS).
aplanar([X|XS], [X|YS]) :- number(X), aplanar(XS, YS).
aplanar([X|XS], YS) :- is_list(X), aplanar(X, Y), append(Y, YS2, YS), aplanar(XS, YS2).

%ej7
%interseccion(+L1, +L2, -L3)
interseccion([],_,[]).%repiten
interseccion([X|L1], L2, [X|L3]) :- 
    member(X,L2), interseccion(L1,L2,L3b), borrar(L3b, X, L3).
interseccion([X|L1], L2, L3) :- 
    not(member(X,L2)), interseccion(L1,L2,L3).

%partir(N, L, L1, L2) todo con ? pq usa length y append que son reversibles
partir(N, L, L1, L2) :- length(L, M), append(L1, L2, L), length(L1, N), M>=N.

%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([],_,[]).
borrar([X|XS], X, YS) :- borrar(XS, X, YS).
borrar([Y|XS], X, [Y|YS]) :- borrar(XS, X, YS), Y \= X.

%sacarDuplicados(+L1, -L2)
sacarDuplicados([],[]).
sacarDuplicados([X|XS],[X|YS]) :- borrar(XS, X, XS2), sacarDuplicados(XS2,YS).

%permutacion(+L1, ?L2)
permutacion([],[]).
permutacion([X|XS], P) :- permutacion(XS,Q), insertar(X,Q,P).

%insertar(?X, ?L, ?LX)
insertar(X,L,LX) :- append(A,B,L), append(A,[X|B],LX).

%permutacion2(+L1, +L2)


%reparto(+L, +N, -LListas)
reparto(L,1,[L]).
reparto(L,N,[X|LListas]) :- N>1, append(X,Y,L), N2 is N-1, 
                            reparto(Y,N2,LListas), length(LListas,N2).

%repartoSinVacias(+L, -LListas) mal
repartoSinVacias([],[[]]).
repartoSinVacias(L,[X|LListas]) :- append(X,Y,L), repartoSinVacias(Y,LListas), 
                                   length(L, N), length(LListas, N2), N2<N.

%ej9
%desde(+X, -Y)
desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

%desdeReversible(+X,?Y)
desdeReversible(X,Y) :- nonvar(Y), X=<Y.
desdeReversible(X,Y) :- var(Y), desde(X,Y).

%ej11

vacio(nil).

%raiz(+A, ?R)
raiz(bin(_, R, _), R).

%altura(+A, ?X)
altura(nil,0).
altura(bin(I,_,D), X) :- altura(I,XI), altura(D,XD), X is 1+max(XI,XD).

%cantidadDeNodos(+A, ?X)
cantidadDeNodos(nil,0).
cantidadDeNodos(bin(I,_,D), X) :- 
    cantidadDeNodos(I,XI), cantidadDeNodos(D,XD), X is 1+XI+XD.

%ej12
%inorder(+AB,-Lista)
inorder(nil,[]).
inorder(bin(I,R,D),L) :- inorder(I,LI), inorder(D,LD), append(LI,[R|LD],L).

%arbolConInorder(+Lista,-AB)
arbolConInorder([],nil).
arbolConInorder(L,bin(I,R,D)) :- 
    append(LI,[R|LD],L), arbolConInorder(LI,I), arbolConInorder(LD,D).

%aBB(+T)
%aBB(T) :- altura(T,A), A<2.
%aBB(bin(I,R,D)) :- comparaABR(I,R), comparaABR(R,D), aBB(I), aBB(D). 

aBB(T) :- inorder(T,L), ordenadaADerecha(L).

%ordenadaADerecha(+L)
ordenadaADerecha(L) :- length(L,N), N<2.
ordenadaADerecha([X|[Y|L]]) :- X<Y, ordenadaADerecha([Y|L]).

%aBBInsertar(+X, +T1, -T2) a lo mejor es inversible en T2
aBBInsertar(X, nil, bin(nil,X,nil)).
aBBInsertar(X, bin(I,R,D), bin(I2,R,D)) :- X<R, aBBInsertar(X,I,I2). 
aBBInsertar(X, bin(I,R,D), bin(I,R,D2)) :- X>R, aBBInsertar(X,D,D2). 

%ej13
%coprimos(-X,-Y)
coprimos(X,Y) :- desde(2,S), paresQueSuman(S,X,Y), gcd(X,Y) =:= 1.

%paresQueSuman(+S, -X, -Y)
paresQueSuman(S,X,Y) :- between(1,S,X), Y is S-X.

%ej14
%cuadradoSemiMagico(+N, -XS)
cuadradoSemiMagico(N, XS) :- desde(0,S), cSMQueSuma(S,N,N,XS).

%cSMQueSuma(+S, +N, +M, -XS) N: cant. elementos que faltan ; M: length de XS
cSMQueSuma(_,N,_,[]) :- N=<0.
cSMQueSuma(S,N,M,[X|XS]) :- N>0, listaQueSuma(S,M,X), N2 is N-1, cSMQueSuma(S,N2,M,XS).

%listaQueSuma(+S, +M, -L) lista de m elementos
listaQueSuma(S, M, [S]) :- M=<1.
listaQueSuma(S,M,[X|L]) :- M>1, between(0,S,X), Y is S-X, M2 is M-1, listaQueSuma(Y,M2,L).

%cuadradoMagico(+N, -XS) generar semimagicos y me quedo con los magicos
cuadradoMagico(N, [X|XS]) :- cuadradoSemiMagico(N,[X|XS]), sum_list(X,S), columnasSuman([X|XS],S).

%columnasSuman(+XS, +S) verifica que todas las columnas suman S
columnasSuman(_,_).



%ej16
frutal(frutilla).
frutal(banana).
frutal(manzana).
cremoso(banana).
cremoso(americana).
cremoso(frutilla).
cremoso(dulceDeLeche).

leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X,Y) :- leGusta(X), leGusta(Y).

% cucurucho(X,Y)
%   leGusta(X)
%       frutal(X)
%           X=frutilla
%       leGusta(Y)
%           frutal(Y)
%               Y=frutilla
%               Y=banana
%               Y=manzana

%ej17
% I. el primer Y que satisface P, y no satisface Q.
% II. todos los Y que no satisfacen Q y si P.
% III. P(Y), not(P(Q)), Y \= Q.

%ej18
%corteMasParejo(+L,-L1,-L2)
corteMasParejo(L, L1, L2) :- append(L1,L2,L), sum_list(L1,S1),
    sum_list(L2,S2), D is abs(S1-S2), not(hayCorteMejor(D,L)).

%hayCorteMejor(+D, +L)
hayCorteMejor(D,L) :- append(L1,L2,L), sum_list(L1,S1),
    sum_list(L2,S2), D2 is abs(S1-S2), D2<D.

%ej20
%proximoNumPoderoso(+X,-Y) al usar cut me quedo con el primero que funciona
proximoNumPoderoso(X,Y) :- X1 is X+1, desde(X1,Y2), esNumPoderoso(Y2), Y = Y2, !.

%esNumPoderoso(+Y) arreglar!!!!
esNumPoderoso(X) :- divisor(X,Y), Y>1, X mod (Y*Y) =:= 0, esPrimo(Y).

%divisor(+X, ?Y)
divisor(X,Y) :- var(Y), between(1,X,Y), X mod Y =:= 0.
divisor(X,Y) :- nonvar(Y), X mod Y =:= 0.

%esPrimo(+X)
esPrimo(X) :- X>1, not(tieneDivisores(X)).

tieneDivisores(X) :- divisor(X,Y), Y<X, Y>1.