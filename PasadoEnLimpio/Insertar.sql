	    -- FUNCION PARA OBTENER LOCALIDADID con nombre de localidad y provincia

CREATE FUNCTION DATACORE.GETLOCALIDADID( @PROVINCIA VARCHAR(255), @LOCALIDAD VARCHAR(255)) RETURNS BIGINT
AS 
BEGIN
	RETURN (SELECT l.Localidad_Id
			FROM (SELECT * FROM DATACORE.Provincias WHERE Provincia_nombre = @PROVINCIA) p 
			INNER JOIN (SELECT * FROM DATACORE.Localidades WHERE localidad_Nombre = @LOCALIDAD) l 
			ON l.Provincia_Id = p.Provincia_Id)
END
GO

-- LUCAS
-- 10



--							LOCALIDADES Y PROVINCIAS


-- Tabla temporal
SELECT DISTINCT Cliente_Localidad as Localidad, Cliente_Provincia as Provincia 
INTO #localidadesYProvincias           
FROM gd_esquema.Maestra 
UNION
SELECT DISTINCT Sucursal_Localidad, Sucursal_provincia
FROM gd_esquema.Maestra 
UNION
SELECT DISTINCT Proveedor_Localidad, Proveedor_Provincia
FROM gd_esquema.Maestra 
EXCEPT 
SELECT NULL, NULL
ORDER BY Localidad

GO

-- Insertar en Provincias
INSERT INTO DATACORE.Provincias (Provincia_Nombre)
SELECT DISTINCT Provincia from #localidadesYProvincias
GO
-- Insertar en Localidades

INSERT INTO DATACORE.Localidades (Localidad_Nombre, Provincia_Id)
SELECT Localidad, Provincia_Id
FROM #localidadesYProvincias INNER JOIN DATACORE.Provincias ON Provincia_Nombre = #localidadesYProvincias.Provincia
GO

-- Borro tabla temporal
DROP TABLE #localidadesYProvincias
GO




--                               CLIENTES


INSERT INTO DATACORE.Clientes
SELECT DISTINCT Cliente_Dni, Cliente_Nombre, Cliente_Apellido,
Cliente_FechaNacimiento, Cliente_Direccion, Cliente_Mail,
Cliente_Telefono, l.Localidad_Id
FROM 
	(SELECT DISTINCT 
		Cliente_Dni, Cliente_Nombre, Cliente_Apellido,
		Cliente_FechaNacimiento, Cliente_Direccion, Cliente_Mail,
		Cliente_Telefono, p.Provincia_Id, Cliente_Localidad
		FROM gd_esquema.Maestra a 
		INNER JOIN DATACORE.Provincias p ON a.Cliente_Provincia = p.Provincia_Nombre)
		AS cp
	INNER JOIN DATACORE.Localidades l ON (cp.Cliente_Localidad = l.Localidad_Nombre AND cp.Provincia_Id = l.Provincia_Id)
GO

--                               SUCURSALES


INSERT INTO DATACORE.Sucursales(Sucursal_NroSucursal,Sucursal_Telefono, Sucursal_Direccion, Sucursal_Mail, Localidad_Id)
SELECT 
    DISTINCT Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_mail, DATACORE.GETLOCALIDADID(Sucursal_Provincia, Sucursal_Localidad) as Localidad_Id
FROM 
    gd_esquema.Maestra;

GO
--								  PROVEEDORES


INSERT INTO DATACORE.Proveedores(Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, Localidad_Id)
SELECT DISTINCT Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, DATACORE.GETLOCALIDADID(Proveedor_Provincia, Proveedor_Localidad) as Localidad_Id
	FROM gd_esquema.Maestra
	WHERE Proveedor_Cuit IS NOT NULL

GO

--									COMPRAS

INSERT INTO DATACORE.Compras(Compra_Numero, Compra_Total, Compra_Fecha, Sucursal_NroSucursal, Proveedor_Cuit)
SELECT DISTINCT Compra_Numero, Compra_Total, Compra_Fecha ,Sucursal_NroSucursal, Proveedor_Cuit
FROM gd_esquema.Maestra
WHERE Compra_Numero IS NOT NULL
GO

