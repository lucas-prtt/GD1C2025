CREATE VIEW DATACORE.VW_PromedioCostoEnvioPorSucursalYCuatrimestre
AS
    SELECT
        dt.Anio,
        dt.Cuatrimestre,
        ds.Sucursal_NroSucursal,
        AVG(he.Costo_Envio) AS Promedio_Costo_Envio
    FROM DATACORE.BI_Hecho_Envio he
        INNER JOIN DATACORE.BI_Dimension_Tiempo dt ON he.Tiempo_Programado_ID = dt.Tiempo_ID
        INNER JOIN DATACORE.BI_Dimension_Sucursales ds ON he.Sucursal_ID = ds.Sucursal_ID
    GROUP BY dt.Anio, dt.Cuatrimestre, ds.Sucursal_NroSucursal
