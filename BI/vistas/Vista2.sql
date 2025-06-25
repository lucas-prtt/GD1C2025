CREATE VIEW DATACORE.Vista_Factura_Promedio_Mensual AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    u.Provincia,
    SUM(v.Precio_Venta) /  -- Total facturado
    (SELECT COUNT(*) FROM DATACORE.BI_Hecho_Peticion p -- Cantidad de Pedidos, igual a cantidad de facturas mas los pedidos no facturados
    JOIN DATACORE.BI_Dimension_Tiempo tie ON tie.Tiempo_ID = p.Tiempo_ID_Facturacion 
    WHERE tie.Cuatrimestre = t.Cuatrimestre AND tie.Anio = t.Anio) / 4  -- Si no es pedido entregado, tiempo va con null y se excluye
	AS Factura_Promedio
FROM DATACORE.BI_Hecho_Venta v
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON v.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON v.Ubicacion_Sucursal_ID = u.Ubicacion_ID
GROUP BY t.Anio, t.Cuatrimestre, u.Provincia;
