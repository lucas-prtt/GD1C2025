CREATE VIEW DATACORE.Vista_Ganancias_Por_Sucursal AS
SELECT 
    t.Anio,
    t.Mes,
    s.Sucursal_NroSucursal,
    --SUM(ISNULL(v.Precio_Venta, 0)) AS Total_Ingresos,
    --SUM(ISNULL(c.Precio_Compra, 0)) AS Total_Egresos,
    SUM(ISNULL(v.Precio_Venta, 0)) - SUM(ISNULL(c.Precio_Compra, 0)) AS Ganancia
FROM DATACORE.BI_Dimension_Tiempo t
JOIN DATACORE.BI_Hecho_Venta v ON v.Tiempo_ID = t.Tiempo_ID
JOIN DATACORE.BI_Hecho_Compra c ON c.Tiempo_ID = t.Tiempo_ID AND v.Sucursal_ID = c.Sucursal_ID
JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = v.Sucursal_ID
GROUP BY t.Anio, t.Mes, s.Sucursal_NroSucursal;
