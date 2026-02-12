package aed;

public class ListaEnlazada<T>{
    private Nodo primero;

    private class Nodo {
        T valor;
        Nodo sig;

        Nodo(T v) {
            valor = v;
        }

    }

    public ListaEnlazada() {
        primero = null;
    }

    public int longitud() {
        int contador = 0;
        Nodo actual = primero;

        if (primero != null) {  // Porque si primero es null entonces ya la longitud es 0
            contador = 1;
            while(actual.sig != null) {
                actual = actual.sig;
                contador = contador + 1;
            }
        }

        return contador;
    }

    public void agregar(T elem) {
        Nodo nuevo = new Nodo(elem);

        nuevo.sig = primero; //El siguiente elem sera nuevo

        primero = nuevo;
    }

}
