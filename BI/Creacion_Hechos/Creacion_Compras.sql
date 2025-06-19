INSERT INTO DATACORE.BI_Hecho_Compra (
    Tiempo_ID,
    Sucursal_ID,
    TipoMaterial_ID,
    Ubicacion_Proveedor_ID,
    Orden_De_Compra_ID,
    Ubicacion_Sucursal_ID,
    Cantidad_Compra,
    Precio_Compra
)
SELECT
    DATACORE.getTiempoID(c.Compra_Fecha) AS Tiempo_ID,
    sbi.Sucursal_ID,
    tbi.TipoMaterial_ID,
    ubiProv.Ubicacion_ID AS Ubicacion_Proveedor_ID,
    obi.Orden_De_Compra_ID,
    ubiSuc.Ubicacion_ID AS Ubicacion_Sucursal_ID,
    dc.Detalle_Compra_Cantidad,
    dc.Detalle_Compra_Precio
FROM DATACORE.Detalles_Compras dc
INNER JOIN DATACORE.Compras c ON c.Compra_Numero = dc.Compra_Numero
INNER JOIN DATACORE.Materiales m ON m.Material_Id = dc.Material_Id
INNER JOIN DATACORE.TipoMateriales tm ON tm.TipoMaterial_Id = m.TipoMaterial_Id
INNER JOIN DATACORE.Proveedores p ON p.Proveedor_Cuit = c.Proveedor_Cuit
INNER JOIN DATACORE.Sucursales s ON s.Sucursal_NroSucursal = c.Sucursal_NroSucursal
-- Ubicación del proveedor
INNER JOIN DATACORE.Localidades lprov ON lprov.Localidad_Id = p.Localidad_Id
INNER JOIN DATACORE.Provincias pprov ON pprov.Provincia_Id = lprov.Provincia_Id
INNER JOIN DATACORE.BI_Dimension_Ubicacion ubiProv ON ubiProv.Localidad = lprov.Localidad_Nombre AND ubiProv.Provincia = pprov.Provincia_Nombre
-- Ubicación de la sucursal
INNER JOIN DATACORE.Localidades lsuc ON lsuc.Localidad_Id = s.Localidad_Id
INNER JOIN DATACORE.Provincias psuc ON psuc.Provincia_Id = lsuc.Provincia_Id
INNER JOIN DATACORE.BI_Dimension_Ubicacion ubiSuc ON ubiSuc.Localidad = lsuc.Localidad_Nombre AND ubiSuc.Provincia = psuc.Provincia_Nombre
-- Sucursal BI
INNER JOIN DATACORE.BI_Dimension_Sucursales sbi ON sbi.Sucursal_NroSucursal = s.Sucursal_NroSucursal
-- Tipo Material BI
INNER JOIN DATACORE.BI_Dimension_TipoMaterial tbi ON tbi.TipoMaterial_Tipo = tm.TipoMaterial_Tipo
-- Orden de compra BI
INNER JOIN DATACORE.BI_Dimension_Orden_De_Compra obi ON obi.Compra_Numero = c.Compra_Numero;
