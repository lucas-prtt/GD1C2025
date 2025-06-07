
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'DATACORE')
BEGIN 
    EXEC ('CREATE SCHEMA DATACORE')
END
GO



CREATE PROCEDURE DATACORE.CrearTablaProvincias
AS
BEGIN
        CREATE TABLE DATACORE.Provincias (
            Provincia_Id BIGINT IDENTITY(1,1) NOT NULL,
            Provincia_Nombre VARCHAR(255)
        );
        
END
GO

CREATE PROCEDURE DATACORE.CrearTablaLocalidades
AS
BEGIN
        CREATE TABLE DATACORE.Localidades (
            Localidad_Id BIGINT IDENTITY(1,1) NOT NULL,
            Provincia_Id BIGINT ,
            Localidad_Nombre VARCHAR(255)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaMedidas
AS
BEGIN
        CREATE TABLE DATACORE.Medidas (
            Sillon_Medida_Alto DECIMAL(18,2) NOT NULL,
            Sillon_Medida_Ancho DECIMAL(18,2) NOT NULL,
            Sillon_Medida_Profundidad DECIMAL(18,2) NOT NULL,
            Sillon_Medida_Precio DECIMAL(18,2)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaModelosSillones
AS
BEGIN
        CREATE TABLE DATACORE.Modelos_De_Sillones (
            Sillon_Modelo_Codigo BIGINT NOT NULL,
            Sillon_Modelo_Precio DECIMAL(18, 2),
            Sillon_Modelo VARCHAR(255),
            Sillon_Modelo_Descripcion VARCHAR(255)
        )
END
GO

CREATE PROCEDURE DATACORE.CrearTablaTipoMateriales
AS 
BEGIN
        CREATE TABLE DATACORE.TipoMateriales (
            TipoMaterial_Id BIGINT IDENTITY(1,1) NOT NULL,
            TipoMaterial_Tipo VARCHAR(255) NOT NULL);

END
GO

CREATE PROCEDURE DATACORE.CrearTablaProveedores
AS
BEGIN
        CREATE TABLE DATACORE.Proveedores (
            Proveedor_Cuit VARCHAR(255) NOT NULL,
            Proveedor_RazonSocial VARCHAR(255),
            Proveedor_Direccion VARCHAR(255),
            Proveedor_Telefono VARCHAR(255),
            Proveedor_Mail VARCHAR(255),
            Localidad_Id BIGINT);
END
GO

CREATE PROCEDURE DATACORE.CrearTablaSucursales
AS
BEGIN
        CREATE TABLE DATACORE.Sucursales (
            Sucursal_NroSucursal BIGINT NOT NULL,
            Sucursal_Direccion VARCHAR(255),
            Sucursal_Telefono VARCHAR(255),
            Sucursal_Mail VARCHAR(255),
            Localidad_Id BIGINT
        );

END
GO

CREATE PROCEDURE DATACORE.CrearTablaClientes
AS
BEGIN
        CREATE TABLE DATACORE.Clientes (
            Cliente_Dni VARCHAR(255) NOT NULL,
            Cliente_Nombre VARCHAR(255),
            Cliente_Apellido VARCHAR(255),
            Cliente_FechaNacimiento DATETIME2(6),
            Cliente_Mail VARCHAR(255),
            Cliente_Direccion VARCHAR(255),
            Cliente_Telefono VARCHAR(255),
            Localidad_Id BIGINT
        );

END
GO

CREATE PROCEDURE DATACORE.CrearTablaMateriales
AS
BEGIN
        CREATE TABLE DATACORE.Materiales (
            Material_Id BIGINT IDENTITY(1,1) NOT NULL,
            TipoMaterial_Id BIGINT,
            Material_Nombre VARCHAR(255),
            Material_Descripcion VARCHAR(255),
            Material_Precio DECIMAL(38,2)
        );
        
END
GO

CREATE PROCEDURE DATACORE.CrearTablaTelas
AS
BEGIN
        CREATE TABLE DATACORE.Telas (
            Material_Id BIGINT NOT NULL,
            Tela_Color VARCHAR(255),
            Tela_Textura VARCHAR(255)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaMaderas
AS
BEGIN
        CREATE TABLE DATACORE.Maderas (
            Material_Id BIGINT NOT NULL,
            Madera_Color VARCHAR(255),
            Madera_Dureza VARCHAR(255)
        )
END
GO

CREATE PROCEDURE DATACORE.CrearTablaRellenos
AS
BEGIN
        CREATE TABLE DATACORE.Rellenos (
            Material_Id BIGINT NOT NULL,
            Relleno_Densidad DECIMAL(38, 2)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaSillones
AS
BEGIN
        CREATE TABLE DATACORE.Sillones (
            Sillon_Codigo BIGINT NOT NULL,
            Sillon_Medida_Alto DECIMAL(18,2),
            Sillon_Medida_Ancho DECIMAL(18,2),
            Sillon_Medida_Profundidad DECIMAL(18,2),
            Sillon_Modelo_Codigo BIGINT
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaMaterialesSillones
AS
BEGIN
        CREATE TABLE DATACORE.Materiales_Sillones (
            Material_Id BIGINT NOT NULL,
            Sillon_Codigo BIGINT NOT NULL
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaCompras
AS
BEGIN
        CREATE TABLE DATACORE.Compras (
            Compra_Numero BIGINT NOT NULL,
            Compra_Fecha DATETIME2(6),
            Compra_Total DECIMAL(18,2),
            Sucursal_NroSucursal BIGINT,
            Proveedor_Cuit VARCHAR(255)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaDetallesCompras
AS
BEGIN
        CREATE TABLE DATACORE.Detalles_Compras (
            Compra_Numero BIGINT NOT NULL,
            Material_Id BIGINT NOT NULL,
            Detalle_Compra_Cantidad BIGINT,
            Detalle_Compra_Precio DECIMAL(18,2),
            Detalle_Compra_Subtotal DECIMAL(18,2)
        );

END
GO

CREATE PROCEDURE DATACORE.CrearTablaPedidos
AS
BEGIN       
 CREATE TABLE DATACORE.Pedidos (
            Pedido_Numero BIGINT NOT NULL,
            Pedido_Fecha DATETIME2(6),
            Pedido_Estado VARCHAR(255),
            Pedido_Total DECIMAL(18,2),
            Sucursal_NroSucursal BIGINT,
            Cliente_Dni VARCHAR(255)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaDetallesPedidos
AS
BEGIN
        CREATE TABLE DATACORE.Detalles_Pedidos (
            Pedido_Numero BIGINT NOT NULL,
            Sillon_Codigo BIGINT NOT NULL,
            Detalle_Pedido_Cantidad BIGINT,
            Detalle_Pedido_Precio DECIMAL(18,2),
            Detalle_Pedido_Subtotal DECIMAL(18,2)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaPedidosCancelacion
AS
BEGIN
        CREATE TABLE DATACORE.Pedidos_Cancelacion (
            Pedido_Cancelacion_Num BIGINT IDENTITY(1,1) NOT NULL,
            Pedido_Cancelacion_Fecha DATETIME2(6),
            Pedido_Cancelacion_Motivo VARCHAR(255),
            Pedido_Numero BIGINT
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaFacturas
AS
BEGIN
        CREATE TABLE DATACORE.Facturas (
            Factura_Numero BIGINT NOT NULL,
            Factura_Fecha DATETIME2(6),
            Factura_Total DECIMAL(38,2),
            Cliente_Dni VARCHAR(255),
            Sucursal_NroSucursal BIGINT
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaDetallesFacturas
AS
BEGIN
        CREATE TABLE DATACORE.Detalles_Facturas (
            Factura_Numero BIGINT NOT NULL,
            Sillon_Codigo BIGINT NOT NULL,
			Pedido_Numero BIGINT NOT NULL,  
			Detalle_Factura_Cantidad BIGINT,
            Detalle_Factura_Precio DECIMAL(18,2),
            Detalle_Factura_Subtotal DECIMAL(18,2)
        );
END
GO

CREATE PROCEDURE DATACORE.CrearTablaEnvios
AS
BEGIN
        CREATE TABLE DATACORE.Envios (
            Envio_Numero BIGINT NOT NULL,
            Envio_Fecha_Programada DATETIME2(6),
            Envio_Fecha DATETIME2(6),
            Envio_ImporteTraslado DECIMAL(18,2),
            Envio_ImporteSubida DECIMAL(18,2),
            Envio_Total DECIMAL(18,2),
            Factura_Numero BIGINT
        );
END
GO










CREATE PROCEDURE DATACORE.CrearTodasLasTablas
AS
BEGIN
    EXEC DATACORE.CrearTablaProvincias;
    EXEC DATACORE.CrearTablaLocalidades;
    EXEC DATACORE.CrearTablaMedidas;
    EXEC DATACORE.CrearTablaModelosSillones;
    EXEC DATACORE.CrearTablaTipoMateriales;
    EXEC DATACORE.CrearTablaProveedores;
    EXEC DATACORE.CrearTablaSucursales;
    EXEC DATACORE.CrearTablaClientes;
    EXEC DATACORE.CrearTablaMateriales;
    EXEC DATACORE.CrearTablaTelas;
    EXEC DATACORE.CrearTablaMaderas;
    EXEC DATACORE.CrearTablaRellenos;
    EXEC DATACORE.CrearTablaSillones;
    EXEC DATACORE.CrearTablaMaterialesSillones;
    EXEC DATACORE.CrearTablaCompras;
    EXEC DATACORE.CrearTablaDetallesCompras;
    EXEC DATACORE.CrearTablaPedidos;
    EXEC DATACORE.CrearTablaDetallesPedidos;
    EXEC DATACORE.CrearTablaPedidosCancelacion;
    EXEC DATACORE.CrearTablaFacturas;
    EXEC DATACORE.CrearTablaDetallesFacturas;
    EXEC DATACORE.CrearTablaEnvios;
END
GO
    














CREATE PROCEDURE DATACORE.CrearConstraints
AS 
BEGIN

        -- Constraints para PKs
        ALTER TABLE DATACORE.Localidades ADD CONSTRAINT PK_Localidades PRIMARY KEY (Localidad_Id);
        ALTER TABLE DATACORE.Provincias ADD CONSTRAINT PK_Provincias PRIMARY KEY (Provincia_Id);
        ALTER TABLE DATACORE.Medidas ADD CONSTRAINT PK_Medidas PRIMARY KEY (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad);
        ALTER TABLE DATACORE.Modelos_de_Sillones ADD CONSTRAINT PK_Modelos_Sillones PRIMARY KEY (Sillon_Modelo_Codigo);
        ALTER TABLE DATACORE.TipoMateriales ADD CONSTRAINT PK_TipoMateriales PRIMARY KEY (TipoMaterial_Id);
        ALTER TABLE DATACORE.Proveedores ADD CONSTRAINT PK_Proveedores PRIMARY KEY (Proveedor_Cuit);
        ALTER TABLE DATACORE.Sucursales ADD CONSTRAINT PK_Sucursales PRIMARY KEY (Sucursal_NroSucursal);
        ALTER TABLE DATACORE.Clientes ADD CONSTRAINT PK_Clientes PRIMARY KEY (Cliente_Dni);
        ALTER TABLE DATACORE.Materiales ADD CONSTRAINT PK_Materiales PRIMARY KEY (Material_Id);
        ALTER TABLE DATACORE.Telas ADD CONSTRAINT PK_Telas PRIMARY KEY (Material_Id);
        ALTER TABLE DATACORE.Maderas ADD CONSTRAINT PK_Maderas PRIMARY KEY (Material_Id);
        ALTER TABLE DATACORE.Rellenos ADD CONSTRAINT PK_Rellenos PRIMARY KEY (Material_Id);
        ALTER TABLE DATACORE.Sillones ADD CONSTRAINT PK_Sillones PRIMARY KEY (Sillon_Codigo);
        ALTER TABLE DATACORE.Materiales_Sillones ADD CONSTRAINT PK_Materiales_Sillones PRIMARY KEY (Material_Id, Sillon_Codigo);
        ALTER TABLE DATACORE.Compras ADD CONSTRAINT PK_Compras PRIMARY KEY (Compra_Numero);
        ALTER TABLE DATACORE.Detalles_Compras ADD CONSTRAINT PK_Detalles_Compras PRIMARY KEY (Compra_Numero, Material_Id);
        ALTER TABLE DATACORE.Pedidos ADD CONSTRAINT PK_Pedidos PRIMARY KEY (Pedido_Numero);
        ALTER TABLE DATACORE.Detalles_Pedidos ADD CONSTRAINT PK_Detalles_Pedidos PRIMARY KEY (Pedido_Numero, Sillon_Codigo);
        ALTER TABLE DATACORE.Pedidos_Cancelacion ADD CONSTRAINT PK_Pedidos_Cancelacion PRIMARY KEY (Pedido_Cancelacion_Num);
        ALTER TABLE DATACORE.Facturas ADD CONSTRAINT PK_Facturas PRIMARY KEY (Factura_Numero);
        ALTER TABLE DATACORE.Detalles_Facturas ADD CONSTRAINT PK_Detalles_Facturas PRIMARY KEY (Factura_Numero, Pedido_Numero, Sillon_Codigo);
        ALTER TABLE DATACORE.Envios ADD CONSTRAINT PK_Envios PRIMARY KEY (Envio_Numero);
        -- Constraints para FKs
        ALTER TABLE DATACORE.Proveedores
        ADD CONSTRAINT FK_Proveedores_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DATACORE.Localidades(Localidad_Id);
        ALTER TABLE DATACORE.Sucursales
        ADD CONSTRAINT FK_Sucursales_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DATACORE.Localidades(Localidad_Id);
        ALTER TABLE DATACORE.Clientes
        ADD CONSTRAINT FK_Clientes_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DATACORE.Localidades(Localidad_Id);
        ALTER TABLE DATACORE.Materiales
        ADD CONSTRAINT FK_Materiales_TipoMateriales FOREIGN KEY (TipoMaterial_Id) REFERENCES DATACORE.TipoMateriales(TipoMaterial_Id);
        ALTER TABLE DATACORE.Telas
        ADD CONSTRAINT FK_Telas_Materiales FOREIGN KEY (Material_Id) REFERENCES DATACORE.Materiales(Material_Id);
        ALTER TABLE DATACORE.Maderas
        ADD CONSTRAINT FK_Maderas_Materiales FOREIGN KEY (Material_Id) REFERENCES DATACORE.Materiales(Material_Id);
        ALTER TABLE DATACORE.Rellenos
        ADD CONSTRAINT FK_Rellenos_Materiales FOREIGN KEY (Material_Id) REFERENCES DATACORE.Materiales(Material_Id);
        ALTER TABLE DATACORE.Sillones
        ADD CONSTRAINT FK_Sillones_Medidas FOREIGN KEY (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad) REFERENCES DATACORE.Medidas(Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad);
        ALTER TABLE DATACORE.Sillones
        ADD CONSTRAINT FK_Sillones_Modelos FOREIGN KEY (Sillon_Modelo_Codigo) REFERENCES DATACORE.Modelos_de_Sillones(Sillon_Modelo_Codigo);
        ALTER TABLE DATACORE.Materiales_Sillones
        ADD CONSTRAINT FK_MaterialesSillones_Materiales FOREIGN KEY (Material_Id) REFERENCES DATACORE.Materiales(Material_Id);
        ALTER TABLE DATACORE.Materiales_Sillones
        ADD CONSTRAINT FK_MaterialesSillones_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DATACORE.Sillones(Sillon_Codigo);
        ALTER TABLE DATACORE.Compras
        ADD CONSTRAINT FK_Compras_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DATACORE.Sucursales(Sucursal_NroSucursal);
        ALTER TABLE DATACORE.Compras
        ADD CONSTRAINT FK_Compras_Proveedores FOREIGN KEY (Proveedor_Cuit) REFERENCES DATACORE.Proveedores(Proveedor_Cuit);
        ALTER TABLE DATACORE.Detalles_Compras
        ADD CONSTRAINT FK_DetallesCompras_Compras FOREIGN KEY (Compra_Numero) REFERENCES DATACORE.Compras(Compra_Numero);
        ALTER TABLE DATACORE.Detalles_Compras
        ADD CONSTRAINT FK_DetallesCompras_Materiales FOREIGN KEY (Material_Id) REFERENCES DATACORE.Materiales(Material_Id);
        ALTER TABLE DATACORE.Pedidos
        ADD CONSTRAINT FK_Pedidos_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DATACORE.Sucursales(Sucursal_NroSucursal);
        ALTER TABLE DATACORE.Pedidos
        ADD CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (Cliente_Dni) REFERENCES DATACORE.Clientes(Cliente_Dni);
        ALTER TABLE DATACORE.Detalles_Pedidos
        ADD CONSTRAINT FK_DetallesPedidos_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DATACORE.Pedidos(Pedido_Numero);
        ALTER TABLE DATACORE.Detalles_Pedidos
        ADD CONSTRAINT FK_DetallesPedidos_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DATACORE.Sillones(Sillon_Codigo);
        ALTER TABLE DATACORE.Pedidos_Cancelacion
        ADD CONSTRAINT FK_PedidosCancelacion_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DATACORE.Pedidos(Pedido_Numero);
        ALTER TABLE DATACORE.Facturas
        ADD CONSTRAINT FK_Facturas_Clientes FOREIGN KEY (Cliente_Dni) REFERENCES DATACORE.Clientes(Cliente_Dni);
        ALTER TABLE DATACORE.Facturas
        ADD CONSTRAINT FK_Facturas_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DATACORE.Sucursales(Sucursal_NroSucursal);
        ALTER TABLE DATACORE.Detalles_Facturas
        ADD CONSTRAINT FK_DetallesFacturas_Facturas FOREIGN KEY (Factura_Numero) REFERENCES DATACORE.Facturas(Factura_Numero);
        ALTER TABLE DATACORE.Detalles_Facturas
        ADD CONSTRAINT FK_DetallesFacturas_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DATACORE.Pedidos(Pedido_Numero);
        ALTER TABLE DATACORE.Detalles_Facturas
        ADD CONSTRAINT FK_DetallesFacturas_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DATACORE.Sillones(Sillon_Codigo);
        ALTER TABLE DATACORE.Envios
        ADD CONSTRAINT FK_Envios_Facturas FOREIGN KEY (Factura_Numero) REFERENCES DATACORE.Facturas(Factura_Numero);
        ALTER TABLE DATACORE.Localidades
        ADD CONSTRAINT FK_LOCALIDADO_PROVINCIA FOREIGN KEY (Provincia_Id) REFERENCES DATACORE.Provincias(Provincia_Id);

END



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









-- Importar TODOS los datos
CREATE PROCEDURE DATACORE.ImportarDatos
AS 
BEGIN

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
            

            -- Insertar en Provincias
            INSERT INTO DATACORE.Provincias (Provincia_Nombre)
            SELECT DISTINCT Provincia from #localidadesYProvincias
            
            -- Insertar en Localidades

            INSERT INTO DATACORE.Localidades (Localidad_Nombre, Provincia_Id)
            SELECT Localidad, Provincia_Id
            FROM #localidadesYProvincias INNER JOIN DATACORE.Provincias ON Provincia_Nombre = #localidadesYProvincias.Provincia
            

            -- Borro tabla temporal
            DROP TABLE #localidadesYProvincias
            




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
            

            --                               SUCURSALES


            INSERT INTO DATACORE.Sucursales (Sucursal_NroSucursal,Sucursal_Telefono, Sucursal_Direccion, Sucursal_Mail, Localidad_Id)
            SELECT 
                DISTINCT Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_mail, DATACORE.GETLOCALIDADID(Sucursal_Provincia, Sucursal_Localidad) as Localidad_Id
            FROM 
                gd_esquema.Maestra;

            
            --								  PROVEEDORES


            INSERT INTO DATACORE.Proveedores (Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, Localidad_Id)
            SELECT DISTINCT Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, DATACORE.GETLOCALIDADID(Proveedor_Provincia, Proveedor_Localidad) as Localidad_Id
                FROM gd_esquema.Maestra
                WHERE Proveedor_Cuit IS NOT NULL

            

            --									COMPRAS

            INSERT INTO DATACORE.Compras(Compra_Numero, Compra_Total, Compra_Fecha, Sucursal_NroSucursal, Proveedor_Cuit)
            SELECT DISTINCT Compra_Numero, Compra_Total, Compra_Fecha ,Sucursal_NroSucursal, Proveedor_Cuit
            FROM gd_esquema.Maestra
            WHERE Compra_Numero IS NOT NULL
            

            --							 TIPOS MATERIALES
            INSERT INTO DATACORE.TipoMateriales (TipoMaterial_Tipo)
            SELECT DISTINCT Material_Tipo
            FROM gd_esquema.Maestra
            WHERE Material_Tipo IS NOT NULL
            --                          Importar materiales
            EXEC DATACORE.ImportarMateriales

            -- 							MEDIDAS
            INSERT INTO DATACORE.Medidas (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio)
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
            INSERT INTO DATACORE.Detalles_Compras (Compra_Numero, Material_Id, Detalle_Compra_Cantidad, Detalle_Compra_Precio, Detalle_Compra_Subtotal)
            SELECT DISTINCT 
                m.Compra_Numero,
                mat.Material_Id,
                m.Detalle_Compra_Cantidad,
                m.Detalle_Compra_Precio,
                m.Detalle_Compra_SubTotal
            FROM gd_esquema.Maestra m
            INNER JOIN DATACORE.Materiales mat 
                ON mat.Material_Nombre = m.Material_Nombre
                AND mat.Material_Descripcion = m.Material_Descripcion
                AND mat.Material_Precio = m.Material_Precio
            WHERE 
                m.Compra_Numero IS NOT NULL
                AND m.Material_Nombre IS NOT NULL
                AND m.Detalle_Compra_Cantidad IS NOT NULL
            

            -- 								PEDIDOS
            INSERT INTO DATACORE.Pedidos(Pedido_Numero, Pedido_Fecha,Pedido_Estado, Pedido_Total, Sucursal_NroSucursal, Cliente_Dni)
            SELECT DISTINCT  Pedido_Numero,Pedido_Fecha, Pedido_Estado, Pedido_Total, s.Sucursal_NroSucursal, c.Cliente_Dni 
            FROM gd_esquema.Maestra m 
            INNER JOIN DATACORE.Clientes c ON m.Cliente_Dni = c.Cliente_Dni
            INNER JOIN DATACORE.Sucursales s ON m.Sucursal_NroSucursal = s.Sucursal_NroSucursal
            WHERE Pedido_Numero IS NOT NULL;
            


            -- 								PEDIDOS CANCELACION


            INSERT INTO DATACORE.Pedidos_Cancelacion (Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo, Pedido_Numero)
            SELECT DISTINCT Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo, p.Pedido_Numero
            FROM gd_esquema.Maestra m
            INNER JOIN DATACORE.PEDIDOS p ON m.Pedido_Numero = p.Pedido_Numero
            WHERE m.Pedido_Cancelacion_Motivo IS NOT NULL
            

                            --				FACTURAS

            INSERT INTO DATACORE.Facturas (Factura_Numero, Factura_Fecha, Factura_Total, Cliente_Dni, Sucursal_NroSucursal)
            SELECT DISTINCT Factura_Numero, Factura_Fecha, Factura_Total, Cliente_Dni, Sucursal_NroSucursal 
            FROM gd_esquema.Maestra
            WHERE Factura_Total IS NOT NULL
            


            --			DETALLES DE PEDIDOS

            INSERT INTO DATACORE.Detalles_Pedidos (Pedido_Numero, Sillon_Codigo, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal)
            SELECT DISTINCT q.Pedido_Numero, q.Sillon_Codigo, q.Detalle_Pedido_Cantidad, q.Detalle_Pedido_Precio, q.Detalle_Pedido_SubTotal
            FROM (
                SELECT Pedido_Numero, Sillon_Codigo, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_SubTotal
                FROM gd_esquema.Maestra
                ) q
            WHERE Sillon_Codigo IS NOT NULL
            

            --			ENVIOS   (Este debe ir luego de facturas)
            INSERT INTO DATACORE.Envios (
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
                

            --							DETALLES FACTURA

            INSERT INTO DATACORE.Detalles_Facturas (Factura_Numero, Sillon_Codigo, Pedido_Numero, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_Subtotal)
            SELECT DISTINCT a.Factura_Numero, b.Sillon_Codigo, a.Pedido_Numero, Detalle_Factura_Cantidad ,Detalle_Factura_Precio, Detalle_Factura_SubTotal
            FROM 
                (
                SELECT Pedido_Numero, Factura_Numero, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_SubTotal
                FROM gd_esquema.Maestra
                WHERE Pedido_Numero IS NOT NULL OR Factura_Numero IS NOT NULL
                ) a
            INNER JOIN 
                (
                SELECT Pedido_Numero, Sillon_Codigo, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_SubTotal
                FROM gd_esquema.Maestra
                WHERE Pedido_Numero IS NOT NULL
                ) b

            ON a.Pedido_Numero = b.Pedido_Numero AND a.Detalle_Factura_SubTotal = b.Detalle_Pedido_SubTotal AND a.Detalle_Factura_Precio = b.Detalle_Pedido_Precio AND a.Detalle_Factura_Cantidad = b.Detalle_Pedido_Cantidad
            -- Como no hay un DETALLE_PEDIDO_NUMERO o similar en la tabla y siempre que se registra
            -- pedidos es o con sillonCodigo o con numeroFactura, nunca los dos a la vez, unifico
            -- Utilizando la cantidad y el subtotal, suponiendo que se factura la misma cantidad 
            -- de sillones pedidos y por el mismo precio
            WHERE Sillon_Codigo IS NOT NULL
            ORDER BY a.Factura_Numero, b.Sillon_Codigo, a.Pedido_Numero, Detalle_Factura_Cantidad ,Detalle_Factura_Precio, Detalle_Factura_SubTotal

END
GO 
CREATE PROCEDURE DATACORE.EjecutarTodo
AS
BEGIN
    BEGIN TRY  
        BEGIN TRANSACTION
        EXEC DATACORE.CrearTodasLasTablas;
        EXEC DATACORE.CrearConstraints;
        EXEC DATACORE.ImportarDatos;
		COMMIT
	END TRY
	BEGIN CATCH
		PRINT 'Error al ejecutar todo: ' + ERROR_MESSAGE();
		ROLLBACK
	END CATCH
END
GO
        
EXEC DATACORE.EjecutarTodo






