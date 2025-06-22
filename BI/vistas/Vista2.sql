CREATE VIEW DATACORE.VW_CostoComprasPorMaterialYProvincia
AS
    SELECT
        dtm.TipoMaterial_Tipo,
        du.Provincia,
        SUM(hc.Precio_Compra) AS Total_Costo_Compra
    FROM DATACORE.BI_Hecho_Compra hc
        INNER JOIN DATACORE.BI_Dimension_TipoMaterial dtm ON hc.TipoMaterial_ID = dtm.TipoMaterial_ID
        INNER JOIN DATACORE.BI_Dimension_Ubicacion du ON hc.Ubicacion_Proveedor_ID = du.Ubicacion_ID
    GROUP BY dtm.TipoMaterial_Tipo, du.Provincia
