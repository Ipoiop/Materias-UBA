#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>
#include <list>
#include <tuple> //get<0>
using namespace std;

int inf = INT_MAX;//Infinito positivo
vector<list<tuple<int,int>>> l_ady; //Vector de adyacencia pesada
vector<list<int>> t_espera; //Vector de tiempos de espera


int viaje_mas_corto(){ // hay ciclos no negativos
    return 0;
}

int main () {
    int nodos, aristas;
    cin >> nodos >> aristas;
    t_espera.resize(nodos);
    l_ady.resize(nodos);

    for(int i=0; i<aristas; i++){ // portales
        int a, b, c;
        cin >> a >> b >> c;
        l_ady[a].push_back(make_tuple(b, c));
        l_ady[b].push_back(make_tuple(a, c));
    }

    for(int p=0; p<nodos; p++){   // tiempos de espera
        int cant;
        cin >> cant;
        for(int i = 0; i<cant; i++){
            int t;
            cin >> t;
            t_espera[p].push_back(t);
        }
    }

    int res = viaje_mas_corto();
    
    cout << res;
    
    return 0;
}