
-- PROCEDURE MAESTRO: Ejecuta todos los procedures de creación de tablas
CREATE PROCEDURE DataCore.CrearTodasLasTablas
AS
BEGIN
    EXEC DataCore.CrearTablaProvincias;
    EXEC DataCore.CrearTablaLocalidades;
    EXEC DataCore.CrearTablaMedidas;
    EXEC DataCore.CrearTablaModelosSillones;
    EXEC DataCore.CrearTablaTipoMateriales;
    EXEC DataCore.CrearTablaProveedores;
    EXEC DataCore.CrearTablaSucursales;
    EXEC DataCore.CrearTablaClientes;
    EXEC DataCore.CrearTablaMateriales;
    EXEC DataCore.CrearTablaTelas;
    EXEC DataCore.CrearTablaMaderas;
    EXEC DataCore.CrearTablaRellenos;
    EXEC DataCore.CrearTablaSillones;
    EXEC DataCore.CrearTablaMaterialesSillones;
    EXEC DataCore.CrearTablaCompras;
    EXEC DataCore.CrearTablaDetallesCompras;
    EXEC DataCore.CrearTablaPedidos;
    EXEC DataCore.CrearTablaDetallesPedidos;
    EXEC DataCore.CrearTablaPedidosCancelacion;
    EXEC DataCore.CrearTablaFacturas;
    EXEC DataCore.CrearTablaDetallesFacturas;
    EXEC DataCore.CrearTablaEnvios;
END

-- PROCEDURE: Crear tabla Localidades
-- Crear el schema solo si no existe
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'DataCore')
BEGIN 
    EXEC ('CREATE SCHEMA DATACORE')
END
GO
--OBJECT_ID('DataCore.Localidades', 'U') devuelve el ID del objeto si existe una tabla llamada Localidades en el esquema DataCore ('U' significa "User table").

