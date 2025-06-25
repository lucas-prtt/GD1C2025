BEGIN TRANSACTION
GO

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
    SELECT NULL
) AS TodasLasFechas

-- ==========================
-- Insertar datos en la DIM SUCURSALES
-- ==========================
INSERT INTO DATACORE.BI_Dimension_Sucursales (
    Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail
)
SELECT DISTINCT 
    Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail
FROM DATACORE.Sucursales

-- ==========================
-- Insertar datos en la DIM UBICACIÓN
-- ==========================
INSERT INTO DATACORE.BI_Dimension_Ubicacion (
    Provincia, Localidad, Localidad_ID, Provincia_ID
)
SELECT 
    p.Provincia_Nombre, l.Localidad_Nombre, l.Localidad_ID, p.Provincia_Id
FROM DATACORE.Localidades l
INNER JOIN DATACORE.Provincias p ON l.Provincia_ID = p.Provincia_ID

-- ==========================
-- Insertar datos en la DIM MODELO SILLÓN
-- ==========================
INSERT INTO DATACORE.BI_Dimension_ModeloSillon (
    Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo
)
SELECT 
    Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo
FROM DATACORE.Modelos_De_Sillones

-- ==========================
-- Insertar datos en la DIM RANGO ETARIO
-- ==========================
INSERT INTO DATACORE.BI_Dimension_RangoEtario (Rango_Etario_Descripcion)
VALUES 
    ('< 25'),
    ('25-35'),
    ('35-50'),
    ('> 50')

-- ==========================
-- Insertar datos en la DIM TURNO
-- ==========================
INSERT INTO DATACORE.BI_Dimension_Turno (Horario)
VALUES 
    ('08:00 - 14:00'),
    ('14:00 - 20:00'),
    ('Fuera de horario')

-- ==========================
-- Insertar datos en la DIM ESTADO PEDIDO
-- ==========================
INSERT INTO DATACORE.BI_Dimension_Estado_Pedido (Estado_Pedido_Desc)
SELECT DISTINCT Pedido_Estado
FROM DATACORE.Pedidos

-- ==========================
-- Insertar datos en la DIM ESTADO ENVÍO
-- ==========================
INSERT INTO DATACORE.BI_Dimension_Estado_Envio (Estado_Envio_Desc)
VALUES 
    ('No entregado'),
    ('Entregado en tiempo'),
    ('Entregado fuera de tiempo')


-- ==========================
-- Insertar datos en la DIM TIPO MATERIAL
-- ==========================
INSERT INTO DATACORE.BI_Dimension_TipoMaterial (TipoMaterial_Tipo)
SELECT DISTINCT TipoMaterial_Tipo
FROM DATACORE.TipoMateriales

-- ==========================
-- Insertar datos en la DIM DÍAS DE FABRICACIÓN
-- ==========================
-- Se deduce desde pedidos (fecha creación vs. fecha concreción)
INSERT INTO DATACORE.BI_Dimension_Dias_De_Fabricacion (Dias_De_Fabricacion)
SELECT NULL -- Pedidos cancelados
UNION 
SELECT DISTINCT DATEDIFF(DAY, Pedido_Fecha, Factura_Fecha)
FROM DATACORE.Facturas f
INNER JOIN DATACORE.Detalles_Facturas dtf ON dtf.Factura_Numero = f.Factura_Numero
INNER JOIN DATACORE.Detalles_Pedidos dtp ON dtf.Sillon_Codigo = dtp.Sillon_Codigo AND dtp.Pedido_Numero = dtf.Pedido_Numero
INNER JOIN DATACORE.Pedidos p ON dtp.Pedido_Numero = p.Pedido_Numero


GO
--ROLLBACK
COMMIT
