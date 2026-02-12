package aed;

import java.util.*;

// Todos los tipos de datos "Comparables" tienen el método compareTo()
// elem1.compareTo(elem2) devuelve un entero. Si es mayor a 0, entonces elem1 > elem2
public class ABB<T extends Comparable<T>> implements Conjunto<T> {
    // Agregar atributos privados del Conjunto
    private Nodo _raiz;
    private int _cardinal;

    private class Nodo {
        T valor;
        Nodo izq;
        Nodo der;
        Nodo padre;

        Nodo(T v) {
            valor = v;
            izq = null;
            der = null;
            padre = null;
        }
    }

    public ABB() {
        _raiz = null;
        _cardinal = 0;
    }

    public int cardinal() {
        return _cardinal;
    }

    public T minimo(){
        Nodo actual = new Nodo(null);
        actual = _raiz;
        while (actual.izq != null){
            actual = actual.izq;
        }

        return actual.valor;
    }

    public T maximo(){
        Nodo actual = new Nodo(null);
        actual = _raiz;
        while (actual.der != null){
            actual = actual.der;
        }

        return actual.valor;
    }

    /*public void insertar(T elem){//_cardinal++
        Nodo nodo_buscado = buscar_nodo(elem);

        if(elem.compareTo(nodo_buscado.valor)<0){
            nodo_buscado.izq = new Nodo(elem);
            nodo_buscado.izq.padre = nodo_buscado;
        }else{
            nodo_buscado.der = new Nodo(elem);
            nodo_buscado.der.padre = nodo_buscado;
        }
        _cardinal++;
    }

    private Nodo buscar_nodo(T elem){
        Nodo actual = new Nodo(null);
        actual = _raiz;

        while (actual != null && actual.valor != elem){
            if(elem.compareTo(actual.valor)<0){
                if(actual.izq != null) {actual = actual.izq;}
            }else{
                if(actual.der != null) {actual = actual.der;}
            }
        }

        return actual;
    }*/

    public void insertar(T elem){

        if (!(pertenece(elem))) { //Siempre que el elemento no este

            if(_raiz == null) {    // Si esta vacio, agrego y es la raiz
                _raiz =  new Nodo(elem);

            } else { 
                Nodo actual = _raiz;

                while( !(esElUltimo(actual, elem))) { // Si no, llego al ultimo nodo antes de que se haga null
                    if(actual.valor.compareTo(elem) > 0) {
                        actual = actual.izq;
                    } else {
                        actual = actual.der;
                    }

                }

                if(actual.valor.compareTo(elem) > 0) { // Aca veo en cual meterlo como hijo
                    actual.izq = new Nodo(elem);
                    actual.izq.padre = actual;
                } else {
                    actual.der = new Nodo(elem);
                    actual.der.padre = actual;
                }

            }

            _cardinal = _cardinal + 1;
        }
    }

    public boolean esElUltimo(Nodo actual, T elem) { //Se fija (para insertar) si el de la izquierda o derecha es null dependiendo de elem
        boolean res = false;

        if(actual.valor.compareTo(elem) > 0) {
            if(actual.izq == null) {
                res = true;
            }
        } else {
            if(actual.der == null) {
                res = true;
            }
        }

        return res;
    }

    public boolean pertenece(T elem){
        boolean res = false;
        Nodo aux = new Nodo(null);
        aux = _raiz;
        while (aux != null && res == false){
            if (aux.valor.compareTo(elem) == 0){
                res = true;
            } else {
                if(elem.compareTo(aux.valor)<0){
                    aux = aux.izq;
                }else{
                    aux = aux.der;
                }
            }
        }

        return res;
    }

