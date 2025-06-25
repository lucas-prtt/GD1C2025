CREATE PROCEDURE DATACORE.Importar_Hechos_Envio
AS
BEGIN
INSERT INTO DATACORE.BI_Hecho_Envio (
    Tiempo_Programado_ID,
    Estado_Envio_ID,
    Ubicacion_Destino_ID,
    Cantidad_Envios,
    Costo_Traslado_Total,
    Costo_Subida_Total
)
SELECT
    tiProg.Tiempo_ID,
    ee.Estado_Envio_ID, 
    ubi.Ubicacion_ID,
    COUNT(e.Envio_Numero) AS Cantidad_Envios,
    SUM(e.Envio_ImporteTraslado) AS Costo_Traslado_Total,
    SUM(e.Envio_ImporteSubida) AS Costo_Subida_Total
FROM DATACORE.Envios e
INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = e.Factura_Numero
INNER JOIN DATACORE.Clientes c ON c.Cliente_DNI = f.Cliente_DNI
INNER JOIN DATACORE.Localidades loc ON loc.Localidad_ID = c.Localidad_Id
INNER JOIN DATACORE.Provincias p ON p.Provincia_ID = loc.Provincia_ID
INNER JOIN DATACORE.BI_Dimension_Ubicacion ubi ON ubi.Localidad = loc.Localidad_Nombre AND ubi.Provincia = p.Provincia_Nombre
INNER JOIN DATACORE.BI_Dimension_Tiempo tiProg ON tiProg.Anio = Year(e.Envio_Fecha_Programada) AND tiProg.Mes = MONTH(e.Envio_Fecha_Programada) AND tiProg.Cuatrimestre = DATACORE.Cuatrimestre(e.Envio_Fecha_Programada) 
INNER JOIN DATACORE.BI_Dimension_Estado_Envio ee
    ON ee.Estado_Envio_Desc = 
        CASE 
            WHEN e.Envio_Fecha IS NULL THEN 'No entregado'
            WHEN e.Envio_Fecha <= e.Envio_Fecha THEN 'Entregado en tiempo'
            ELSE 'Entregado fuera de tiempo'
        END
GROUP BY
    tiProg.Tiempo_ID,
    ee.Estado_Envio_ID,
    ubi.Ubicacion_ID
END 
GO