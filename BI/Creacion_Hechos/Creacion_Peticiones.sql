INSERT INTO DATACORE.BI_Hecho_Peticion(Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Pedido_ID,
    Costo_Peticion)
SELECT Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Pedido_ID,
    Costo_Peticion
FROM DATACORE.Pedidos-------






-----------------------------------------------------------



