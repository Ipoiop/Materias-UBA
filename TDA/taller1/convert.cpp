#include <vector>
#include <iostream>
using namespace std;

bool convertibilidad(int x, int y, vector<int> &pasos){
    if (y<=x){
        return y == x;
    }

    bool res = false;
    if (y / 2 >= x && y % 2 == 0) {
        res = convertibilidad(x, y / 2, pasos);
        if (res) pasos.push_back(y / 2);
    }
    if (y / 10 >= x && y % 10 == 1 && y > 10) {
        res = convertibilidad(x, y / 10, pasos);
        if (res) pasos.push_back(y / 10);
    }

    return res;
}

int main () {
    int x;
    int y;

    cin >> x >> y;
    vector<int> res;
    string yn;
    if (convertibilidad(x, y, res)){
        yn = "YES";
    } else {
        yn = "NO";
    }
    cout << yn << "\n";
    if (yn == "YES"){
        res.push_back(y);
        cout << res.size() << "\n";
        for(int i = 0; i < res.size(); i++) {
            cout << res[i] << " " ;
        }
    }
    

    return 0;
}