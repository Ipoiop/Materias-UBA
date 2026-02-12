from typing import List
from typing import Dict
import json

def unir_diccionarios(a_unir: List[Dict[str,str]]) -> Dict[str,List[str]]:
  # Implementar esta funcion
  res: Dict[str,List[str]] = {}
  for i in range(len(a_unir)):
    for key in a_unir[i]:
      if key in res:
        res[key] = res[key] + [(a_unir[i][key])]
      else:
        res[key] = [a_unir[i][key]]
  return res


if __name__ == '__main__':
  x = json.loads(input()) # Ejemplo de input: [{"a":2},{"b":3,"a":1}]
  print(unir_diccionarios(x))