---------------Insertar datos en la tabla BI_Hecho_Envio
INSERT INTO DATACORE.BI_Hecho_Envio ( Tiempo_Programado_ID, Tiempo_Realizado_ID, Sucursal_ID, Factura_ID, Costo_Envio)
SELECT 
    DATACORE.getTiempoID(e.Envio_Fecha_Programada),
    DATACORE.getTiempoID(e.Envio_Fecha),
    ubi.Ubicacion_Destino_ID,
    ds.Sucursal_ID,
    df.Factura_ID,
    SUM(e.Envio_Total)
FROM  DATACORE.Envios e
INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = e.Factura_Numero
INNER JOIN DATACORE.BI_Dimension_Sucursales ds ON ds.Sucursal_NroSucursal = f.Sucursal_NroSucursal
INNER JOIN DATACORE.BI_Dimension_Factura df ON df.Factura_Numero =e.Factura_Numero
INNER JOIN DATACORE.Clientes cl ON cl.Cliente_DNI = f.Cliente_DNI
INNER JOIN DATACORE.BI_Dimension_Ubicacion ubi ON ubi.Localidad_Id = cl.Localidad_ID
GROUP BY DATACORE.getTiempoID(e.Envio_Fecha_Programada),DATACORE.getTiempoID(e.Envio_Fecha),ubi.Ubicacion_Destino_ID,ds.Sucursal_ID,df.Factura_ID,
