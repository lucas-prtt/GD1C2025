CREATE VIEW DATACORE.Vista_Tiempo_Promedio_Fabricacion AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    AVG(df.Dias_De_Fabricacion * 1.0) AS Tiempo_Promedio_Dias
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = p.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = p.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion df ON df.Dias_Fabricacion_ID = p.Dias_Fabricacion_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal;