    public void eliminar(T elem){

        if(_raiz.valor.compareTo(elem) == 0 && _raiz.der == null && _raiz.izq == null) { //Raiz solo debo ver caso es raiz y hoja, y el caso si tiene un solo hijo
            _raiz = null;
            } else {
                if(_raiz.valor.compareTo(elem) == 0 && (_raiz.izq == null && _raiz.der != null) || (_raiz.der == null && _raiz.izq != null)) { //Es raiz y tiene un solo hijo
                    if(_raiz.izq == null) {
                        _raiz = _raiz.der;
                    } else {
                        _raiz = _raiz.izq;
                    }
                    _raiz.padre = null;

                } else {

            Nodo aEliminar = _raiz;

            while(aEliminar.valor.compareTo(elem) != 0) {
                if(aEliminar.valor.compareTo(elem) > 0) {
                    aEliminar = aEliminar.izq;
                } else {
                    aEliminar = aEliminar.der; //Encuentro el que quiero eliminar
                }
            }

            if(aEliminar.der == null && aEliminar.izq == null) { //Caso es hoja
                if (aEliminar.padre.der == aEliminar) {
                    aEliminar.padre.der = null;
                } else {
                    aEliminar.padre.izq = null;
                }
            } else {
                if((aEliminar.der == null && aEliminar.izq != null) || (aEliminar.izq == null && aEliminar.der != null)) {
                    if (aEliminar.padre.der == aEliminar) { //Caso es el derecho del padre
                        if(aEliminar.der != null) { 
                            aEliminar.padre.der = aEliminar.der;
                            aEliminar.der.padre = aEliminar.padre;
                        } else {
                            aEliminar.padre.der = aEliminar.izq;
                            aEliminar.izq.padre = aEliminar.padre;
                        }
                    } else { //Caso es el izquierdo del padre
                        if(aEliminar.der != null) {
                            aEliminar.padre.izq = aEliminar.der;
                            aEliminar.der.padre = aEliminar.padre;
                        } else {
                            aEliminar.padre.izq = aEliminar.izq;
                            aEliminar.izq.padre = aEliminar.padre;
                        }
                }
                } else { //El caso en que tiene dos hijos
                    Nodo predecesorInmediato = aEliminar.izq;

                    while(predecesorInmediato.der != null) {
                        predecesorInmediato = predecesorInmediato.der;
                    } 

                    aEliminar.valor = predecesorInmediato.valor;
                    
                    // De aca para abajo lo que hago es borrar al predesesor inmediato (Codigo exacto a lo de arriba)
                    
                    if(predecesorInmediato.der == null && predecesorInmediato.izq == null) { //Caso es hoja
                        if (predecesorInmediato.padre.der == predecesorInmediato) {
                            predecesorInmediato.padre.der = null;
                        } else {
                             predecesorInmediato.padre.izq = null;
                        }
                            } else {
                                if((predecesorInmediato.der == null && predecesorInmediato.izq != null) || (predecesorInmediato.izq == null && predecesorInmediato.der != null)) {
                                    if (predecesorInmediato.padre.der == predecesorInmediato) { //Caso es el derecho del padre
                                        if(predecesorInmediato.der != null) { 
                                            predecesorInmediato.padre.der = predecesorInmediato.der;
                                            predecesorInmediato.der.padre = predecesorInmediato.padre;
                                        } else {
                                            predecesorInmediato.padre.der = predecesorInmediato.izq;
                                            predecesorInmediato.izq.padre = predecesorInmediato.padre;
                                        }
                                            } else { //Caso es el izquierdo del padre
                                                if(predecesorInmediato.der != null) {
                                                predecesorInmediato.padre.izq = predecesorInmediato.der;
                                                predecesorInmediato.der.padre = predecesorInmediato.padre;
                                                } else {
                                                    predecesorInmediato.padre.izq = predecesorInmediato.izq;
                                                    predecesorInmediato.izq.padre = predecesorInmediato.padre;
                                                }
                                                }
                }
                 }


                    
                    
                }
            }

        }
        }
        _cardinal = _cardinal -1;

    }

    public String toString(){
        Iterador<T> it = this.iterador();
        StringBuffer res = new StringBuffer();
        res.append("{");

        while(it.haySiguiente()) {
            T actual = it.siguiente();
            res.append(actual.toString());

            if(actual != this.maximo()) {
                res.append(",");
            }


        }

        res.append("}");

        return res.toString();

    }

    private class ABB_Iterador implements Iterador<T> {
        private Nodo dedo;

        ABB_Iterador() {
            dedo = null;
        }

        public boolean haySiguiente() {
            boolean res = false;
            
            if(dedo == null && _raiz != null) { //Si el dedo es null y tiene raiz, entonces haysiguiente
                res = true;
            } else {
                if(dedo != null && _raiz != null) { //Si el dedo no es null y la raiz no esta vacia:
                    if(dedo.der != null) { //Si dedo tiene derecha, entonces haySiguiente
                        res = true;
                    } 
                    Nodo actual = dedo;

                    while(actual != null && !(res)) {
                        if(actual.valor.compareTo(dedo.valor) > 0) { // Si el valor del actual es mas grande que el valor del dedo haySiguiente
                            res = true;
                        }

                        actual = actual.padre;
                        
                    }
                }

            }

            return res;
        }
    
        public T siguiente() {
            T res;
            Nodo actual;

            if(dedo == null) { // Busco el minimo si es el primer siguiente
                actual = _raiz;
                while(actual.izq != null) {
                    actual = actual.izq;
                }

                res = actual.valor;
                dedo = actual;

            } else{
                actual = dedo;

                if(dedo.der != null) { //Si tiene izquierda, me meto por ahi
                    actual = actual.der;
                    
                    while(actual.izq != null) {
                        actual = actual.izq;
                    }

                    res = actual.valor;
                    dedo = actual;
                } else { //El caso contrario, subo hasta que un padre sea mayor que él

                    while(actual.valor.compareTo(dedo.valor) <= 0) {
                        actual = actual.padre;
                    }

                    res = actual.valor;
                    dedo = actual;
                }


            }
        


            return res;
        }
    }

    public Iterador<T> iterador() {
        return new ABB_Iterador();
    }

}
