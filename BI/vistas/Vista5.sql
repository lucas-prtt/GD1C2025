CREATE VIEW DATACORE.VW_CantidadVentasPorProvinciaCliente
AS
    SELECT
        du.Provincia,
        SUM(hv.Cantidad_Venta) AS Total_Ventas
    FROM DATACORE.BI_Hecho_Venta hv
        INNER JOIN DATACORE.BI_Dimension_Ubicacion du ON hv.Ubicacion_Cliente_ID = du.Ubicacion_ID
    GROUP BY du.Provincia
