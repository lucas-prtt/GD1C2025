

-- UBICACION
CREATE PROCEDURE DATACORE.ObtenerOCrearUbicacionID
    @Localidad_Id BIGINT,
    @Provincia_Id BIGINT,
	@Localidad_Nombre NVARCHAR(255),
	@Provincia_Nombre NVARCHAR(255),
    @Ubicacion_Id BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Ubicacion_Id BIGINT)

    MERGE DATACORE.BI_Dimension_Ubicacion AS vieja
    USING (
	SELECT 
		@Localidad_ID AS Localidad_ID, 
		@Provincia_ID AS Provincia_ID,
		@Localidad_Nombre AS Localidad,
		@Provincia_Nombre AS Provincia
	) AS nueva
    ON vieja.Localidad_ID = nueva.Localidad_ID AND vieja.Provincia_ID = nueva.Provincia_ID
    WHEN NOT MATCHED THEN
        INSERT (Localidad_ID, Provincia_ID, Localidad, Provincia)
        VALUES (nueva.Localidad_ID, nueva.Provincia_ID , nueva.Localidad, nueva.Provincia)
    OUTPUT inserted.Ubicacion_Id INTO @OUT;
    SELECT @Ubicacion_Id = Ubicacion_Id FROM @OUT;
END
GO



-- TIEMPO
CREATE PROCEDURE DATACORE.ObtenerOCrearTiempoID
    @Anio INT,
    @Cuatrimestre TINYINT,
    @Mes TINYINT,
    @Tiempo_ID BIGINT OUTPUT
AS
BEGIN

    DECLARE @OUT TABLE (Tiempo_ID BIGINT);

    MERGE DATACORE.BI_Dimension_Tiempo AS vieja
    USING (
        SELECT 
            @Anio AS Anio,
            @Cuatrimestre AS Cuatrimestre,
            @Mes AS Mes
    ) AS nueva
    ON vieja.Anio = nueva.Anio
       AND vieja.Cuatrimestre = nueva.Cuatrimestre
       AND vieja.Mes = nueva.Mes
    WHEN NOT MATCHED THEN
        INSERT (Anio, Cuatrimestre, Mes)
        VALUES (nueva.Anio, nueva.Cuatrimestre, nueva.Mes)
    OUTPUT inserted.Tiempo_ID INTO @OUT;

    SELECT @Tiempo_ID = Tiempo_ID FROM @OUT;
END
GO




-- SUCURSAL
CREATE PROCEDURE DATACORE.ObtenerOCrearSucursalID
    @Sucursal_NroSucursal BIGINT,
    @Sucursal_telefono NVARCHAR(255),
    @Sucursal_Direccion NVARCHAR(255),
    @Sucursal_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Sucursal_ID BIGINT);
    MERGE DATACORE.BI_Dimension_Sucursales AS vieja
    USING (
        SELECT 
            @Sucursal_NroSucursal AS Sucursal_NroSucursal,
            @Sucursal_telefono AS Sucursal_telefono,
            @Sucursal_Direccion AS Sucursal_Direccion
    ) AS nueva
    ON vieja.Sucursal_NroSucursal = nueva.Sucursal_NroSucursal
    WHEN NOT MATCHED THEN
        INSERT (Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion)
        VALUES (nueva.Sucursal_NroSucursal, nueva.Sucursal_telefono, nueva.Sucursal_Direccion)
    OUTPUT inserted.Sucursal_ID INTO @OUT;
    SELECT @Sucursal_ID = Sucursal_ID FROM @OUT;
END
GO



--TIPOMATERIAL
CREATE PROCEDURE DATACORE.ObtenerOCrearTipoMaterialID
    @TipoMaterial_Tipo NVARCHAR(255),
    @TipoMaterial_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (TipoMaterial_ID BIGINT);
    MERGE DATACORE.BI_Dimension_TipoMaterial AS vieja
    USING (SELECT @TipoMaterial_Tipo AS TipoMaterial_Tipo) AS nueva
    ON vieja.TipoMaterial_Tipo = nueva.TipoMaterial_Tipo
    WHEN NOT MATCHED THEN
        INSERT (TipoMaterial_Tipo)
        VALUES (nueva.TipoMaterial_Tipo)
    OUTPUT inserted.TipoMaterial_ID INTO @OUT;
    SELECT @TipoMaterial_ID = TipoMaterial_ID FROM @OUT;
END
GO





--TURNO
CREATE PROCEDURE DATACORE.ObtenerOCrearTurnoID
    @Horario NVARCHAR(255),
    @Dimension_Turno_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Dimension_Turno_ID BIGINT);
    MERGE DATACORE.BI_Dimension_Turno AS vieja
    USING (SELECT @Horario AS Horario) AS nueva
    ON vieja.Horario = nueva.Horario
    WHEN NOT MATCHED THEN
        INSERT (Horario)
        VALUES (nueva.Horario)
    OUTPUT inserted.Dimension_Turno_ID INTO @OUT;
    SELECT @Dimension_Turno_ID = Dimension_Turno_ID FROM @OUT;
