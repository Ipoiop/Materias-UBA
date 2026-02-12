package aed;
public class Heap<T> {
    private T[] arr;

    public Heap(T[] t) { // A completar por Sofi uwu
        arr = (T[]) new Object[0]; // Borrar esto, lo puse para que no salte error jsjsj
    }

    public Heap() { //Otro inicializador pero este te lo crea vacio
        arr = (T[]) new Object[0];
    }

    public T maximo() {
        T res = arr[0];

        return res;
    }

    public void cambiarValorMaximo(T nuevoMax) { //Cambia el valor maximo por el pasado como paramentro y reacomoda el heap (O(Log n))
        arr[0] = nuevoMax;

        //Y reacomodar todo el heap nuevamente

    }


}
