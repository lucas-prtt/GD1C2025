CREATE VIEW DATACORE.Vista_Conversion_Pedidos AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    ep.Estado_Pedido_Desc,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal) AS Porcentaje
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON p.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON p.Sucursal_ID = s.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_Estado_Pedido ep ON p.Estado_Pedido_ID = ep.Estado_Pedido_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal, ep.Estado_Pedido_Desc;
