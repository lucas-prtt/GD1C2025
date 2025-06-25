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
INNER JOIN DATACORE.BI_Dimension_Tiempo tiProg ON tiProg.Anio = YEAR(e.Envio_Fecha_Programada) AND tiProg.Mes = MONTH(e.Envio_Fecha_Programada) AND tiProg.Cuatrimestre = DATACORE.Cuatrimestre(e.Envio_Fecha_Programada)
INNER JOIN DATACORE.BI_Dimension_Estado_Envio ee
    ON ee.Estado_Envio_Desc = 
        CASE 
            WHEN e.Envio_Fecha IS NULL THEN 'No entregado'
            WHEN e.Envio_Fecha <= e.Envio_Fecha_Programada THEN 'Entregado en tiempo'
            ELSE 'Entregado fuera de tiempo'
        END
GROUP BY
    tiProg.Tiempo_ID,
    ee.Estado_Envio_ID,
    ubi.Ubicacion_ID;
END 
GO

EXEC DATACORE.Importar_Hechos_Envio

/*
-- verificacion ------------------------------------
SELECT
    YEAR(e.Envio_Fecha_Programada) AS Anio,
    CASE 
        WHEN MONTH(e.Envio_Fecha_Programada) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(e.Envio_Fecha_Programada) BETWEEN 5 AND 8 THEN 2
        ELSE 3
    END AS Cuatrimestre,
    MONTH(e.Envio_Fecha_Programada) AS Mes,
    -- Estado calculado igual que en el BI
    CASE 
        WHEN e.Envio_Fecha IS NULL THEN 'No entregado'
        WHEN e.Envio_Fecha <= e.Envio_Fecha_Programada THEN 'Entregado en tiempo'
        ELSE 'Entregado fuera de tiempo'
    END AS Estado_Envio_Desc,
    p.Provincia_Nombre,
    l.Localidad_Nombre,
    COUNT(*) AS Cantidad_Envios,
    SUM(e.Envio_ImporteTraslado) AS Costo_Envio_Total,
    SUM(ISNULL(e.Envio_ImporteSubida, 0)) AS Costo_Subida_Total
FROM DATACORE.Envios e
INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = e.Factura_Numero
INNER JOIN DATACORE.Clientes c ON c.Cliente_DNI = f.Cliente_DNI
INNER JOIN DATACORE.Localidades l ON l.Localidad_ID = c.Localidad_Id
INNER JOIN DATACORE.Provincias p ON p.Provincia_ID = l.Provincia_ID
GROUP BY
    YEAR(e.Envio_Fecha_Programada),
    CASE 
        WHEN MONTH(e.Envio_Fecha_Programada) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(e.Envio_Fecha_Programada) BETWEEN 5 AND 8 THEN 2
        ELSE 3
    END,
    MONTH(e.Envio_Fecha_Programada),
    CASE 
        WHEN e.Envio_Fecha IS NULL THEN 'No entregado'
        WHEN e.Envio_Fecha <= e.Envio_Fecha_Programada THEN 'Entregado en tiempo'
        ELSE 'Entregado fuera de tiempo'
    END,
    p.Provincia_Nombre,
    l.Localidad_Nombre
ORDER BY Anio, Cuatrimestre, Mes, Estado_Envio_Desc, p.Provincia_Nombre, l.Localidad_Nombre

*/