#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>
#include <queue>
using namespace std;

int camino_mas_corto_misterioso(int n, int m){
    int inicio = min(n,m)/2; //minimo del intervalo que contiene todos los nodos utiles
    int destino = max(n,m)+1; //maximo del intervalo
    queue<int> lista;
    lista.push(n); //tomo n como raiz
    bool encontro = false;
    vector<int> distancias(destino+1);
    distancias[n] = 0;

    while (not(encontro)){
        int i = lista.front();
        int rojo = i*2;
        int azul = i-1;
        if (rojo<=destino && distancias[rojo]==0){ //rojo es vecino
            lista.push(rojo);
            distancias[rojo] = distancias[i]+1;
        } 
        if (azul>=inicio && distancias[azul]==0){ //azul es vecino
            lista.push(azul);
            distancias[azul] = distancias[i]+1;
        } 
        if(azul == m || rojo == m){
            encontro = true;
        }
        lista.pop();
    }

    return distancias[m];
}

int greedy(int inicio, int destino){
    int res = 0;
    if (destino<=inicio){
        res = inicio - destino;
    }
    if (destino % 2 == 1){
        res = 1 + greedy(inicio, destino+1);
    }else{
        res = 1 + greedy(inicio, destino/2);
    }
    return res;
}

int main () {
    int n, m;

    cin >> n >> m;

    int res = camino_mas_corto_misterioso(n, m);
    
    cout << res;
    
    return 0;
}