CREATE VIEW DATACORE.VW_Promedio_Compras_Mensuales AS
SELECT 
    t.Anio,
    t.Mes,
    s.Sucursal_NroSucursal,
    AVG(hc.Precio_Compra) AS PromedioCompraMensual
FROM DATACORE.BI_Hecho_Compra hc
JOIN DATACORE.BI_Dimension_Tiempo t ON hc.Tiempo_ID = t.Tiempo_ID
JOIN DATACORE.BI_Dimension_Sucursales s ON hc.Sucursal_ID = s.Sucursal_ID
GROUP BY t.Anio, t.Mes, s.Sucursal_NroSucursal
