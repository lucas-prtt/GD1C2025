CREATE VIEW DATACORE.Vista_Volumen_Pedidos AS
SELECT 
    t.Anio,
    t.Mes,
    s.Sucursal_NroSucursal,
    tu.Horario,
    SUM(p.Cantidad_Peticiones) AS Total_Pedidos
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON p.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Turno tu ON p.Turno_ID = tu.Turno_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON p.Sucursal_ID = s.Sucursal_ID
GROUP BY t.Anio, t.Mes, s.Sucursal_NroSucursal, tu.Horario;