END
GO




-- RANGOETARIO
CREATE PROCEDURE DATACORE.ObtenerOCrearRangoEtarioID
    @Rango_Etario_Descripcion NVARCHAR(255),
    @Rango_Etario_ID BIGINT  OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Rango_Etario_ID BIGINT);
    MERGE DATACORE.BI_Dimension_RangoEtario AS vieja
    USING (SELECT @Rango_Etario_Descripcion AS Rango_Etario_Descripcion) AS nueva
    ON vieja.Rango_Etario_Descripcion = nueva.Rango_Etario_Descripcion
    WHEN NOT MATCHED THEN
        INSERT (Rango_Etario_Descripcion)
        VALUES (nueva.Rango_Etario_Descripcion)
    OUTPUT inserted.Rango_Etario_ID INTO @OUT;
    SELECT @Rango_Etario_ID = Rango_Etario_ID FROM @OUT;
END
GO



-- MODELOSILLON
CREATE PROCEDURE DATACORE.ObtenerOCrearModeloSillonID
    @Sillon_Modelo_Codigo BIGINT,
    @Sillon_Modelo_Descripcion NVARCHAR(255),
    @Sillon_Modelo_Precio DECIMAL(18,2),
    @Sillon_Modelo NVARCHAR(255),
    @Sillon_Modelo_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Sillon_Modelo_ID BIGINT);
    MERGE DATACORE.BI_Dimension_ModeloSillon AS vieja
    USING (
        SELECT
            @Sillon_Modelo_Codigo AS Sillon_Modelo_Codigo,
            @Sillon_Modelo_Descripcion AS Sillon_Modelo_Descripcion,
            @Sillon_Modelo_Precio AS Sillon_Modelo_Precio,
            @Sillon_Modelo AS Sillon_Modelo
    ) AS nueva
    ON vieja.Sillon_Modelo_Codigo = nueva.Sillon_Modelo_Codigo
    WHEN NOT MATCHED THEN
        INSERT (Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo)
        VALUES (nueva.Sillon_Modelo_Codigo, nueva.Sillon_Modelo_Descripcion, nueva.Sillon_Modelo_Precio, nueva.Sillon_Modelo)
    OUTPUT inserted.Sillon_Modelo_ID INTO @OUT;
    SELECT @Sillon_Modelo_ID = Sillon_Modelo_ID FROM @OUT;
END
GO



--ESTADOPEDIDO
CREATE PROCEDURE DATACORE.ObtenerOCrearEstadoPedidoID
    @Estado_Pedido_Desc NVARCHAR(255),
    @Estado_Pedido_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Estado_Pedido_ID BIGINT);
    MERGE DATACORE.BI_Dimension_Estado_Pedido AS vieja
    USING (SELECT @Estado_Pedido_Desc AS Estado_Pedido_Desc) AS nueva
    ON vieja.Estado_Pedido_Desc = nueva.Estado_Pedido_Desc
    WHEN NOT MATCHED THEN
        INSERT (Estado_Pedido_Desc)
        VALUES (nueva.Estado_Pedido_Desc)
    OUTPUT inserted.Estado_Pedido_ID INTO @OUT;

    SELECT @Estado_Pedido_ID = Estado_Pedido_ID FROM @OUT;
END
GO


--OC
CREATE PROCEDURE DATACORE.ObtenerOCrearOrdenDeCompraID
    @Compra_Numero BIGINT,
    @Orden_De_Compra_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Orden_De_Compra_ID BIGINT);
    MERGE DATACORE.BI_Dimension_Orden_De_Compra AS vieja
    USING (SELECT @Compra_Numero AS Compra_Numero) AS nueva
    ON vieja.Compra_Numero = nueva.Compra_Numero
    WHEN NOT MATCHED THEN
        INSERT (Compra_Numero)
        VALUES(nueva.Compra_Numero)
    OUTPUT inserted.Orden_De_Compra_ID INTO @OUT;
    SELECT @Orden_De_Compra_ID = Orden_De_Compra_ID FROM @OUT;
END
GO


-- FACTURA
CREATE PROCEDURE DATACORE.ObtenerOCrearFacturaID
    @Factura_Numero BIGINT,
    @Factura_ID BIGINT OUTPUT
AS
BEGIN
    DECLARE @OUT TABLE (Factura_ID BIGINT);
    MERGE DATACORE.BI_Dimension_Factura AS vieja
    USING (SELECT @Factura_Numero AS Factura_Numero) AS nueva
    ON vieja.Factura_Numero = nueva.Factura_Numero
    WHEN NOT MATCHED THEN
        INSERT (Factura_Numero)
        VALUES (nueva.Factura_Numero)
    OUTPUT inserted.Factura_ID INTO @OUT;
    SELECT @Factura_ID = Factura_ID FROM @OUT;
END

