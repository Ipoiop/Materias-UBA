#include <iostream>
#include <vector>
#include <string>
#include <climits>
#include <algorithm>
using namespace std;

int infinito = INT_MAX;
string pal = "";
vector <vector <int>> memo;

int borrar_min(int ini, int fin){
    if(ini>fin){
        return 0;
    }
    int res;
    if(memo[ini][fin] != -1){
        res = memo[ini][fin];
    }else{
        res = 1+borrar_min(ini+1, fin);

        for(int i = ini+1; i<=fin; i++){
            if(pal[ini] == pal[i]){
                int res2 = borrar_min(ini+1, i-1) + borrar_min(i, fin);
                res = min(res, res2); // como el res++ suma 1 por eliminar el substring con los elementos == a pal[ini], los salteo aca
            }
        }

        memo[ini][fin] = res;
    }
    return res;
}

int comprimir(string palabra, int largo){
    int longitud = 1;
    for(int i = 1; i<largo; i++){
        if(pal.back() != palabra[i]){
            pal += palabra[i];
            longitud++;
        }
    }
    return longitud;
}

int main () {
    string palabra;
    int largo;

    cin >> largo >> palabra;

    
    pal += palabra[0];
    int longitud = comprimir(palabra, largo);
    memo.assign(longitud, vector<int>(longitud, -1));
    for(int i=0; i<longitud; i++){
        memo[i][i] = 1;
    }
    int res = borrar_min(0, longitud-1);
    
    cout << res;
    
    return 0;
}