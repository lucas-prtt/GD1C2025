CREATE VIEW DATACORE.Vista_Localidades_Mayor_Costo_Envio AS
SELECT TOP 3
    u.Localidad,
    u.Provincia,
    AVG(he.Costo_Traslado_Total + he.Costo_Subida_Total) AS Promedio_Costo_Total
FROM DATACORE.BI_Hecho_Envio he
INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON u.Ubicacion_ID = he.Ubicacion_Destino_ID
GROUP BY u.Localidad, u.Provincia
ORDER BY Promedio_Costo_Total DESC;
