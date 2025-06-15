SELECT * 
FROM DATACORE.BI_Hecho_Venta

GO
--DROP PROCEDURE DATACORE.Importar_Hechos_Ventas
GO
CREATE PROCEDURE DATACORE.Importar_Hechos_Ventas
AS 
BEGIN

	DECLARE @Factura_Fecha DATETIME2(6)
	DECLARE @Cliente_FechaNacimiento DATETIME2(6)
	DECLARE @Sucursal_NroSucursal BIGINT
	DECLARE @Sucursal_Telefono NVARCHAR(255)
	DECLARE @Sucursal_Direccion NVARCHAR(255)
	DECLARE @Sucursal_Mail NVARCHAR(255)
	DECLARE @Sillon_Modelo_Codigo BIGINT
	DECLARE @Sillon_Modelo_Descripcion NVARCHAR(255)
	DECLARE @Sillon_Modelo_Precio DECIMAL(18, 2)
	DECLARE @Sillon_Modelo NVARCHAR(255)
	DECLARE @Cliente_Localidad_Id BIGINT
	DECLARE @Cliente_Provincia_Id BIGINT
	DECLARE @Cliente_Localidad_Nombre NVARCHAR(255)
	DECLARE @Cliente_Provincia_Nombre NVARCHAR(255)
	DECLARE @Sucursal_Localidad_Id BIGINT
	DECLARE @Sucursal_Provincia_Id BIGINT
	DECLARE @Sucursal_Localidad_Nombre NVARCHAR(255)
	DECLARE @Sucursal_Provincia_Nombre NVARCHAR(255)
	DECLARE @Factura_Numero BIGINT
	DECLARE @Pedido_Numero BIGINT
	DECLARE @Detalle_Factura_Cantidad BIGINT
	DECLARE @Detalle_Factura_Precio DECIMAL(18, 2)
	DECLARE @Sucursal_ID Bi
DECLARE cursorFacturas CURSOR  
FOR 
	SELECT f.Factura_Fecha, c.Cliente_FechaNacimiento, su.Sucursal_NroSucursal, Sucursal_Telefono,
	Sucursal_Direccion, Sucursal_Mail, s.Sillon_Modelo_Codigo,
	Sillon_Modelo_Descripcion, Sillon_Modelo_Precio,
	Sillon_Modelo, c.Localidad_Id, lc.Provincia_Id, lc.Localidad_Nombre, 
	pc.Provincia_Nombre, su.Localidad_Id, lsu.Provincia_Id, lsu.Localidad_Nombre,
	psu.Provincia_Nombre, f.Factura_Numero, dt.Pedido_Numero, dt.Detalle_Factura_Cantidad,
	dt.Detalle_Factura_Precio
	FROM DATACORE.Detalles_Facturas dt
	INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = dt.Factura_Numero
	INNER JOIN DATACORE.Clientes c ON f.Cliente_Dni = c.Cliente_Dni
	INNER JOIN DATACORE.Sillones s ON s.Sillon_Codigo = dt.Sillon_Codigo
	INNER JOIN DATACORE.Modelos_De_Sillones m ON s.Sillon_Modelo_Codigo = m.Sillon_Modelo_Codigo
	INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
	INNER JOIN DATACORE.Sucursales su ON f.Sucursal_NroSucursal = su.Sucursal_NroSucursal
	INNER JOIN DATACORE.Localidades lsu ON lsu.Localidad_Id = lsu.Localidad_Id
	INNER JOIN DATACORE.Provincias psu ON lsu.Provincia_Id = psu.Provincia_Id
	INNER JOIN DATACORE.Provincias pc ON lc.Provincia_Id = pc.Provincia_Id




FETCH NEXT FROM cursorFacturas INTO 
    @Factura_Fecha, 
    @Cliente_FechaNacimiento, 
    @Sucursal_NroSucursal, 
    @Sucursal_Telefono, 
    @Sucursal_Direccion, 
    @Sucursal_Mail, 
    @Sillon_Modelo_Codigo, 
    @Sillon_Modelo_Descripcion, 
    @Sillon_Modelo_Precio, 
    @Sillon_Modelo, 
    @Cliente_Localidad_Id, 
    @Cliente_Provincia_Id, 
    @Cliente_Localidad_Nombre, 
    @Cliente_Provincia_Nombre, 
    @Sucursal_Localidad_Id, 
    @Sucursal_Provincia_Id, 
    @Sucursal_Localidad_Nombre, 
    @Sucursal_Provincia_Nombre, 
    @Factura_Numero, 
    @Pedido_Numero, 
    @Detalle_Factura_Cantidad, 
    @Detalle_Factura_Precio
WHILE @@FETCH_STATUS = 0
	BEGIN
	PRINT("Ejecutando importar hechos...")

	-- TODO: Importar los hechos

	FETCH NEXT FROM cursorFacturas INTO 
    @Factura_Fecha, 
    @Cliente_FechaNacimiento, 
    @Sucursal_NroSucursal, 
    @Sucursal_Telefono, 
    @Sucursal_Direccion, 
    @Sucursal_Mail, 
    @Sillon_Modelo_Codigo, 
    @Sillon_Modelo_Descripcion, 
    @Sillon_Modelo_Precio, 
    @Sillon_Modelo, 
    @Cliente_Localidad_Id, 
    @Cliente_Provincia_Id, 
    @Cliente_Localidad_Nombre, 
    @Cliente_Provincia_Nombre, 
    @Sucursal_Localidad_Id, 
    @Sucursal_Provincia_Id, 
    @Sucursal_Localidad_Nombre, 
    @Sucursal_Provincia_Nombre, 
    @Factura_Numero, 
    @Pedido_Numero, 
    @Detalle_Factura_Cantidad, 
    @Detalle_Factura_Precio

	END
	
END