--							 TIPOS MATERIALES
INSERT INTO DATACORE.TipoMateriales (TipoMaterial_Tipo)
SELECT DISTINCT Material_Tipo
FROM gd_esquema.Maestra
WHERE Material_Tipo IS NOT NULL
GO
--							CREAR MATERIALES Y MADERA-TELA-RELLENO
CREATE PROCEDURE DATACORE.ImportarMateriales
AS 
BEGIN
DECLARE micursor CURSOR FOR
	SELECT DISTINCT m.Material_Nombre, m.Material_Descripcion, Material_Precio, t.TipoMaterial_Id, t.TipoMaterial_Tipo,Tela_Color, Tela_Textura, Madera_Color, Madera_Dureza, Relleno_Densidad
	FROM gd_esquema.Maestra m INNER JOIN DATACORE.TipoMateriales t ON t.TipoMaterial_Tipo = m.Material_Tipo
	WHERE Material_Tipo IS NOT NULL
OPEN micursor
DECLARE @NOMBRE varchar(255)
DECLARE @DESCRIPCION varchar(255)
DECLARE @PRECIO decimal(18, 2)
DECLARE @TIPOID bigint
DECLARE @TIPO varchar(255)
DECLARE @TELACOLOR varchar(255)
DECLARE @TELATEXTURA varchar(255)
DECLARE @MADERACOLOR varchar(255)
DECLARE @MADERADUREZA varchar(255)
DECLARE @RELLENODENSIDAD decimal(38, 2)
DECLARE @MATERIALID bigint
FETCH micursor INTO @NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID, @TIPO, @TELACOLOR, @TELATEXTURA, @MADERACOLOR, @MADERADUREZA, @RELLENODENSIDAD
WHILE (@@FETCH_STATUS = 0)
	BEGIN
	INSERT INTO DATACORE.Materiales (Material_Nombre, Material_Descripcion, Material_Precio, TipoMaterial_Id)
	VALUES (@NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID)
	SET @MATERIALID = SCOPE_IDENTITY();
	IF @TIPO = 'Madera'
		BEGIN
		INSERT INTO DATACORE.Maderas (Material_Id, Madera_Color, Madera_Dureza)
		VALUES (@MATERIALID, @MADERACOLOR, @MADERADUREZA)
		END
	IF @TIPO = 'Tela'
		BEGIN
		INSERT INTO DATACORE.Telas (Material_Id, Tela_Color, Tela_Textura)
		VALUES (@MATERIALID, @TELACOLOR, @TELATEXTURA)
		END
	IF @TIPO = 'Relleno' 
		BEGIN
		INSERT INTO DATACORE.Rellenos (Material_Id, Relleno_Densidad)
		VALUES (@MATERIALID, @RELLENODENSIDAD)
		END
	FETCH micursor INTO @NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID, @TIPO, @TELACOLOR, @TELATEXTURA, @MADERACOLOR, @MADERADUREZA, @RELLENODENSIDAD
	END
	CLOSE micursor
	DEALLOCATE micursor
END
GO
EXEC DATACORE.ImportarMateriales
GO
-- SU 

-- 							MEDIDAS
INSERT INTO DataCore.Medidas (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio)
SELECT DISTINCT Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio FROM gd_esquema.Maestra
WHERE Sillon_Medida_Alto IS NOT NULL AND Sillon_Medida_Ancho IS NOT NULL AND Sillon_Medida_Profundidad IS NOT NULL;

-- 							ModELOS SILLONES
INSERT INTO DATACORE.Modelos_de_Sillones(Sillon_Modelo_Codigo, Sillon_Modelo_Precio, Sillon_Modelo, Sillon_Modelo_Descripcion )
SELECT DISTINCT Sillon_Modelo_Codigo, Sillon_Modelo_Precio, Sillon_Modelo, Sillon_Modelo_Descripcion
FROM  gd_esquema.Maestra
WHERE Sillon_Modelo_Codigo IS NOT NULL

--                       Silllones
INSERT INTO DATACORE.Sillones(Sillon_codigo, Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Modelo_Codigo)
SELECT DISTINCT Sillon_codigo, Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Modelo_Codigo
FROM gd_esquema.Maestra
WHERE Sillon_Codigo IS NOT NULL


