CREATE VIEW DATACORE.Vista_Top_Modelos_Por_Localidad_Y_Rango AS
SELECT *
FROM (
    SELECT 
        t.Anio,
        t.Cuatrimestre,
        u.Localidad,
        r.Rango_Etario_Descripcion,
        m.Sillon_Modelo,
        SUM(v.Cantidad_Venta) AS Total_Ventas,
        ROW_NUMBER() OVER (
            PARTITION BY t.Anio, t.Cuatrimestre, u.Localidad, r.Rango_Etario_Descripcion
            ORDER BY SUM(v.Cantidad_Venta) DESC
        ) AS Rank_Modelo
    FROM DATACORE.BI_Hecho_Venta v
    INNER JOIN DATACORE.BI_Dimension_Tiempo t ON v.Tiempo_ID = t.Tiempo_ID
    INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON v.Ubicacion_Sucursal_ID = u.Ubicacion_ID
    INNER JOIN DATACORE.BI_Dimension_RangoEtario r ON v.Rango_Etario_Cliente_ID = r.Rango_Etario_ID
    INNER JOIN DATACORE.BI_Dimension_ModeloSillon m ON v.Sillon_Modelo_ID = m.Sillon_Modelo_ID
    GROUP BY t.Anio, t.Cuatrimestre, u.Localidad, r.Rango_Etario_Descripcion, m.Sillon_Modelo
) AS TopModelos
WHERE Rank_Modelo <= 3;
