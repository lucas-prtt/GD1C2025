CREATE VIEW DATACORE.Vista_Cumplimiento_Envios AS
SELECT 
    t.Anio,
    t.Mes,
    SUM(CASE WHEN ee.Estado_Envio_Desc = 'Entregado en tiempo' THEN he.Cantidad_Envios ELSE 0 END) * 100.0 /
        NULLIF(SUM(he.Cantidad_Envios), 0) AS Porcentaje_Cumplimiento
FROM DATACORE.BI_Hecho_Envio he
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = he.Tiempo_Programado_ID
INNER JOIN DATACORE.BI_Dimension_Estado_Envio ee ON ee.Estado_Envio_ID = he.Estado_Envio_ID
GROUP BY t.Anio, t.Mes;