--									DETALLE COMPRAS
INSERT INTO DataCore.Detalles_Compras (Compra_Numero, Material_Id, Detalle_Compra_Cantidad, Detalle_Compra_Precio, Detalle_Compra_Subtotal)
SELECT DISTINCT 
    m.Compra_Numero,
    mat.Material_Id,
    m.Detalle_Compra_Cantidad,
    m.Detalle_Compra_Precio,
    m.Detalle_Compra_SubTotal
FROM gd_esquema.Maestra m
INNER JOIN DataCore.Materiales mat 
    ON mat.Material_Nombre = m.Material_Nombre
    AND mat.Material_Descripcion = m.Material_Descripcion
    AND mat.Material_Precio = m.Material_Precio
WHERE 
    m.Compra_Numero IS NOT NULL
    AND m.Material_Nombre IS NOT NULL
    AND m.Detalle_Compra_Cantidad IS NOT NULL

-- 								PEDIDOS
INSERT INTO DATACORE.Pedidos(Pedido_Numero, Pedido_Fecha, Pedido_Total, Sucursal_NroSucursal, Cliente_Dni)
SELECT DISTINCT  Pedido_Numero, Pedido_Fecha, Pedido_Total, s.Sucursal_NroSucursal, c.Cliente_Dni 
FROM gd_esquema.Maestra m 
INNER JOIN DATACORE.Clientes c ON m.Cliente_Dni = c.Cliente_Dni
INNER JOIN DATACORE.Sucursales s ON m.Sucursal_NroSucursal = s.Sucursal_NroSucursal
WHERE Pedido_Numero IS NOT NULL;


-- 								PEDIDOS CANCELACION


INSERT INTO DataCore.Pedidos_Cancelacion (Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo, Pedido_Numero)
SELECT DISTINCT Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo, p.Pedido_Numero
FROM gd_esquema.Maestra m
INNER JOIN DATACORE.PEDIDOS p ON m.Pedido_Numero = p.Pedido_Numero
WHERE m.Pedido_Cancelacion_Motivo IS NOT NULL


--			ENVIOS   (Este debe ir luego de facturas)
INSERT INTO DataCore.Envios (
    Envio_Numero,
    Envio_Fecha_Programada,
    Envio_Fecha,
    Envio_ImporteTraslado,
    Envio_ImporteSubida,
    Envio_Total,
    Factura_Numero
)
SELECT DISTINCT
    Envio_Numero,
    Envio_Fecha_Programada,
    Envio_Fecha,
    Envio_ImporteTraslado,
    Envio_importeSubida,
    Envio_Total,
    Factura_Numero
FROM gd_esquema.Maestra
WHERE Envio_Numero IS NOT NULL

--                            MATERIALES POR SILLONES

INSERT INTO DATACORE.Materiales_Sillones (Material_Id, Sillon_Codigo)
SELECT q2.Material_Id, q1.Sillon_Codigo
FROM
	(SELECT DISTINCT m.Sillon_Codigo, m.Material_Nombre, m.Material_Descripcion, Material_Precio, t.TipoMaterial_Id, t.TipoMaterial_Tipo,Tela_Color, Tela_Textura, Madera_Color, Madera_Dureza, Relleno_Densidad
	FROM gd_esquema.Maestra m INNER JOIN DATACORE.TipoMateriales t ON t.TipoMaterial_Tipo = m.Material_Tipo
	WHERE Material_Tipo IS NOT NULL AND Sillon_Codigo IS NOT NULL) as q1
INNER JOIN 
	(
	SELECT m.Material_Id, Material_Nombre, Material_Descripcion, Material_Precio, Madera_Color, Madera_Dureza, Tela_Color, Tela_Textura, Relleno_Densidad
	FROM 
	DATACORE.Materiales m FULL OUTER JOIN DATACORE.Maderas mad ON mad.Material_Id = m.Material_Id
	FULL OUTER JOIN DATACORE.Telas tel ON tel.Material_Id = m.Material_Id
	FULL OUTER JOIN DATACORE.Rellenos rel ON rel.Material_Id = m.Material_Id
	) q2 
	ON 
	q1.Material_Nombre = q2.Material_Nombre		
-- Para esta tabla alcanza con solo comparar el nombre. En otra podria hacer falta comparar todos los campos para saber que se trata del mismo material
	





