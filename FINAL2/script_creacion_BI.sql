
CREATE PROCEDURE DATACORE.CrearTablasBI
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            -- DIMENSIONES
            CREATE TABLE DATACORE.BI_Dimension_Tiempo (
                Tiempo_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Anio INTEGER,
                Cuatrimestre TINYINT,
                Mes TINYINT
            );

            CREATE TABLE DATACORE.BI_Dimension_Sucursales (
                Sucursal_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Sucursal_NroSucursal BIGINT,
                Sucursal_telefono NVARCHAR(255),
                Sucursal_Direccion NVARCHAR(255),
                Sucursal_Mail NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_Ubicacion (
                Ubicacion_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Provincia NVARCHAR(255),
                Localidad NVARCHAR(255),
                Localidad_ID BIGINT,
                Provincia_ID BIGINT
            );

            CREATE TABLE DATACORE.BI_Dimension_RangoEtario (
                Rango_Etario_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Rango_Etario_Descripcion NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_Turno (
                Turno_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Horario NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_TipoMaterial (
                TipoMaterial_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                TipoMaterial_Tipo NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_ModeloSillon (
                Sillon_Modelo_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Sillon_Modelo_Codigo BIGINT,
                Sillon_Modelo_Descripcion NVARCHAR(255),
                Sillon_Modelo_Precio DECIMAL(18,2),
                Sillon_Modelo NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_Estado_Pedido (
                Estado_Pedido_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Estado_Pedido_Desc NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_Estado_Envio (
                Estado_Envio_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Estado_Envio_Desc NVARCHAR(255)
            );

            CREATE TABLE DATACORE.BI_Dimension_Dias_De_Fabricacion (
                Dias_Fabricacion_ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
                Dias_De_Fabricacion INTEGER
            );

            -- HECHOS
            CREATE TABLE DATACORE.BI_Hecho_Venta (
                Tiempo_ID BIGINT NOT NULL,
                Sucursal_ID BIGINT NOT NULL,
                Ubicacion_Sucursal_ID BIGINT NOT NULL,
                Rango_Etario_Cliente_ID BIGINT NOT NULL,
                Turno_ID BIGINT NOT NULL,
                Sillon_Modelo_ID BIGINT NOT NULL,
                Cantidad_Venta BIGINT,
                Precio_Venta DECIMAL(18,2),
                CONSTRAINT PK_Hecho_Venta PRIMARY KEY (
                    Tiempo_ID, Sucursal_ID, Ubicacion_Sucursal_ID, Rango_Etario_Cliente_ID, Turno_ID, Sillon_Modelo_ID
                )
            );

            CREATE TABLE DATACORE.BI_Hecho_Compra (
                Tiempo_ID BIGINT NOT NULL,
                Sucursal_ID BIGINT NOT NULL,
                TipoMaterial_ID BIGINT NOT NULL,
                Ubicacion_Proveedor_ID BIGINT NOT NULL,
                Ubicacion_Sucursal_ID BIGINT NOT NULL,
                Cantidad_Compra BIGINT,
                Precio_Compra DECIMAL(18,2),
                CONSTRAINT PK_Hecho_Compra PRIMARY KEY (
                    Tiempo_ID, Sucursal_ID, TipoMaterial_ID, Ubicacion_Proveedor_ID, Ubicacion_Sucursal_ID
                )
            );

            CREATE TABLE DATACORE.BI_Hecho_Envio (
                Tiempo_Programado_ID BIGINT NOT NULL, 
                Estado_Envio_ID BIGINT NOT NULL,
                Ubicacion_Destino_ID BIGINT NOT NULL,
                Cantidad_Envios BIGINT,
                Costo_Traslado_Total DECIMAL(18,2),
                Costo_Subida_Total DECIMAL(18,2),
                CONSTRAINT PK_Hecho_Envio PRIMARY KEY (
                    Tiempo_Programado_ID, Estado_Envio_ID, Ubicacion_Destino_ID
                )
            );

            CREATE TABLE DATACORE.BI_Hecho_Peticion (
                Tiempo_ID BIGINT NOT NULL,
                Rango_Etario_Cliente_ID BIGINT NOT NULL, 
                Tiempo_ID_Facturacion BIGINT NOT NULL,
                Sucursal_ID BIGINT NOT NULL,
                Turno_ID BIGINT NOT NULL,
                Estado_Pedido_ID BIGINT NOT NULL,
                Ubicacion_Cliente_ID BIGINT NOT NULL,
                Ubicacion_Sucursal_ID BIGINT NOT NULL,
                Dias_Fabricacion_ID BIGINT NOT NULL,
                Cantidad_Peticiones INTEGER,
                Costo_Peticion DECIMAL(18,2),
                CONSTRAINT PK_Hecho_Peticion PRIMARY KEY (
                    Tiempo_ID, Rango_Etario_Cliente_ID, Tiempo_ID_Facturacion, Sucursal_ID, Turno_ID, Estado_Pedido_ID, Ubicacion_Cliente_ID, Ubicacion_Sucursal_ID, Dias_Fabricacion_ID
                )
            );

            -- FOREIGN KEYS: HECHO_VENTA
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_RangoEtario FOREIGN KEY (Rango_Etario_Cliente_ID) REFERENCES DATACORE.BI_Dimension_RangoEtario(Rango_Etario_ID);
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_Turno FOREIGN KEY (Turno_ID) REFERENCES DATACORE.BI_Dimension_Turno(Turno_ID);
            ALTER TABLE DATACORE.BI_Hecho_Venta ADD CONSTRAINT FK_Venta_ModeloSillon FOREIGN KEY (Sillon_Modelo_ID) REFERENCES DATACORE.BI_Dimension_ModeloSillon(Sillon_Modelo_ID);

            -- FOREIGN KEYS: HECHO_COMPRA
            ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
            ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
            ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_TipoMaterial FOREIGN KEY (TipoMaterial_ID) REFERENCES DATACORE.BI_Dimension_TipoMaterial(TipoMaterial_ID);
            ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_UbicacionProveedor FOREIGN KEY (Ubicacion_Proveedor_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
            ALTER TABLE DATACORE.BI_Hecho_Compra ADD CONSTRAINT FK_Compra_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);

            -- FOREIGN KEYS: HECHO_ENVIO
            ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_TiempoProgramado FOREIGN KEY (Tiempo_Programado_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
            ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_EstadoEnvio FOREIGN KEY (Estado_Envio_ID) REFERENCES DATACORE.BI_Dimension_Estado_Envio(Estado_Envio_ID);
            ALTER TABLE DATACORE.BI_Hecho_Envio ADD CONSTRAINT FK_Envio_UbicacionDestino FOREIGN KEY (Ubicacion_Destino_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);

            -- FOREIGN KEYS: HECHO_PETICION
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Tiempo FOREIGN KEY (Tiempo_ID) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Sucursales(Sucursal_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_RangoEtario FOREIGN KEY (Rango_Etario_Cliente_ID) REFERENCES DATACORE.BI_Dimension_RangoEtario(Rango_Etario_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_Turno FOREIGN KEY (Turno_ID) REFERENCES DATACORE.BI_Dimension_Turno(Turno_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_EstadoPedido FOREIGN KEY (Estado_Pedido_ID) REFERENCES DATACORE.BI_Dimension_Estado_Pedido(Estado_Pedido_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_UbicacionCliente FOREIGN KEY (Ubicacion_Cliente_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_UbicacionSucursal FOREIGN KEY (Ubicacion_Sucursal_ID) REFERENCES DATACORE.BI_Dimension_Ubicacion(Ubicacion_ID);
            ALTER TABLE DATACORE.BI_Hecho_Peticion ADD CONSTRAINT FK_Peticion_TiempoFacturacion FOREIGN KEY (Tiempo_ID_Facturacion) REFERENCES DATACORE.BI_Dimension_Tiempo(Tiempo_ID);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION 
        PRINT ERROR_MESSAGE()
    END CATCH    
END
GO

EXEC DATACORE.CrearTablasBI
GO

-- En algunos casos quedo CEILING(DATEPART(MONTH, <Fecha>) / 4.0), es lo mismo que usar esta funcion
CREATE FUNCTION DATACORE.Cuatrimestre (@fecha datetime) 
RETURNS INTEGER 
AS
BEGIN
    DECLARE @id int;
    SET @id = CASE 
        WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
        WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3
        ELSE NULL
    END;
    RETURN @id;
END
GO

-- Recibe una edad int y devuelve el rango de esa edad
CREATE FUNCTION DATACORE.RangoEtario(
@FechaFactura DATETIME2, @FechaNacimientoCliente DATETIME2)
RETURNS NVARCHAR(30)
AS 
BEGIN
    DECLARE @Resultado NVARCHAR(50);
    DECLARE @Diferencia INTEGER
    SET @Diferencia = DATEDIFF(YEAR, @FechaNacimientoCliente, @FechaFactura)
        IF @Diferencia < 25
            SET @Resultado = '< 25'
        ELSE IF @Diferencia < 35
            SET @Resultado = '25-35'
        ELSE IF @Diferencia < 50
            SET @Resultado = '35-50'
        ELSE 
            SET @Resultado = '> 50'
        RETURN @Resultado
END
GO


-- Funcion que calcula en que turno ocurre una DateTime
CREATE FUNCTION DATACORE.Turno(@FechaFactura DATETIME2)
    RETURNS NVARCHAR(30)
AS 
BEGIN
    DECLARE @Resultado NVARCHAR(50);
    DECLARE @Hora Integer = DATEPART(HOUR, @FechaFactura)
        IF @Hora >= 8 AND @Hora <14
            SET @Resultado = '08:00 - 14:00'
        ELSE IF @Hora >= 14 AND @HORA <= 20
            SET @Resultado = '14:00 - 20:00'
        ELSE 
            SET @Resultado = 'Fuera de horario'
        RETURN @Resultado
END
GO

CREATE PROCEDURE DATACORE.CargarDimensionesBI
AS
BEGIN
    BEGIN TRY    
        BEGIN TRANSACTION
            -- ==========================
            -- Insertar datos en la DIM TIEMPO
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Tiempo (Anio, Cuatrimestre, Mes)
            SELECT DISTINCT
                YEAR(Fecha) AS Anio,
                DATACORE.Cuatrimestre(Fecha) AS Cuatrimestre,
                MONTH(Fecha) AS Mes
            FROM (
                SELECT DISTINCT Factura_Fecha AS Fecha FROM DATACORE.Facturas
                UNION
                SELECT DISTINCT Compra_Fecha FROM DATACORE.Compras
                UNION
                SELECT DISTINCT Pedido_Fecha FROM DATACORE.Pedidos
                UNION
                SELECT DISTINCT Envio_Fecha FROM DATACORE.Envios
                UNION
                SELECT DISTINCT Envio_Fecha_Programada FROM DATACORE.Envios
                UNION
                SELECT DISTINCT Cliente_FechaNacimiento FROM DATACORE.Clientes
                UNION
                SELECT DISTINCT Pedido_Cancelacion_Fecha FROM DATACORE.Pedidos_Cancelacion
                UNION
                SELECT NULL -- Tiempo Vacio (Para Pedidos con fecha_de_facturacion NULL porque no se facturaron)
            ) AS TodasLasFechas;

            -- ==========================
            -- Insertar datos en la DIM SUCURSALES
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Sucursales (
                Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail
            )
            SELECT DISTINCT 
                Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail
            FROM DATACORE.Sucursales;

            -- ==========================
            -- Insertar datos en la DIM UBICACIÓN
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Ubicacion (
                Provincia, Localidad, Localidad_ID, Provincia_ID
            )
            SELECT 
                p.Provincia_Nombre, l.Localidad_Nombre, l.Localidad_ID, p.Provincia_Id
            FROM DATACORE.Localidades l
            INNER JOIN DATACORE.Provincias p ON l.Provincia_ID = p.Provincia_ID;

            -- ==========================
            -- Insertar datos en la DIM MODELO SILLÓN
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_ModeloSillon (
                Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo
            )
            SELECT 
                Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo
            FROM DATACORE.Modelos_De_Sillones;

            -- ==========================
            -- Insertar datos en la DIM RANGO ETARIO
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_RangoEtario (Rango_Etario_Descripcion)
            VALUES 
                ('< 25'),
                ('25-35'),
                ('35-50'),
                ('> 50');

            -- ==========================
            -- Insertar datos en la DIM TURNO
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Turno (Horario)
            VALUES 
                ('08:00 - 14:00'),
                ('14:00 - 20:00'),
                ('Fuera de horario');

            -- ==========================
            -- Insertar datos en la DIM ESTADO PEDIDO
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Estado_Pedido (Estado_Pedido_Desc)
            SELECT DISTINCT Pedido_Estado
            FROM DATACORE.Pedidos;

            -- ==========================
            -- Insertar datos en la DIM ESTADO ENVÍO
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Estado_Envio (Estado_Envio_Desc)
            VALUES 
                ('No entregado'),
                ('Entregado en tiempo'),
                ('Entregado fuera de tiempo');

            -- ==========================
            -- Insertar datos en la DIM TIPO MATERIAL
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_TipoMaterial (TipoMaterial_Tipo)
            SELECT DISTINCT TipoMaterial_Tipo
            FROM DATACORE.TipoMateriales;

            -- ==========================
            -- Insertar datos en la DIM DÍAS DE FABRICACIÓN
            -- ==========================
            INSERT INTO DATACORE.BI_Dimension_Dias_De_Fabricacion (Dias_De_Fabricacion)
            SELECT NULL -- Pedidos cancelados
            UNION 
            SELECT DISTINCT DATEDIFF(DAY, Pedido_Fecha, Factura_Fecha)
            FROM DATACORE.Facturas f
            INNER JOIN DATACORE.Detalles_Facturas dtf ON dtf.Factura_Numero = f.Factura_Numero
            INNER JOIN DATACORE.Detalles_Pedidos dtp ON dtf.Sillon_Codigo = dtp.Sillon_Codigo AND dtp.Pedido_Numero = dtf.Pedido_Numero
            INNER JOIN DATACORE.Pedidos p ON dtp.Pedido_Numero = p.Pedido_Numero;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END

GO
EXEC DATACORE.CargarDimensionesBI
GO

CREATE PROCEDURE DATACORE.Importar_Hechos_Compra
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;;
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
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO

EXEC DATACORE.Importar_Hechos_Compra
GO

CREATE PROCEDURE DATACORE.Importar_Hechos_Ventas
AS
BEGIN
    BEGIN TRY
    BEGIN TRANSACTION;;
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
	    COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END

GO

EXEC DATACORE.Importar_Hechos_Ventas

GO

CREATE PROCEDURE DATACORE.Importar_Hechos_Envio
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO DATACORE.BI_Hecho_Envio (
            Tiempo_Programado_ID,
            Estado_Envio_ID,
            Ubicacion_Destino_ID,
            Cantidad_Envios,
            Costo_Traslado_Total,
            Costo_Subida_Total
            )
            SELECT
                tiProg.Tiempo_ID,
                ee.Estado_Envio_ID, 
                ubi.Ubicacion_ID,
                COUNT(e.Envio_Numero) AS Cantidad_Envios,
                SUM(e.Envio_ImporteTraslado) AS Costo_Traslado_Total,
                SUM(e.Envio_ImporteSubida) AS Costo_Subida_Total
            FROM DATACORE.Envios e
            INNER JOIN DATACORE.Facturas f ON f.Factura_Numero = e.Factura_Numero
            INNER JOIN DATACORE.Clientes c ON c.Cliente_DNI = f.Cliente_DNI
            INNER JOIN DATACORE.Localidades loc ON loc.Localidad_ID = c.Localidad_Id
            INNER JOIN DATACORE.Provincias p ON p.Provincia_ID = loc.Provincia_ID
            INNER JOIN DATACORE.BI_Dimension_Ubicacion ubi ON ubi.Localidad = loc.Localidad_Nombre AND ubi.Provincia = p.Provincia_Nombre
            INNER JOIN DATACORE.BI_Dimension_Tiempo tiProg ON tiProg.Anio = YEAR(e.Envio_Fecha_Programada) AND tiProg.Mes = MONTH(e.Envio_Fecha_Programada) AND tiProg.Cuatrimestre = DATACORE.Cuatrimestre(e.Envio_Fecha_Programada)
            INNER JOIN DATACORE.BI_Dimension_Estado_Envio ee ON ee.Estado_Envio_Desc = 
                CASE 
                    WHEN e.Envio_Fecha IS NULL THEN 'No entregado'
                    WHEN e.Envio_Fecha <= e.Envio_Fecha_Programada THEN 'Entregado en tiempo'
                    ELSE 'Entregado fuera de tiempo'
                END
        GROUP BY
            tiProg.Tiempo_ID,
            ee.Estado_Envio_ID,
            ubi.Ubicacion_ID;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END  
GO

EXEC DATACORE.Importar_Hechos_Envio
GO

CREATE PROCEDURE DATACORE.Importar_Hechos_Peticion
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO DATACORE.BI_Hecho_Peticion (
                    Tiempo_ID,
                    Tiempo_ID_Facturacion,
                    Rango_Etario_Cliente_ID,
                    Turno_ID,
                    Estado_Pedido_ID,
                    Ubicacion_Cliente_ID,
                    Ubicacion_Sucursal_ID,
                    Sucursal_ID,
                    Dias_Fabricacion_ID,
                    Cantidad_Peticiones,
                    Costo_Peticion
            )
            SELECT bdt.Tiempo_ID,
            ISNULL(bdf.Tiempo_ID, (SELECT Tiempo_ID FROM DATACORE.BI_Dimension_Tiempo WHERE Anio IS NULL AND Cuatrimestre IS NULL and Mes IS NULL))
            AS Tiempo_ID_Facturacion,
            Rango_Etario_ID, p.Turno_ID, bdep.Estado_Pedido_ID, bdus.Ubicacion_ID,
            bdc.Ubicacion_ID, Sucursal_ID, 
            ISNULL(Dias_Fabricacion_ID, (SELECT Dias_Fabricacion_ID FROM DATACORE.BI_Dimension_Dias_De_Fabricacion WHERE Dias_De_Fabricacion IS NULL))
            , COUNT(DISTINCT p.Pedido_Numero), SUM(p.Pedido_Total)
            FROM 
            (SELECT DISTINCT
                dp.Pedido_Numero, f.Factura_Fecha, p.Pedido_Fecha, t.Turno_ID ,p.Sucursal_NroSucursal, p.Pedido_Estado, p.Cliente_Dni,  DATEDIFF(DAY , p.Pedido_Fecha, f.Factura_Fecha) AS 'Dias_Fabricacion', p.Pedido_Total, f.Factura_Numero
            FROM DATACORE.Detalles_Pedidos dp
            INNER JOIN DATACORE.Pedidos p ON dp.Pedido_Numero = p.Pedido_Numero
            LEFT JOIN DATACORE.Detalles_Facturas df ON dp.Pedido_Numero = df.Pedido_Numero AND dp.Sillon_Codigo = df.Sillon_Codigo
            LEFT JOIN DATACORE.Facturas f ON df.Factura_Numero = f.Factura_Numero
            INNER JOIN DATACORE.BI_Dimension_Turno t ON t.Horario = DATACORE.Turno(p.Pedido_Fecha)
            ) p
            LEFT JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion df ON df.Dias_De_Fabricacion = p.Dias_Fabricacion
                INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND CEILING(DATEPART(MONTH, p.Pedido_Fecha) / 4.0) = bdt.Cuatrimestre
                LEFT JOIN DATACORE.BI_Dimension_Tiempo bdf ON YEAR(Factura_Fecha)=bdf.Anio AND MONTH(p.Factura_Fecha)=bdf.Mes AND CEILING(DATEPART(MONTH,p.Factura_Fecha) / 4.0) = bdf.Cuatrimestre
                INNER JOIN DATACORE.BI_Dimension_Sucursales bds ON p.Sucursal_NroSucursal = bds.Sucursal_NroSucursal
                INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bdep  ON p.Pedido_Estado = bdep.Estado_Pedido_Desc
                INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
                INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
                INNER JOIN DATACORE.BI_Dimension_Ubicacion bduc ON c.Localidad_Id = bduc.Localidad_ID AND lc.Provincia_Id=bduc.Provincia_ID
                INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal=s.Sucursal_NroSucursal
                INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id=ls.Localidad_Id
                INNER JOIN DATACORE.BI_Dimension_Ubicacion bdus ON s.Localidad_Id=bdus.Localidad_ID AND ls.Provincia_Id=bdus.Provincia_ID
                INNER JOIN DATACORE.BI_Dimension_Ubicacion bdc ON c.Localidad_Id=bdc.Localidad_ID AND lc.Provincia_Id=bdc.Provincia_ID
                INNER JOIN DATACORE.BI_Dimension_RangoEtario bdr ON bdr.Rango_Etario_Descripcion = DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento
                ) 
        GROUP BY bdt.Tiempo_ID, bdf.Tiempo_ID, Rango_Etario_ID, p.Turno_ID, Estado_Pedido_ID, bdus.Ubicacion_ID, bdc.Ubicacion_ID, Sucursal_ID, Dias_Fabricacion_ID 
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
END CATCH
END
GO

EXEC DATACORE.Importar_Hechos_Peticion
GO

--vista1
CREATE VIEW DATACORE.Vista_Ganancias_Por_Sucursal AS
SELECT 
    t.Anio,
    t.Mes,
    s.Sucursal_NroSucursal,
    --SUM(ISNULL(v.Precio_Venta, 0)) AS Total_Ingresos,
    --SUM(ISNULL(c.Precio_Compra, 0)) AS Total_Egresos,
    SUM(ISNULL(v.Precio_Venta, 0)) - SUM(ISNULL(c.Precio_Compra, 0)) AS Ganancia
FROM DATACORE.BI_Dimension_Tiempo t
JOIN DATACORE.BI_Hecho_Venta v ON v.Tiempo_ID = t.Tiempo_ID
JOIN DATACORE.BI_Hecho_Compra c ON c.Tiempo_ID = t.Tiempo_ID AND v.Sucursal_ID = c.Sucursal_ID
JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = v.Sucursal_ID
GROUP BY t.Anio, t.Mes, s.Sucursal_NroSucursal;
GO

--vista2
CREATE VIEW DATACORE.Vista_Factura_Promedio_Mensual AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    u.Provincia,
    SUM(v.Precio_Venta) /  -- Total facturado
    (SELECT COUNT(*) FROM DATACORE.BI_Hecho_Peticion p -- Cantidad de Pedidos, igual a cantidad de facturas mas los pedidos no facturados
    JOIN DATACORE.BI_Dimension_Tiempo tie ON tie.Tiempo_ID = p.Tiempo_ID_Facturacion 
    WHERE tie.Cuatrimestre = t.Cuatrimestre AND tie.Anio = t.Anio) / 4  -- Si no es pedido entregado, tiempo va con null y se excluye
    AS Factura_Promedio
FROM DATACORE.BI_Hecho_Venta v
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON v.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON v.Ubicacion_Sucursal_ID = u.Ubicacion_ID
GROUP BY t.Anio, t.Cuatrimestre, u.Provincia;
GO

--vista3

CREATE VIEW DATACORE.Vista_Top_Modelos_Por_Localidad_Y_Rango AS
SELECT *
FROM (
    SELECT 
        t.Anio,
        t.Cuatrimestre,
        u.Localidad,
        r.Rango_Etario_Descripcion,
        m.Sillon_Modelo,
        SUM(v.Cantidad_Venta) AS Total_Ventas,
        ROW_NUMBER() OVER (
            PARTITION BY t.Anio, t.Cuatrimestre, u.Localidad, r.Rango_Etario_Descripcion
            ORDER BY SUM(v.Cantidad_Venta) DESC
        ) AS Rank_Modelo
    FROM DATACORE.BI_Hecho_Venta v
    INNER JOIN DATACORE.BI_Dimension_Tiempo t ON v.Tiempo_ID = t.Tiempo_ID
    INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON v.Ubicacion_Sucursal_ID = u.Ubicacion_ID
    INNER JOIN DATACORE.BI_Dimension_RangoEtario r ON v.Rango_Etario_Cliente_ID = r.Rango_Etario_ID
    INNER JOIN DATACORE.BI_Dimension_ModeloSillon m ON v.Sillon_Modelo_ID = m.Sillon_Modelo_ID
    GROUP BY t.Anio, t.Cuatrimestre, u.Localidad, r.Rango_Etario_Descripcion, m.Sillon_Modelo
) AS TopModelos
WHERE Rank_Modelo <= 3;
GO


--vista4
CREATE VIEW DATACORE.Vista_Volumen_Pedidos AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    ep.Estado_Pedido_Desc,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal) AS Porcentaje
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON p.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON p.Sucursal_ID = s.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_Estado_Pedido ep ON p.Estado_Pedido_ID = ep.Estado_Pedido_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal, ep.Estado_Pedido_Desc;
GO

--vista5
CREATE VIEW DATACORE.Vista_Conversion_Pedidos AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    ep.Estado_Pedido_Desc,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal) AS Porcentaje
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON p.Tiempo_ID = t.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON p.Sucursal_ID = s.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_Estado_Pedido ep ON p.Estado_Pedido_ID = ep.Estado_Pedido_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal, ep.Estado_Pedido_Desc;
GO

-- Vista 6
CREATE VIEW DATACORE.Vista_Tiempo_Promedio_Fabricacion AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    AVG(df.Dias_De_Fabricacion * 1.0) AS Tiempo_Promedio_Dias
FROM DATACORE.BI_Hecho_Peticion p
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = p.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = p.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion df ON df.Dias_Fabricacion_ID = p.Dias_Fabricacion_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal;
GO

-- Vusta 7

CREATE VIEW DATACORE.VW_Promedio_Compras_Mensuales AS
SELECT 
    t.Anio,
    t.Mes,
    s.Sucursal_NroSucursal,
    AVG(hc.Precio_Compra) AS PromedioCompraMensual
FROM DATACORE.BI_Hecho_Compra hc
JOIN DATACORE.BI_Dimension_Tiempo t ON hc.Tiempo_ID = t.Tiempo_ID
JOIN DATACORE.BI_Dimension_Sucursales s ON hc.Sucursal_ID = s.Sucursal_ID
GROUP BY t.Anio, t.Mes, s.Sucursal_NroSucursal
GO

-- Vista 8

CREATE VIEW DATACORE.Vista_Compras_Por_TipoMaterial AS
SELECT 
    t.Anio,
    t.Cuatrimestre,
    s.Sucursal_NroSucursal,
    tm.TipoMaterial_Tipo,
    SUM(c.Precio_Compra) AS Total_Gastado
FROM DATACORE.BI_Hecho_Compra c
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = c.Tiempo_ID
INNER JOIN DATACORE.BI_Dimension_Sucursales s ON s.Sucursal_ID = c.Sucursal_ID
INNER JOIN DATACORE.BI_Dimension_TipoMaterial tm ON tm.TipoMaterial_ID = c.TipoMaterial_ID
GROUP BY t.Anio, t.Cuatrimestre, s.Sucursal_NroSucursal, tm.TipoMaterial_Tipo;
GO

-- Vista 9

CREATE VIEW DATACORE.Vista_Cumplimiento_Envios AS
SELECT 
    t.Anio,
    t.Mes,
    SUM(CASE WHEN ee.Estado_Envio_Desc = 'Entregado en tiempo' THEN he.Cantidad_Envios ELSE 0 END) * 100.0 /
        NULLIF(SUM(he.Cantidad_Envios), 0) AS Porcentaje_Cumplimiento
FROM DATACORE.BI_Hecho_Envio he
INNER JOIN DATACORE.BI_Dimension_Tiempo t ON t.Tiempo_ID = he.Tiempo_Programado_ID
INNER JOIN DATACORE.BI_Dimension_Estado_Envio ee ON ee.Estado_Envio_ID = he.Estado_Envio_ID
GROUP BY t.Anio, t.Mes;
GO


-- Vista 10
CREATE VIEW DATACORE.Vista_Localidades_Mayor_Costo_Envio AS
SELECT TOP 3
    u.Localidad,
    u.Provincia,
    AVG(he.Costo_Traslado_Total + he.Costo_Subida_Total) AS Promedio_Costo_Total
FROM DATACORE.BI_Hecho_Envio he
INNER JOIN DATACORE.BI_Dimension_Ubicacion u ON u.Ubicacion_ID = he.Ubicacion_Destino_ID
GROUP BY u.Localidad, u.Provincia
ORDER BY Promedio_Costo_Total DESC;

GO
