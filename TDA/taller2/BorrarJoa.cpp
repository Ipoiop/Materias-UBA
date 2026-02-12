#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

string palabraSimpl = "";
vector<vector<int>> memo;



int borrar(int start, int end)
{
    if (start > end) {
        return 0;
    }

    if (memo[start][end] != -1){
        return memo[start][end];
    }

    if (start == end)
    {
        memo[start][end] = 1;
        return memo[start][end];
    }

    int res = 1 + borrar(start+1, end);                                         //caso: borro palabra[start] solo

    for (int i = start+1; i <= end; i++) {
        if (palabraSimpl[start] == palabraSimpl[i]) {
            res = min(res, borrar(start+1, i-1) + borrar(i, end));              //caso: borro palabra[start] junto con palabra[i], no hace falta un +1 porque i se borra con start
        }
    }

    memo[start][end] = res;
    return res;
}

int main() {
    #ifndef ONLINE_JUDGE                                                        //si no hay juez online
        (void)!freopen("inputB.txt", "r", stdin);                               //recibe el input de "inputB.txt"
        (void)!freopen("outputB.txt", "w", stdout);                             //devuelve el output en un "outputB.txt"
    #endif

    int largo;
    string palabra;

    cin >> largo;
    cin >> palabra;

    int largoSimpl = 1;

    palabraSimpl += palabra[0];
    for (int i = 1; i < largo; i++)                                             //simplifico el string, unifico consecutivos
    {
        if (palabra[i] != palabraSimpl.back())
        {
            palabraSimpl += palabra[i];
            largoSimpl++;
        }

    }

    memo.assign(largoSimpl, vector<int>(largoSimpl, -1));                       //inicializo memo

    int res;
    res = borrar(0, largoSimpl - 1);

    cout << res;

    return 0;
}