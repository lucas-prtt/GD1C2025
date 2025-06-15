-- MUY POCO Performante. Busco otra alternativa

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


	DECLARE @Tiempo_ID BIGINT
	DECLARE @Rango_Etario_Cliente_ID BIGINT
	DECLARE @Sucursal_ID BIGINT
	DECLARE @Turno_ID BIGINT
	DECLARE @Sillon_Modelo_ID BIGINT
	DECLARE @Ubicacion_Cliente_ID BIGINT
	DECLARE @Ubicacion_Sucursal_ID BIGINT
	DECLARE @Factura_ID BIGINT
	DECLARE @Pedido_ID BIGINT
	DECLARE @Cantidad_Venta BIGINT
	DECLARE @Precio_Venta Decimal(18, 2)

	DECLARE @AnioFactura INTEGER
	DECLARE @MesFactura TINYINT 
	DECLARE @CuatrimestreFactura TINYINT 
	DECLARE @RangoEtarioCliente NVARCHAR(255)
	DECLARE @TurnoVenta NVARCHAR(255)
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
	INNER JOIN DATACORE.Localidades lsu ON lsu.Localidad_Id = su.Localidad_Id
	INNER JOIN DATACORE.Provincias psu ON lsu.Provincia_Id = psu.Provincia_Id
	INNER JOIN DATACORE.Provincias pc ON lc.Provincia_Id = pc.Provincia_Id	

OPEN cursorFacturas


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
	SET @AnioFactura = YEAR(@Factura_Fecha)
	SET @MesFactura = MONTH(@Factura_Fecha)
	SET @CuatrimestreFactura = DATEPART(QUARTER ,@Factura_Fecha)
	SET @RangoEtarioCliente = DATACORE.RangoEtario(@Factura_Fecha, @Cliente_FechaNacimiento)
	SET @TurnoVenta = DATACORE.Turno(@Factura_Fecha)
	
	EXEC DATACORE.ObtenerOCrearTiempoID @Anio = @AnioFactura, @Cuatrimestre = @CuatrimestreFactura, @Mes = @MesFactura, @Tiempo_ID = @Tiempo_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearRangoEtarioID @Rango_Etario_Descripcion = @RangoEtarioCliente, @Rango_Etario_ID = @Rango_Etario_Cliente_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearSucursalID @Sucursal_NroSucursal = @Sucursal_NroSucursal, @Sucursal_telefono = @Sucursal_Telefono, @Sucursal_Direccion = @Sucursal_Direccion, @Sucursal_ID = @Sucursal_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearTurnoID @Horario = @TurnoVenta, @Dimension_Turno_ID = @Turno_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearModeloSillonID @Sillon_Modelo_Codigo = @Sillon_Modelo_Codigo, @Sillon_Modelo_Descripcion = @Sillon_Modelo_Descripcion, @Sillon_Modelo_Precio = @Sillon_Modelo_Precio, @Sillon_Modelo = @Sillon_Modelo, @Sillon_Modelo_ID = @Sillon_Modelo_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearUbicacionID @Localidad_Id = @Cliente_Localidad_Id, @Provincia_Id = @Cliente_Provincia_Id, @Localidad_Nombre = @Cliente_Localidad_Nombre, @Provincia_Nombre = @Cliente_Provincia_Nombre, @Ubicacion_Id = @Ubicacion_Cliente_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearUbicacionID @Localidad_Id = @Sucursal_Localidad_Id, @Provincia_Id = @Sucursal_Provincia_Id, @Localidad_Nombre = @Sucursal_Localidad_Nombre, @Provincia_Nombre = @Sucursal_Provincia_Nombre, @Ubicacion_Id = @Ubicacion_Sucursal_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearFacturaID @Factura_Numero = @Factura_Numero, @Factura_ID = @Factura_ID OUTPUT
	EXEC DATACORE.ObtenerOCrearPedidoID @Pedido_Numero = @Pedido_Numero, @Pedido_ID = @Pedido_ID OUTPUT

	INSERT INTO DATACORE.BI_Hecho_Venta (Tiempo_ID, Rango_Etario_Cliente_ID, Sucursal_ID, Turno_ID, Sillon_Modelo_ID, Ubicacion_Cliente_ID, Ubicacion_Sucursal_ID, Factura_ID, Pedido_ID, Cantidad_Venta, Precio_Venta)
								VALUES (@Tiempo_ID, @Rango_Etario_Cliente_ID, @Sucursal_ID, @Turno_ID, @Sillon_Modelo_ID, @Ubicacion_Cliente_ID, @Ubicacion_Sucursal_ID, @Factura_ID, @Pedido_ID, @Cantidad_Venta, @Precio_Venta)
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
GO
EXEC DATACORE.Importar_Hechos_Ventas
