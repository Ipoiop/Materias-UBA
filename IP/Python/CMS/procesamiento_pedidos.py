from queue import Queue
from typing import List
from typing import Dict
from typing import Union
import json

# ACLARACIÓN: El tipo de "pedidos" debería ser: pedidos: Queue[Dict[str, Union[int, str, Dict[str, int]]]]
# Por no ser soportado por la versión de CMS, usamos simplemente "pedidos: Queue"
def procesamiento_pedidos(pedidos: Queue,
                          stock_productos: Dict[str, int],
                          precios_productos: Dict[str, float]) -> List[Dict[str, Union[int, str, float, Dict[str, int]]]]:
  
  res = []
  while not(pedidos.empty()):
    pedido = pedidos.get()
    pedido_procesado = {}
    pedido_procesado['id'] = pedido['id']
    pedido_procesado['cliente'] = pedido['cliente']
    pedido_procesado['productos'] = {}
    #usar fciones "put, get, empty para tipo Queue"
    for prod in pedido['productos']:
      if stock_productos[prod] >= pedido['productos'][prod]:
        stock_productos[prod] = stock_productos[prod] - pedido['productos'][prod]
        pedido_procesado['productos'][prod] = pedido['productos'][prod]
      else:
        pedido_procesado['productos'][prod] = stock_productos[prod]
        stock_productos[prod] = 0
    precio: float = 0
    for prod in pedido_procesado['productos']:
      precio = precio + precios_productos[prod] * pedido_procesado['productos'][prod]
    pedido_procesado['precio_total'] = precio
    if pedido_procesado['productos'] == pedido['productos']:
      pedido_procesado['estado'] = 'completo'
    else:
      pedido_procesado['estado'] = 'incompleto'
    res.append(pedido_procesado)
  return res


if __name__ == '__main__':
  pedidos: Queue = Queue()
  list_pedidos = json.loads(input())
  [pedidos.put(p) for p in list_pedidos]
  stock_productos = json.loads(input())
  precios_productos = json.loads(input())
  print("{} {}".format(procesamiento_pedidos(pedidos, stock_productos, precios_productos), stock_productos))

# Ejemplo input  
# pedidos: [{"id":21,"cliente":"Gabriela", "productos":{"Manzana":2}}, {"id":1,"cliente":"Juan","productos":{"Manzana":2,"Pan":4,"Factura":6}}]
# stock_productos: {"Manzana":10, "Leche":5, "Pan":3, "Factura":0}
# precios_productos: {"Manzana":3.5, "Leche":5.5, "Pan":3.5, "Factura":5}