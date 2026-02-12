package aed;

import java.util.*;

public class ListaEnlazada<T> implements Secuencia<T> {
    // Completar atributos privados
    private Nodo prim;
    private Nodo ulti;


    private class Nodo {
        private T dato;
        private Nodo sig;
        private Nodo ant;

        private Nodo(T e){
            this.dato = e;
            this.sig = null;
            this.ant = null;
        }
    }

    public ListaEnlazada() {
        prim = null;
        ulti = null;
    }

    public int longitud() {
        int i = 0;
        Nodo aux = prim;

        while (aux != null){
            aux = aux.sig;
            i++;
        }
        return i;
    }

    public void agregarAdelante(T elem) {
        Nodo nuevo = new Nodo(elem);

        if (prim == null){
            prim = nuevo;
            prim.ant = null;
            ulti = nuevo;
            ulti.sig = null;
        } else {
            nuevo.sig = prim;
            prim = nuevo;
            prim.sig.ant = prim;
        }
    }

    public void agregarAtras(T elem) {
        Nodo nuevo = new Nodo(elem);

        if (ulti == null){
            prim = nuevo;
            prim.ant = null;
            ulti = nuevo;
            ulti.sig = null;
        } else {
            nuevo.ant = ulti;
            ulti = nuevo;
            ulti.ant.sig = ulti;
        }
    }

    public T obtener(int i) {
        Nodo aux = prim;
        
        for(int it = 0; it < i; it++){
            aux = aux.sig;
        }
        return aux.dato;
    }

    public void eliminar(int i) {
        Nodo actual = prim;
        Nodo previo = prim;
        for(int j = 0; j < i; j++){
            previo = actual;
            actual = actual.sig;
        }

        if(i == 0){
            prim = actual.sig;
        } else {
            previo.sig = actual.sig;
        }
    }

    public void modificarPosicion(int indice, T elem) {
        Nodo actual = prim;
        for(int j = 0; j < indice; j++){
            actual = actual.sig;
        }

        actual.dato = elem;
    }

    public ListaEnlazada<T> copiar() {
        ListaEnlazada<T> res = new ListaEnlazada<>();
        Nodo actual = prim;

        while(actual != null){
            res.agregarAtras(actual.dato);
            actual = actual.sig;
        }

        return res;
    }

    public ListaEnlazada(ListaEnlazada<T> lista) {
        Nodo actual = lista.prim;
        while(actual != null){
            agregarAtras(actual.dato);
            actual = actual.sig;
        }
    }
    
    @Override
    public String toString() {
        String res = "[";
        Nodo actual = prim;

        while(actual != null){
            if(actual == ulti){
                res = res + actual.dato.toString();
            }else{
                res = res + actual.dato.toString() + ", ";
            }
            actual = actual.sig;
        }

        return res + "]";
    }

    private class ListaIterador implements Iterador<T> {
    	// Completar atributos privados
        int pos;
        ListaIterador(){
            pos = 0;
        }

        public boolean haySiguiente() {
	        return pos != longitud();
        }
        
        public boolean hayAnterior() {
	        return pos != 0 && pos <= longitud();
        }

        public T siguiente() {
	        int i = pos;

            pos = pos + 1;

            return obtener(i);
        }
        

        public T anterior() {
	        int i = pos;

            pos = pos - 1;

            return obtener(i-1);
        }
    }

    public Iterador<T> iterador() {
	    return new ListaIterador();
    }

}
