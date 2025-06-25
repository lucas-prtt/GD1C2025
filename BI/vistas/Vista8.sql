CREATE VIEW DATACORE.Vista_Compras_Por_TipoMaterial AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    tm.TipoMaterial_Tipo,
    SUM(c.Precio_Compra) AS Total_Gastado
FROM DATACORE.BI_Hecho_Compra c
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = c.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = c.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_TipoMaterial tm ON tm.TipoMaterial_ID = c.TipoMaterial_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal, tm.TipoMaterial_Tipo;
