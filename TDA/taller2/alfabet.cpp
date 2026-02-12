#include <iostream>
#include <vector>
#include <string>
#include <climits>
#include <algorithm>
using namespace std;

long long infinito = LONG_LONG_MAX;

long long ord_alfabeticamente(int i, string ult, vector<long long> &cost, vector<string> &palabras, vector<long long> &memo){ //sin el int???
    if(i == palabras.size()){
        return 0;
    }

    string actual = palabras[i];
    string invert = string(actual.rbegin(), actual.rend());
    

    long long res1 = infinito;
    long long res2 = infinito;
    
    
    if(memo[i*2] != -1){ // no lo invierto
        res1 = memo[i*2];
    } else if (ult<=actual){
        res1 = ord_alfabeticamente(i+1, actual, cost, palabras, memo);
        memo[i*2] = res1;
    }
    
    
    if(memo[1+ i*2] != -1){ // lo invierto
        res2 = memo[1+ i*2];
    } else if (ult<=invert){
        res2 = ord_alfabeticamente(i+1, invert, cost, palabras, memo);
        if(res2 != infinito){
            res2 += cost[i];
        }
        memo[1+ i*2] = res2;
    }
    
    long long res = min(res1, res2);
    return res;
}


int main () {
    int cant;
    cin >> cant;
    vector<long long> cost(cant, 0);
    vector<string> palabras(cant, "");
    vector<long long> mem(cant*2, -1);
    
    for(int i = 0; i < cant; i++) {
        cin >> cost[i];
    }
    for(int i = 0; i < cant; i++) {
        cin >> palabras[i];
    }
    long long res = ord_alfabeticamente(0, "", cost, palabras, mem);
    if (res == infinito){
        res = -1;
    }
    cout << res;
    
    return 0;
}