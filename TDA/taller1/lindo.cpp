#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
using namespace std;

int l_todo(string s, char l, int j, int k) {
    int res = 0;
    for(int i = j; i <= k; i++){
        if (s[i] != l) res++;
    }

    return res;
}

char sig_minuscula(char l) {
    if (l == 'z') {
        return 'a';
    } else {
        return l+1;
    }
}

int l_lindo(string s, char l, int len){
    if (len == 1){
        return (s[0] != l);
    } else {
        int mitad = len/2;
        char sig = sig_minuscula(l);

        string izq = s.substr(0, mitad);
        string der = s.substr(mitad, mitad);
        
        int todoizq = mitad - count(izq.begin(), izq.end(), l);
        int tododer = mitad - count(der.begin(), der.end(), l);

        int totalizq = todoizq + l_lindo(der, sig, mitad);
        int totalder = l_lindo(izq, sig, mitad) + tododer;
        
        int res = min(totalizq, totalder);

        return res;
    }
}

int main () {
    int t;
    cin >> t;
    vector<int> res(t, 0);
    int n;
    string s;
    for(int i = 0; i < t; i++) {
        cin >> n >> s;
        res[i] = l_lindo(s, 'a', n);
    }
    for(int i = 0; i < t; i++) {
        cout << res[i] << "\n" ;
    }
    
    return 0;
}