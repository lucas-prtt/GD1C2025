CREATE PROCEDURE DATACORE.Importar_Hechos_Compra
AS
BEGIN
    -- CTE temporal para agrupar compras según dimensiones BI
    WITH TempCompras AS (
        SELECT 
            idt.Tiempo_ID AS TiempoID,
            s.Sucursal_NroSucursal AS NroSucursal,
            tm.TipoMaterial_Tipo AS TipoMaterial,
            
            -- Ubicación proveedor
            lp.Localidad_ID AS LocalidadIDProveedor,
            lp.Provincia_ID AS ProvinciaIDProveedor,

            -- Ubicación sucursal
            ls.Localidad_ID AS LocalidadIDSucursal,
            ls.Provincia_ID AS ProvinciaIDSucursal,

            SUM(dc.Detalle_Compra_Cantidad) AS TotalCantidad,
            SUM(dc.Detalle_Compra_Subtotal) AS TotalPrecio
        FROM DATACORE.Detalles_Compras dc
        INNER JOIN DATACORE.Compras c ON c.Compra_Numero = dc.Compra_Numero
        INNER JOIN DATACORE.Materiales m ON m.Material_Id = dc.Material_Id
        INNER JOIN DATACORE.TipoMateriales tm ON tm.TipoMaterial_Id = m.TipoMaterial_Id
        INNER JOIN DATACORE.Proveedores p ON p.Proveedor_Cuit = c.Proveedor_Cuit
        INNER JOIN DATACORE.Localidades lp ON lp.Localidad_Id = p.Localidad_Id
        INNER JOIN DATACORE.Provincias pp ON pp.Provincia_Id = lp.Provincia_Id
        INNER JOIN DATACORE.Sucursales s ON s.Sucursal_NroSucursal = c.Sucursal_NroSucursal
        INNER JOIN DATACORE.Localidades ls ON ls.Localidad_Id = s.Localidad_Id
        INNER JOIN DATACORE.Provincias ps ON ps.Provincia_Id = ls.Provincia_Id
		INNER JOIN DATACORE.BI_Dimension_Tiempo idt ON YEAR(Compra_Fecha) = idt.Anio AND idt.Mes =MONTH(Compra_Fecha) AND DATACORE.Cuatrimestre(Compra_Fecha) = idt.Cuatrimestre

		GROUP BY 
            idt.Tiempo_ID,
            s.Sucursal_NroSucursal,
            tm.TipoMaterial_Tipo,
            lp.Localidad_ID, lp.Provincia_ID,
            ls.Localidad_ID, ls.Provincia_ID
    )

    INSERT INTO DATACORE.BI_Hecho_Compra (
        Tiempo_ID,
        Sucursal_ID,
        TipoMaterial_ID,
        Ubicacion_Proveedor_ID,
        Ubicacion_Sucursal_ID,
        Cantidad_Compra,
        Precio_Compra
    )
    SELECT
        tc.TiempoID,
        bis.Sucursal_ID,
        bitm.TipoMaterial_ID,
        biup.Ubicacion_ID,
        bius.Ubicacion_ID,
        tc.TotalCantidad,
        tc.TotalPrecio
    FROM TempCompras tc
    INNER JOIN DATACORE.BI_Dimension_Sucursales bis 
        ON bis.Sucursal_NroSucursal = tc.NroSucursal
    INNER JOIN DATACORE.BI_Dimension_TipoMaterial bitm 
        ON bitm.TipoMaterial_Tipo = tc.TipoMaterial
    INNER JOIN DATACORE.BI_Dimension_Ubicacion biup 
        ON biup.Localidad_ID = tc.LocalidadIDProveedor AND biup.Provincia_ID = tc.ProvinciaIDProveedor
    INNER JOIN DATACORE.BI_Dimension_Ubicacion bius 
        ON bius.Localidad_ID = tc.LocalidadIDSucursal AND bius.Provincia_ID = tc.ProvinciaIDSucursal
END
GO
EXEC DATACORE.Importar_Hechos_Compra