CREATE PROCEDURE DataCore.CrearTablaProvincias
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Provincias', 'U') IS NOT NULL DROP TABLE DataCore.Provincias;
        CREATE TABLE DataCore.Provincias (
            Provincia_Id BIGINT IDENTITY(1,1) NOT NULL,
            Provincia_Nombre VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Provincias: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaLocalidades
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Localidades', 'U') IS NOT NULL DROP TABLE DataCore.Localidades;
        CREATE TABLE DataCore.Localidades (
            Localidad_Id BIGINT IDENTITY(1,1) NOT NULL,
            Provincia_Id BIGINT ,
            Localidad_Nombre VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Localidades: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaMedidas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Medidas', 'U') IS NOT NULL DROP TABLE DataCore.Medidas;
        CREATE TABLE DataCore.Medidas (
            Sillon_Medida_Alto DECIMAL(5,2) NOT NULL,
            Sillon_Medida_Ancho DECIMAL(5,2) NOT NULL,
            Sillon_Medida_Profundidad DECIMAL(5,2) NOT NULL,
            Sillon_Medida_Precio DECIMAL(10,2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Medidas: ' + ERROR_MESSAGE();
    END CATCH
END
GO


CREATE PROCEDURE DataCore.CrearTablaModelosSillones
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Modelos_Sillones', 'U') IS NOT NULL DROP TABLE DataCore.Modelos_Sillones;
        CREATE TABLE DataCore.Modelos_Sillones (
            Sillon_Modelo_Codigo BIGINT NOT NULL,
            Sillon_Modelo_Precio DECIMAL(10, 2),
            Sillon_Modelo VARCHAR(255),
            Sillon_Modelo_Descripcion VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Modelos_Sillones: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaTipoMateriales
AS 
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.TipoMateriales', 'U') IS NOT NULL DROP TABLE DataCore.TipoMateriales;
        CREATE TABLE DataCore.TipoMateriales (
            TipoMaterial_Id BIGINT NOT NULL,
            TipoMaterial_Tipo VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla TipoMateriales: ' + ERROR_MESSAGE();
    END CATCH
END
GO


CREATE PROCEDURE DataCore.CrearTablaProveedores
AS
BEGIN
    BEGIN TRY
    BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Proveedores', 'U') IS NOT NULL DROP TABLE DataCore.Proveedores;
        CREATE TABLE DataCore.Proveedores (
            Proveedor_Cuit VARCHAR(255) NOT NULL,
            Proveedor_RazonSocial VARCHAR(255),
            Proveedor_Direccion VARCHAR(255),
            Proveedor_Telefono VARCHAR(255),
            Proveedor_Mail VARCHAR(255),
            Localidad_Id BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
    ROLLBACK
        PRINT 'Error al crear la tabla Proveedores: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaSucursales
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Sucursales', 'U') IS NOT NULL DROP TABLE DataCore.Sucursales;
        CREATE TABLE DataCore.Sucursales (
            Sucursal_NroSucursal BIGINT NOT NULL,
            Sucursal_Direccion VARCHAR(255),
            Sucursal_Telefono VARCHAR(255),
            Sucursal_Mail VARCHAR(255),
            Localidad_Id BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Sucursales: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaClientes
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Clientes', 'U') IS NOT NULL DROP TABLE DataCore.Clientes;
        CREATE TABLE DataCore.Clientes (
            Cliente_Dni VARCHAR(255) NOT NULL,
            Cliente_Nombre VARCHAR(255),
            Cliente_Apellido VARCHAR(255),
            Cliente_FechaNacimiento DATE,
            Cliente_Mail VARCHAR(255),
            Cliente_Direccion VARCHAR(255),
            Cliente_Telefono VARCHAR(255),
            Localidad_Id BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Clientes: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaMateriales
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Materiales', 'U') IS NOT NULL DROP TABLE DataCore.Materiales;
        CREATE TABLE DataCore.Materiales (
            Material_Id BIGINT IDENTITY(1,1) NOT NULL,
            TipoMaterial_Id BIGINT,
            Material_Nombre VARCHAR(255),
            Material_Descripcion VARCHAR(255),
            Material_Precio DECIMAL(18,2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Materiales: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaTelas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Telas', 'U') IS NOT NULL DROP TABLE DataCore.Telas;
        CREATE TABLE DataCore.Telas (
            TipoMaterial_Id BIGINT NOT NULL,
            Tela_Color VARCHAR(255),
            Tela_Textura VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Telas: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaMaderas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Maderas', 'U') IS NOT NULL DROP TABLE DataCore.Maderas;
        CREATE TABLE DataCore.Maderas (
            TipoMaterial_Id BIGINT NOT NULL,
            Madera_Color VARCHAR(255),
            Madera_Dureza VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Maderas: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaRellenos
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Rellenos', 'U') IS NOT NULL DROP TABLE DataCore.Rellenos;
        CREATE TABLE DataCore.Rellenos (
            TipoMaterial_Id BIGINT NOT NULL,
            Relleno_Densidad DECIMAL(5, 2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Rellenos: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaSillones
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Sillones', 'U') IS NOT NULL DROP TABLE DataCore.Sillones;
        CREATE TABLE DataCore.Sillones (
            Sillon_Codigo BIGINT NOT NULL,
            Sillon_Medida_Alto DECIMAL(5,2),
            Sillon_Medida_Ancho DECIMAL(5,2),
            Sillon_Medida_Profundidad DECIMAL(5,2),
            Sillon_Modelo_Codigo BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Sillones: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaMaterialesSillones
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Materiales_Sillones', 'U') IS NOT NULL DROP TABLE DataCore.Materiales_Sillones;
        CREATE TABLE DataCore.Materiales_Sillones (
            Material_Id BIGINT NOT NULL,
            Sillon_Codigo BIGINT NOT NULL
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Materiales_Sillones: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaCompras
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Compras', 'U') IS NOT NULL DROP TABLE DataCore.Compras;
        CREATE TABLE DataCore.Compras (
            Compra_Numero BIGINT NOT NULL,
            Compra_Fecha DATE,
            Compra_Total DECIMAL(10,2),
            Sucursal_NroSucursal BIGINT,
            Proveedor_Cuit VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Compras: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaDetallesCompras
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Detalles_Compras', 'U') IS NOT NULL DROP TABLE DataCore.Detalles_Compras;
        CREATE TABLE DataCore.Detalles_Compras (
            Compra_Numero BIGINT NOT NULL,
            Material_Id BIGINT NOT NULL,
            Detalle_Compra_Cantidad BIGINT,
            Detalle_Compra_Precio DECIMAL(10,2),
            Detalle_Compra_Subtotal DECIMAL(10,2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Detalles_Compras: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaPedidos
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Pedidos', 'U') IS NOT NULL DROP TABLE DataCore.Pedidos;
        CREATE TABLE DataCore.Pedidos (
            Pedido_Numero BIGINT NOT NULL,
            Pedido_Fecha DATE,
            Pedido_Estado VARCHAR(255),
            Pedido_Total DECIMAL(10,2),
            Sucursal_NroSucursal BIGINT,
            Cliente_Dni VARCHAR(255)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Pedidos: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaDetallesPedidos
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Detalles_Pedidos', 'U') IS NOT NULL DROP TABLE DataCore.Detalles_Pedidos;
        CREATE TABLE DataCore.Detalles_Pedidos (
            Pedido_Numero BIGINT NOT NULL,
            Sillon_Codigo BIGINT NOT NULL,
            Detalle_Pedido_Cantidad BIGINT,
            Detalle_Pedido_Precio DECIMAL(10,2),
            Detalle_Pedido_Subtotal DECIMAL(10,2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Detalles_Pedidos: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaPedidosCancelacion
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Pedidos_Cancelacion', 'U') IS NOT NULL DROP TABLE DataCore.Pedidos_Cancelacion;
        CREATE TABLE DataCore.Pedidos_Cancelacion (
            Pedido_Cancelacion_Num BIGINT NOT NULL,
            Pedido_Cancelacion_Fecha DATE,
            Pedido_Cancelacion_Motivo VARCHAR(255),
            Pedido_Numero BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Pedidos_Cancelacion: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaFacturas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Facturas', 'U') IS NOT NULL DROP TABLE DataCore.Facturas;
        CREATE TABLE DataCore.Facturas (
            Factura_Numero BIGINT NOT NULL,
            Factura_Fecha DATE,
            Factura_Total DECIMAL(10,2),
            Cliente_Dni VARCHAR(255),
            Sucursal_NroSucursal BIGINT,
            Pedido_Numero BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Facturas: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaDetallesFacturas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Detalles_Facturas', 'U') IS NOT NULL DROP TABLE DataCore.Detalles_Facturas;
        CREATE TABLE DataCore.Detalles_Facturas (
            Factura_Numero BIGINT NOT NULL,
            Pedido_Numero BIGINT NOT NULL,  
            Sillon_Codigo BIGINT NOT NULL,
            Detalle_Factura_Cantidad BIGINT,
            Detalle_Factura_Precio DECIMAL(10,2),
            Detalle_Factura_Subtotal DECIMAL(10,2)
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Detalles_Facturas: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE DataCore.CrearTablaEnvios
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF OBJECT_ID('DataCore.Envios', 'U') IS NOT NULL DROP TABLE DataCore.Envios;
        CREATE TABLE DataCore.Envios (
            Envio_Numero BIGINT NOT NULL,
            Envio_Fecha_Programada DATE,
            Envio_Fecha DATE,
            Envio_ImporteTraslado DECIMAL(10,2),
            Envio_ImporteSubida DECIMAL(10,2),
            Envio_Total DECIMAL(10,2),
            Factura_Numero BIGINT
        );
        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        PRINT 'Error al crear la tabla Envios: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC DataCore.CrearTodasLasTablas
        
GO
-- Constraints para PKs
ALTER TABLE DataCore.Localidades ADD CONSTRAINT PK_Localidades PRIMARY KEY (Localidad_Id);
ALTER TABLE DataCore.Provincias ADD CONSTRAINT PK_Provincias PRIMARY KEY (Provincia_Id);
ALTER TABLE DataCore.Medidas ADD CONSTRAINT PK_Medidas PRIMARY KEY (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad);
ALTER TABLE DataCore.Modelos_Sillones ADD CONSTRAINT PK_Modelos_Sillones PRIMARY KEY (Sillon_Modelo_Codigo);
ALTER TABLE DataCore.TipoMateriales ADD CONSTRAINT PK_TipoMateriales PRIMARY KEY (TipoMaterial_Id);
ALTER TABLE DataCore.Proveedores ADD CONSTRAINT PK_Proveedores PRIMARY KEY (Proveedor_Cuit);
ALTER TABLE DataCore.Sucursales ADD CONSTRAINT PK_Sucursales PRIMARY KEY (Sucursal_NroSucursal);
ALTER TABLE DataCore.Clientes ADD CONSTRAINT PK_Clientes PRIMARY KEY (Cliente_Dni);
ALTER TABLE DataCore.Materiales ADD CONSTRAINT PK_Materiales PRIMARY KEY (Material_Id);
ALTER TABLE DataCore.Telas ADD CONSTRAINT PK_Telas PRIMARY KEY (TipoMaterial_Id);
ALTER TABLE DataCore.Maderas ADD CONSTRAINT PK_Maderas PRIMARY KEY (TipoMaterial_Id);
ALTER TABLE DataCore.Rellenos ADD CONSTRAINT PK_Rellenos PRIMARY KEY (TipoMaterial_Id);
ALTER TABLE DataCore.Sillones ADD CONSTRAINT PK_Sillones PRIMARY KEY (Sillon_Codigo);
ALTER TABLE DataCore.Materiales_Sillones ADD CONSTRAINT PK_Materiales_Sillones PRIMARY KEY (Material_Id, Sillon_Codigo);
ALTER TABLE DataCore.Compras ADD CONSTRAINT PK_Compras PRIMARY KEY (Compra_Numero);
ALTER TABLE DataCore.Detalles_Compras ADD CONSTRAINT PK_Detalles_Compras PRIMARY KEY (Compra_Numero, Material_Id);
ALTER TABLE DataCore.Pedidos ADD CONSTRAINT PK_Pedidos PRIMARY KEY (Pedido_Numero);
ALTER TABLE DataCore.Detalles_Pedidos ADD CONSTRAINT PK_Detalles_Pedidos PRIMARY KEY (Pedido_Numero, Sillon_Codigo);
ALTER TABLE DataCore.Pedidos_Cancelacion ADD CONSTRAINT PK_Pedidos_Cancelacion PRIMARY KEY (Pedido_Cancelacion_Num);
ALTER TABLE DataCore.Facturas ADD CONSTRAINT PK_Facturas PRIMARY KEY (Factura_Numero);
ALTER TABLE DataCore.Detalles_Facturas ADD CONSTRAINT PK_Detalles_Facturas PRIMARY KEY (Factura_Numero, Pedido_Numero, Sillon_Codigo);
ALTER TABLE DataCore.Envios ADD CONSTRAINT PK_Envios PRIMARY KEY (Envio_Numero);
GO

-- Constraints para FKs
ALTER TABLE DataCore.Proveedores
ADD CONSTRAINT FK_Proveedores_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DataCore.Localidades(Localidad_Id);

ALTER TABLE DataCore.Sucursales
ADD CONSTRAINT FK_Sucursales_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DataCore.Localidades(Localidad_Id);

ALTER TABLE DataCore.Clientes
ADD CONSTRAINT FK_Clientes_Localidades FOREIGN KEY (Localidad_Id) REFERENCES DataCore.Localidades(Localidad_Id);

ALTER TABLE DataCore.Materiales
ADD CONSTRAINT FK_Materiales_TipoMateriales FOREIGN KEY (TipoMaterial_Id) REFERENCES DataCore.TipoMateriales(TipoMaterial_Id);

ALTER TABLE DataCore.Telas
ADD CONSTRAINT FK_Telas_TipoMateriales FOREIGN KEY (TipoMaterial_Id) REFERENCES DataCore.TipoMateriales(TipoMaterial_Id);

ALTER TABLE DataCore.Maderas
ADD CONSTRAINT FK_Maderas_TipoMateriales FOREIGN KEY (TipoMaterial_Id) REFERENCES DataCore.TipoMateriales(TipoMaterial_Id);

ALTER TABLE DataCore.Rellenos
ADD CONSTRAINT FK_Rellenos_TipoMateriales FOREIGN KEY (TipoMaterial_Id) REFERENCES DataCore.TipoMateriales(TipoMaterial_Id);

ALTER TABLE DataCore.Sillones
ADD CONSTRAINT FK_Sillones_Medidas FOREIGN KEY (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad)
    REFERENCES DataCore.Medidas(Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad);
ALTER TABLE DataCore.Sillones
ADD CONSTRAINT FK_Sillones_Modelos FOREIGN KEY (Sillon_Modelo_Codigo) REFERENCES DataCore.Modelos_Sillones(Sillon_Modelo_Codigo);

ALTER TABLE DataCore.Materiales_Sillones
ADD CONSTRAINT FK_MaterialesSillones_Materiales FOREIGN KEY (Material_Id) REFERENCES DataCore.Materiales(Material_Id);
ALTER TABLE DataCore.Materiales_Sillones
ADD CONSTRAINT FK_MaterialesSillones_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DataCore.Sillones(Sillon_Codigo);

ALTER TABLE DataCore.Compras
ADD CONSTRAINT FK_Compras_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DataCore.Sucursales(Sucursal_NroSucursal);
ALTER TABLE DataCore.Compras
ADD CONSTRAINT FK_Compras_Proveedores FOREIGN KEY (Proveedor_Cuit) REFERENCES DataCore.Proveedores(Proveedor_Cuit);

ALTER TABLE DataCore.Detalles_Compras
ADD CONSTRAINT FK_DetallesCompras_Compras FOREIGN KEY (Compra_Numero) REFERENCES DataCore.Compras(Compra_Numero);
ALTER TABLE DataCore.Detalles_Compras
ADD CONSTRAINT FK_DetallesCompras_Materiales FOREIGN KEY (Material_Id) REFERENCES DataCore.Materiales(Material_Id);

ALTER TABLE DataCore.Pedidos
ADD CONSTRAINT FK_Pedidos_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DataCore.Sucursales(Sucursal_NroSucursal);
ALTER TABLE DataCore.Pedidos
ADD CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (Cliente_Dni) REFERENCES DataCore.Clientes(Cliente_Dni);

ALTER TABLE DataCore.Detalles_Pedidos
ADD CONSTRAINT FK_DetallesPedidos_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DataCore.Pedidos(Pedido_Numero);
ALTER TABLE DataCore.Detalles_Pedidos
ADD CONSTRAINT FK_DetallesPedidos_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DataCore.Sillones(Sillon_Codigo);

ALTER TABLE DataCore.Pedidos_Cancelacion
ADD CONSTRAINT FK_PedidosCancelacion_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DataCore.Pedidos(Pedido_Numero);

ALTER TABLE DataCore.Facturas
ADD CONSTRAINT FK_Facturas_Clientes FOREIGN KEY (Cliente_Dni) REFERENCES DataCore.Clientes(Cliente_Dni);
ALTER TABLE DataCore.Facturas
ADD CONSTRAINT FK_Facturas_Sucursales FOREIGN KEY (Sucursal_NroSucursal) REFERENCES DataCore.Sucursales(Sucursal_NroSucursal);
ALTER TABLE DataCore.Facturas
ADD CONSTRAINT FK_Facturas_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DataCore.Pedidos(Pedido_Numero);

ALTER TABLE DataCore.Detalles_Facturas
ADD CONSTRAINT FK_DetallesFacturas_Facturas FOREIGN KEY (Factura_Numero) REFERENCES DataCore.Facturas(Factura_Numero);
ALTER TABLE DataCore.Detalles_Facturas
ADD CONSTRAINT FK_DetallesFacturas_Pedidos FOREIGN KEY (Pedido_Numero) REFERENCES DataCore.Pedidos(Pedido_Numero);
ALTER TABLE DataCore.Detalles_Facturas
ADD CONSTRAINT FK_DetallesFacturas_Sillones FOREIGN KEY (Sillon_Codigo) REFERENCES DataCore.Sillones(Sillon_Codigo);

ALTER TABLE DataCore.Envios
ADD CONSTRAINT FK_Envios_Facturas FOREIGN KEY (Factura_Numero) REFERENCES DataCore.Facturas(Factura_Numero);
GO

ALTER TABLE DataCore.Localidades
ADD CONSTRAINT FK_LOCALIDADO_PROVINCIA FOREIGN KEY (Provincia_Id) REFERENCES DataCore.Provincias(Provincia_Id);


/*

-- PROCEDURE: migrarTablaLocalidades
CREATE PROCEDURE DataCore.migrarTablaLocalidades
AS
BEGIN
    INSERT INTO DataCore.Localidades (Localidad_Id, Localidad_Provincia, Localidad_Direccion, Localidad_Nombre);
END
GO

-- PROCEDURE: migrarTablaTipoMateriales
CREATE PROCEDURE DataCore.migrarTablaTipoMateriales
AS
BEGIN
    INSERT INTO DataCore.TipoMateriales (TipoMaterial_Id, TipoMaterial_Tipo);
END
GO

-- PROCEDURE: migrarTablaMedidas
CREATE PROCEDURE DataCore.migrarTablaMedidas
AS
BEGIN
    INSERT INTO DataCore.Medidas (Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio);
END
GO

-- PROCEDURE: migrarTablaModelos_Sillones
CREATE PROCEDURE DataCore.migrarTablaModelos_Sillones
AS
BEGIN
    INSERT INTO DataCore.Modelos_Sillones (Sillon_Modelo_Codigo, Sillon_Modelo_Precio, Sillon_Modelo, Sillon_Modelo_Descripcion);
END
GO

-- PROCEDURE: migrarTablaProveedores
CREATE PROCEDURE DataCore.migrarTablaProveedores
AS
BEGIN
    INSERT INTO DataCore.Proveedores (Proveedor_Cuit, Proveedor_Provincia, Proveedor_RazonSocial, Proveedor_Direccion, Proveedor_Telefono, Proveedor_Mail, Localidad_Id);
END
GO

-- PROCEDURE: migrarTablaSucursales
CREATE PROCEDURE DataCore.migrarTablaSucursales
BEGIN
    INSERT INTO DataCore.Sucursales (Sucursal_NroSucursal, Sucursal_Provincia, Sucursal_Localidad, Sucursal_Direccion, Sucursal_Telefono, Sucursal_Mail, Localidad_Id);
END
GO

-- PROCEDURE: migrarTablaClientes
CREATE PROCEDURE DataCore.migrarTablaClientes
AS
BEGIN
    INSERT INTO DataCore.Clientes (Cliente_Dni, Cliente_Provincia, Cliente_Localidad, Cliente_Nombre, Cliente_Apellido, Cliente_FechaNacimiento, Cliente_Mail, Cliente_Direccion, Cliente_Telefono, Localidad_Id);
END
GO

-- PROCEDURE: migrarTablaTelas
CREATE PROCEDURE DataCore.migrarTablaTelas
AS
BEGIN
    INSERT INTO DataCore.Telas (TipoMaterial_Id, Tela_Color, Tela_Textura);
END
GO

-- PROCEDURE: migrarTablaMaderas
CREATE PROCEDURE DataCore.migrarTablaMaderas
BEGIN
    INSERT INTO DataCore.Maderas (TipoMaterial_Id, Madera_Color, Madera_Dureza);
END
GO

-- PROCEDURE: migrarTablaRellenos
CREATE PROCEDURE DataCore.migrarTablaRellenos
AS
BEGIN
    INSERT INTO DataCore.Rellenos (TipoMaterial_Id, Relleno_Densidad);
END
GO

-- PROCEDURE: migrarTablaMateriales
CREATE PROCEDURE DataCore.migrarTablaMateriales
AS
BEGIN
    INSERT INTO DataCore.Materiales (Material_Id, TipoMaterial_Id, Material_Nombre, Material_Descripcion, Material_Precio);
END
GO

-- PROCEDURE: migrarTablaSillones
CREATE PROCEDURE DataCore.migrarTablaSillones
AS
BEGIN
    INSERT INTO DataCore.Sillones (Sillon_Codigo, Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Modelo_Codigo);
END
GO

-- PROCEDURE: migrarTablaMateriales_Sillones
CREATE PROCEDURE DataCore.migrarTablaMateriales_Sillones
AS
BEGIN
    INSERT INTO DataCore.Materiales_Sillones (Material_Id, Sillon_Codigo);
END
GO

-- PROCEDURE: migrarTablaCompras
CREATE PROCEDURE DataCore.migrarTablaCompras
AS
BEGIN
    INSERT INTO DataCore.Compras (Compra_Numero, Compra_Fecha, Compra_Total, Sucursal_NroSucursal, Proveedor_Cuit);
END
GO

-- PROCEDURE: migrarTablaDetalles_Compras
CREATE PROCEDURE DataCore.migrarTablaDetalles_Compras
AS
BEGIN
    INSERT INTO DataCore.Detalles_Compras (Compra_Numero, Material_Id, Detalle_Compra_Cantidad, Detalle_Compra_Precio, Detalle_Compra_Subtotal);
END
GO

-- PROCEDURE: migrarTablaPedidos
CREATE PROCEDURE DataCore.migrarTablaPedidos
AS
BEGIN
    INSERT INTO DataCore.Pedidos (Pedido_Numero, Pedido_Fecha, Pedido_Estado, Pedido_Total, Sucursal_NroSucursal, Cliente_Dni);
END
GO

-- PROCEDURE: migrarTablaDetalles_Pedidos
CREATE PROCEDURE DataCore.migrarTablaDetalles_Pedidos
AS
BEGIN
    INSERT INTO DataCore.Detalles_Pedidos (Pedido_Numero, Sillon_Codigo, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal);
END
GO

-- PROCEDURE: migrarTablaPedidos_Cancelacion
CREATE PROCEDURE DataCore.migrarTablaPedidos_Cancelacion
AS
BEGIN
    INSERT INTO DataCore.Pedidos_Cancelacion (Pedido_Cancelacion_Num, Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo, Pedido_Numero);
END
GO

-- PROCEDURE: migrarTablaFacturas
CREATE PROCEDURE DataCore.migrarTablaFacturas
AS
BEGIN
    INSERT INTO DataCore.Facturas (Factura_Numero, Factura_Fecha, Factura_Total, Cliente_Dni, Sucursal_NroSucursal, Pedido_Numero);
END
GO

-- PROCEDURE: migrarTablaDetalles_Facturas
CREATE PROCEDURE DataCore.migrarTablaDetalles_Facturas
AS
BEGIN
    INSERT INTO DataCore.Detalles_Facturas (Factura_Numero, Pedido_Numero, Sillon_Codigo, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_Subtotal);
END
GO

-- PROCEDURE: migrarTablaEnvios
CREATE PROCEDURE DataCore.migrarTablaEnvios
AS
BEGIN
    INSERT INTO DataCore.Envios (Envio_Numero, Envio_Fecha_Programada, Envio_Fecha, Envio_ImporteTraslado, Envio_ImporteSubida, Envio_Total, Factura_Numero);
END
GO

*/

-- 1. Tablas independientes (sin FK)
EXEC DataCore.migrarTablaLocalidades;
EXEC DataCore.migrarTablaMedidas;
EXEC DataCore.migrarTablaModelos_Sillones;
EXEC DataCore.migrarTablaTipoMateriales;

-- 2. Tablas que dependen de las anteriores
EXEC DataCore.migrarTablaProveedores;
EXEC DataCore.migrarTablaSucursales;
EXEC DataCore.migrarTablaClientes;

-- 3. Tablas de materiales y subtipos
EXEC DataCore.migrarTablaMateriales;
EXEC DataCore.migrarTablaTelas;
EXEC DataCore.migrarTablaMaderas;
EXEC DataCore.migrarTablaRellenos;

-- 4. Tablas que dependen de medidas/modelos/materiales
EXEC DataCore.migrarTablaSillones;

-- 5. Tablas de relación y movimientos
EXEC DataCore.migrarTablaMateriales_Sillones;
EXEC DataCore.migrarTablaCompras;
EXEC DataCore.migrarTablaDetalles_Compras;
EXEC DataCore.migrarTablaPedidos;
EXEC DataCore.migrarTablaDetalles_Pedidos;
EXEC DataCore.migrarTablaPedidos_Cancelacion;
EXEC DataCore.migrarTablaFacturas;
EXEC DataCore.migrarTablaDetalles_Facturas;
EXEC DataCore.migrarTablaEnvios;
