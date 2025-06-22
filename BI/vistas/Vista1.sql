CREATE VIEW DATACORE.VW_CantidadVentasPorModeloYAnio
AS
    SELECT
        dt.Anio,
        dms.Sillon_Modelo_Descripcion,
        SUM(hv.Cantidad_Venta) AS Total_Ventas
    FROM DATACORE.BI_Hecho_Venta hv
        INNER JOIN DATACORE.BI_Dimension_Tiempo dt ON hv.Tiempo_ID = dt.Tiempo_ID
        INNER JOIN DATACORE.BI_Dimension_ModeloSillon dms ON hv.Sillon_Modelo_ID = dms.Sillon_Modelo_ID
    GROUP BY dt.Anio, dms.Sillon_Modelo_Descripcion
