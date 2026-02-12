package aed;

public class DictAcotado<Integer, T> {
    private T[] dict;
    private int size;

    public DictAcotado(int tamaño) {
        dict = (T[]) new Object[tamaño];
        size = tamaño;
    }

    public void definir(int k, T valor) { //Requiere que 0 <= k < dict.lenght
        dict[k] = valor;
    }

    public boolean esta(int k) {
        boolean res = dict[k] != null;

        return res;
    }

    public T obtener(int k) { //Requiere que k este
        T res;
        res = dict[k];

        return res;

    }

        public int tamaño(){
        int res = size;
        
        return res;
    }
/* 
    public static void main(String args[]) {
        DictAcotado<Integer, String> dict;
        dict = new DictAcotado<>(10);
        dict.definir(0, "Hola");
        System.out.println(dict.esta(1));
        
        }
*/

}
