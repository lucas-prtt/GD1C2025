--          DIMENSIONES
BEGIN TRAN
GO
--          DIMENSIONES

CREATE TABLE DATACORE.BI_Dimension_Tiempo (
    Tiempo_ID BIGINT IDENTITY(1,1) NOT NULL,
    Anio INTEGER,
    Cuatrimestre TINYINT,
    Mes TINYINT
);

CREATE TABLE DATACORE.BI_Dimension_Sucursales (
    Sucursal_ID BIGINT IDENTITY(1,1) NOT NULL,
    Sucursal_NroSucursal BIGINT,
    Sucursal_telefono NVARCHAR(255),
    Sucursal_Direccion NVARCHAR(255),
    Sucursal_Mail NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_Ubicacion (
    Ubicacion_ID BIGINT IDENTITY(1,1) NOT NULL,
    Provincia NVARCHAR(255),
    Localidad NVARCHAR(255),
    Localidad_ID BIGINT,
    Provincia_ID BIGINT
);

CREATE TABLE DATACORE.BI_Dimension_RangoEtario (
    Rango_Etario_ID BIGINT IDENTITY(1,1) NOT NULL,
    Rango_Etario_Descripcion NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_Turno (
    Turno_ID BIGINT IDENTITY(1,1) NOT NULL,
    Horario NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_TipoMaterial (
    TipoMaterial_ID BIGINT IDENTITY(1,1) NOT NULL,
    TipoMaterial_Tipo NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_ModeloSillon (
    Sillon_Modelo_ID BIGINT IDENTITY(1,1) NOT NULL,
    Sillon_Modelo_Codigo BIGINT,
    Sillon_Modelo_Descripcion NVARCHAR(255),
    Sillon_Modelo_Precio DECIMAL(18,2),
    Sillon_Modelo NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_Estado_Pedido (
    Estado_Pedido_ID BIGINT IDENTITY(1,1) NOT NULL,
    Estado_Pedido_Desc NVARCHAR(255)
);

CREATE TABLE DATACORE.BI_Dimension_Orden_De_Compra (
    Orden_De_Compra_ID BIGINT IDENTITY(1,1) NOT NULL,
    Compra_Numero BIGINT
);

CREATE TABLE DATACORE.BI_Dimension_Factura (
    Factura_ID BIGINT IDENTITY(1,1) NOT NULL,
    Factura_Numero BIGINT
);

CREATE TABLE DATACORE.BI_Dimension_Pedido (
    Pedido_ID BIGINT IDENTITY(1,1) NOT NULL,
    Pedido_Numero BIGINT
);

--          HECHOS

CREATE TABLE DATACORE.BI_Hecho_Venta (
    Tiempo_ID BIGINT NOT NULL,
    Sucursal_ID BIGINT NOT NULL,
    Ubicacion_Cliente_ID BIGINT NOT NULL,
    Ubicacion_Sucursal_ID BIGINT NOT NULL,
    Rango_Etario_Cliente_ID BIGINT NOT NULL,
    Turno_ID BIGINT NOT NULL,
    Sillon_Modelo_ID BIGINT NOT NULL,
    Factura_ID BIGINT NOT NULL,
    Pedido_ID BIGINT NOT NULL,
    Cantidad_Venta BIGINT,
    Precio_Venta DECIMAL(18,2)
);

CREATE TABLE DATACORE.BI_Hecho_Compra (
    Tiempo_ID BIGINT  NOT NULL,
    Sucursal_ID BIGINT  NOT NULL,
    TipoMaterial_ID BIGINT  NOT NULL,
    Ubicacion_Proveedor_ID BIGINT  NOT NULL,
    Orden_De_Compra_ID BIGINT  NOT NULL,
    Ubicacion_Sucursal_ID BIGINT  NOT NULL,
    Cantidad_Compra BIGINT,
    Precio_Compra DECIMAL(18,2)
);

CREATE TABLE DATACORE.BI_Hecho_Envio (
    Tiempo_Programado_ID BIGINT  NOT NULL, 
    Tiempo_Realizado_ID BIGINT  NOT NULL,
    Ubicacion_Destino_ID BIGINT  NOT NULL,
    Sucursal_ID BIGINT  NOT NULL,
    Factura_ID BIGINT  NOT NULL,
    Costo_Envio DECIMAL(18,2)
);

CREATE TABLE DATACORE.BI_Hecho_Peticion (
    Tiempo_ID BIGINT  NOT NULL,
    Rango_Etario_Cliente_ID BIGINT  NOT NULL, 
    Sucursal_ID BIGINT  NOT NULL,
    Turno_ID BIGINT  NOT NULL,
    Estado_Pedido_ID BIGINT  NOT NULL,
    Ubicacion_Cliente_ID BIGINT  NOT NULL,
    Ubicacion_Sucursal_ID BIGINT  NOT NULL,
    Pedido_ID BIGINT  NOT NULL,
    Costo_Peticion DECIMAL(18,2)
);

GO
-- PKS de Dimensiones
ALTER TABLE DATACORE.BI_Dimension_Tiempo ADD CONSTRAINT PK_Dimension_Tiempo PRIMARY KEY (Tiempo_ID);
ALTER TABLE DATACORE.BI_Dimension_Ubicacion ADD CONSTRAINT PK_Dimension_Ubicacion PRIMARY KEY (Ubicacion_ID);
ALTER TABLE DATACORE.BI_Dimension_RangoEtario ADD CONSTRAINT PK_Dimension_RangoEtario PRIMARY KEY (Rango_Etario_ID);
ALTER TABLE DATACORE.BI_Dimension_Turno ADD CONSTRAINT PK_Dimension_Turno PRIMARY KEY (Turno_ID);
ALTER TABLE DATACORE.BI_Dimension_TipoMaterial ADD CONSTRAINT PK_Dimension_TipoMaterial PRIMARY KEY (TipoMaterial_ID);
ALTER TABLE DATACORE.BI_Dimension_ModeloSillon ADD CONSTRAINT PK_Dimension_ModeloSillon PRIMARY KEY (Sillon_Modelo_ID);
ALTER TABLE DATACORE.BI_Dimension_Estado_Pedido ADD CONSTRAINT PK_Dimension_Estado_Pedido PRIMARY KEY (Estado_Pedido_ID);
ALTER TABLE DATACORE.BI_Dimension_Sucursales ADD CONSTRAINT PK_Dimension_Sucursales PRIMARY KEY (Sucursal_ID);
ALTER TABLE DATACORE.BI_Dimension_Orden_De_Compra ADD CONSTRAINT PK_Dimension_Orden_De_Compra PRIMARY KEY (Orden_De_Compra_ID);
ALTER TABLE DATACORE.BI_Dimension_Factura ADD CONSTRAINT PK_Dimension_Factura PRIMARY KEY (Factura_ID);
ALTER TABLE DATACORE.BI_Dimension_Pedido ADD CONSTRAINT PK_Dimension_Pedido PRIMARY KEY (Pedido_ID);

-- PKS de Hechos
ALTER TABLE DATACORE.BI_Hecho_Compra
ADD CONSTRAINT PK_Hecho_Compra
PRIMARY KEY (
  Tiempo_ID,
  Sucursal_ID,
  TipoMaterial_ID,
  Ubicacion_Proveedor_ID,
  Orden_De_Compra_ID,
  Ubicacion_Sucursal_ID
);

ALTER TABLE DATACORE.BI_Hecho_Envio
ADD CONSTRAINT PK_Hecho_Envio
PRIMARY KEY (
  Tiempo_Programado_ID,
  Tiempo_Realizado_ID,
  Ubicacion_Destino_ID,
  Sucursal_ID,
  Factura_ID
);

ALTER TABLE DATACORE.BI_Hecho_Peticion
ADD CONSTRAINT PK_Hecho_Peticion
PRIMARY KEY (
  Tiempo_ID,
  Rango_Etario_Cliente_ID,
  Sucursal_ID,
  Turno_ID,
  Estado_Pedido_ID,
  Ubicacion_Cliente_ID,
  Ubicacion_Sucursal_ID,
  Pedido_ID
);

ALTER TABLE DATACORE.BI_Hecho_Venta
ADD CONSTRAINT PK_Hecho_Venta
PRIMARY KEY (
  Tiempo_ID,
  Ubicacion_Cliente_ID,
  Rango_Etario_Cliente_ID,
  Turno_ID,
  Sillon_Modelo_ID,
  Sucursal_ID,
  Ubicacion_Sucursal_ID,
  Factura_ID,
  Pedido_ID
);

--FKs (de hechos)
-- Hecho_Venta
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_UbicacionCliente FOREIGN KEY (Ubicacion_Cliente_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_RangoEtario FOREIGN KEY (Rango_Etario_Cliente_ID) REFERENCES DATACORE.BI_Dimension_RangoEtario(Rango_Etario_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_Turno FOREIGN KEY (Turno_ID) REFERENCES DATACORE.BI_Dimension_Turno(Turno_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_ModeloSillon FOREIGN KEY (Sillon_Modelo_ID) REFERENCES DATACORE.BI_Dimension_ModeloSillon(Sillon_Modelo_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_Factura FOREIGN KEY (Factura_ID) REFERENCES DATACORE.BI_Dimension_Factura(Factura_ID);
ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Hecho_Venta_Dimension_Pedido FOREIGN KEY (Pedido_ID) REFERENCES DATACORE.BI_Dimension_Pedido(Pedido_ID);

-- Hecho_Peticion
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_RangoEtario FOREIGN KEY (Rango_Etario_Cliente_ID) REFERENCES DATACORE.BI_Dimension_RangoEtario(Rango_Etario_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_Turno FOREIGN KEY (Turno_ID) REFERENCES DATACORE.BI_Dimension_Turno(Turno_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_EstadoPedido FOREIGN KEY (Estado_Pedido_ID) REFERENCES DATACORE.BI_Dimension_Estado_Pedido(Estado_Pedido_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_UbicacionCliente FOREIGN KEY (Ubicacion_Cliente_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Dimension_Pedido FOREIGN KEY (Pedido_ID) REFERENCES DATACORE.BI_Dimension_Pedido(Pedido_ID);

-- Hecho_Envio
ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_Dimension_TiempoProgramado FOREIGN KEY (Tiempo_Programado_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_Dimension_TiempoRealizado FOREIGN KEY (Tiempo_Realizado_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_Dimension_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_Dimension_UbicacionDestino FOREIGN KEY (Ubicacion_Destino_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_Dimension_Factura FOREIGN KEY (Factura_ID) REFERENCES DATACORE.BI_Dimension_Factura(Factura_ID);


-- Hecho_Compra
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_TipoMaterial FOREIGN KEY (TipoMaterial_ID) REFERENCES DATACORE.BI_Dimension_TipoMaterial(TipoMaterial_ID);
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_UbicacionProveedor FOREIGN KEY (Ubicacion_Proveedor_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_OrdenCompra FOREIGN KEY (Orden_De_Compra_ID) REFERENCES DATACORE.BI_Dimension_Orden_De_Compra(Orden_De_Compra_ID);
ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Dimension_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);






GO
--ROLLBACK
COMMIT
