
INSERT INTO DATACORE.BI_Hecho_Envio (
Tiempo_Programado_ID, Tiempo_Realizado_ID, Ubicacion_Destino_ID, Sucursal_ID, Factura_ID, Costo_Envio
)
SELECT tiProg.Tiempo_ID, tiReal.Tiempo_ID, Ubicacion_ID, Sucursal_ID, Factura_ID, SUM(e.Envio_Total)
FROM DATACORE.Envios e
INNER JOIN DATACORE.BI_Dimension_Tiempo tiProg ON tiProg.Anio = Year(e.Envio_Fecha_Programada) AND tiProg.Mes = MONTH(e.Envio_Fecha_Programada) AND tiProg.Cuatrimestre = DATACORE.Cuatrimestre(e.Envio_Fecha_Programada) 
INNER JOIN DATACORE.BI_Dimension_Tiempo tiReal ON tiReal.Anio = Year(e.Envio_Fecha) AND tiReal.Mes = MONTH(e.Envio_Fecha) AND tiReal.Cuatrimestre = DATACORE.Cuatrimestre(e.Envio_Fecha) 
INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = e.Factura_Numero
INNER JOIN DATACORE.BI_Dimension_Sucursales ds ON ds.Sucursal_NroSucursal = f.Sucursal_NroSucursal
INNER JOIN DATACORE.BI_Dimension_Factura df ON df.Factura_Numero = e.Factura_Numero
INNER JOIN DATACORE.Clientes cl ON cl.Cliente_DNI = f.Cliente_DNI
INNER JOIN DATACORE.Localidades loc ON loc.Localidad_ID = cl.Localidad_Id
INNER JOIN DATACORE.BI_Dimension_Ubicacion ubi ON ubi.Localidad = loc.Localidad_Nombre AND ubi.Provincia_ID = loc.Provincia_Id
GROUP BY tiProg.Tiempo_ID, tiReal.Tiempo_ID, ubi.Ubicacion_ID, Sucursal_ID, Factura_ID
