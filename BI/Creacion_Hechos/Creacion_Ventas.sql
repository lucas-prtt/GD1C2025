CREATE PROCEDURE DATACORE.Importar_Hechos_Ventas
AS
BEGIN
    WITH TempVentas AS (
       SELECT 
            idt.Tiempo_ID AS TiempoID,
            su.Sucursal_NroSucursal AS NroSucursal,
            s.Sillon_Modelo_Codigo AS ModeloCodigo,
            su.Localidad_Id AS LocalidadIDSucursal,
            lsu.Provincia_Id AS ProvinciaIDSucursal,
            DATACORE.RangoEtario(f.Factura_Fecha, c.Cliente_FechaNacimiento) AS RangoEtario,
            DATACORE.Turno(f.Factura_Fecha) AS Turno,
            SUM(dt.Detalle_Factura_Cantidad) AS Cantidad,
            SUM(dt.Detalle_Factura_Precio) AS Precio
        FROM DATACORE.Detalles_Facturas dt
        INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = dt.Factura_Numero
        INNER JOIN DATACORE.Clientes c ON f.Cliente_Dni = c.Cliente_Dni
        INNER JOIN DATACORE.Sillones s ON s.Sillon_Codigo = dt.Sillon_Codigo
        INNER JOIN DATACORE.Sucursales su ON f.Sucursal_NroSucursal = su.Sucursal_NroSucursal
        INNER JOIN DATACORE.Localidades lsu ON su.Localidad_Id = lsu.Localidad_Id
		INNER JOIN DATACORE.BI_Dimension_Tiempo idt ON YEAR(Factura_Fecha) = idt.Anio AND idt.Mes =MONTH(Factura_Fecha) AND DATACORE.Cuatrimestre(Factura_Fecha) = idt.Cuatrimestre
        GROUP BY 
            idt.Tiempo_ID,
            su.Sucursal_NroSucursal,
            s.Sillon_Modelo_Codigo,
            su.Localidad_Id, lsu.Provincia_Id,
            DATACORE.RangoEtario(f.Factura_Fecha, c.Cliente_FechaNacimiento),
            DATACORE.Turno(f.Factura_Fecha))
	
    INSERT INTO DATACORE.BI_Hecho_Venta (
        Tiempo_ID,
        Rango_Etario_Cliente_ID,
        Turno_ID,
        Sillon_Modelo_ID,
        Sucursal_ID,
        Ubicacion_Sucursal_ID,
        Cantidad_Venta,
        Precio_Venta
    )
    SELECT 
        tv.TiempoID,
        bre.Rango_Etario_ID,
        btu.Turno_ID,
        bms.Sillon_Modelo_ID,
        bs.Sucursal_ID,
        ubicSucursal.Ubicacion_ID,
        SUM(tv.Cantidad) as 'Cantidad_De_Sillones',
        SUM(tv.Precio) as 'Importe_Total_Sillones'
    FROM TempVentas tv
    INNER JOIN DATACORE.BI_Dimension_Sucursales bs 
        ON bs.Sucursal_NroSucursal = tv.NroSucursal
    INNER JOIN DATACORE.BI_Dimension_ModeloSillon bms 
        ON bms.Sillon_Modelo_Codigo = tv.ModeloCodigo
    INNER JOIN DATACORE.BI_Dimension_Ubicacion ubicSucursal 
        ON ubicSucursal.Localidad_ID = tv.LocalidadIDSucursal AND ubicSucursal.Provincia_ID = tv.ProvinciaIDSucursal
    INNER JOIN DATACORE.BI_Dimension_RangoEtario bre 
        ON bre.Rango_Etario_Descripcion = tv.RangoEtario
    INNER JOIN DATACORE.BI_Dimension_Turno btu 
        ON btu.Horario = tv.Turno
	GROUP BY 
	    tv.TiempoID,
        bre.Rango_Etario_ID,
        bs.Sucursal_ID,
        btu.Turno_ID,
        bms.Sillon_Modelo_ID,
        ubicSucursal.Ubicacion_ID
	
END
GO
EXEC DATACORE.Importar_Hechos_Ventas

