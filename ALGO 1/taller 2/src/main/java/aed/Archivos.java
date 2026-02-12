package aed;

import java.util.Scanner;
import java.io.PrintStream;

class Archivos {
    float[] leerVector(Scanner entrada, int largo) {
        float[] res = new float[largo];
        for (int i = 0; i < res.length; i++){
            res[i] = entrada.nextFloat();
        } 
        return res;
    }

    float[][] leerMatriz(Scanner entrada, int filas, int columnas) {
        float[][] res = new float[filas][columnas];
        for(int i = 0; i < res.length; i++){
            res[i] = leerVector(entrada, columnas);
        }
        return res;
    }

    String agregarRepetidos(String texto, int cantidad, String agregado){
        for (int i = 0; i < cantidad; i++){
                texto = texto + agregado;
        }
        return texto;
    }

    void imprimirPiramide(PrintStream salida, int alto) {
        for(int i = 1; i <= alto; i++){
            String asteriscos = agregarRepetidos("", 2*i -1, "*");
            String espacios = agregarRepetidos("", alto - i, " ");

            salida.println(espacios + asteriscos + espacios);
        }
    }
}
