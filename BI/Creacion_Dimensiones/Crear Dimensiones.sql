-- ACA VA TODOS LOS PROCEDURES QUE IMPORTAN TODOS LAS DIMENSIONES


BEGIN TRANSACTION


GO

---------------- Insertar datos en la tabla BI_Dimension_Tiempo
-- TIEMPO
INSERT INTO DATACORE.BI_Dimension_Tiempo (Anio, Cuatrimestre, Mes)
SELECT
	YEAR(Fecha) AS Anio, 
	MONTH(Fecha) AS Mes, 
	DATEPART(QUARTER, Fecha) AS Cuatrimestre
FROM (
    SELECT DISTINCT Factura_Fecha AS Fecha FROM DATACORE.Facturas
    UNION
    SELECT DISTINCT Compra_Fecha FROM DATACORE.Compras 
    UNION
    SELECT DISTINCT Pedido_Fecha FROM  DATACORE.Pedidos
    UNION
    SELECT DISTINCT Envio_Fecha FROM DATACORE.Envios
    UNION
    SELECT DISTINCT Envio_Fecha_Programada FROM DATACORE.Envios
    UNION
    SELECT DISTINCT Cliente_FechaNacimiento FROM DATACORE.Clientes
    UNION
    SELECT DISTINCT Pedido_Cancelacion_Fecha FROM DATACORE.Pedidos_Cancelacion
) AS TodasLasFechasDeLaBaseDeDatos

-------------- Insertar datos en la tabla BI_Dimension_Sucursales
INSERT INTO DATACORE.BI_Dimension_Sucursales (Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail)
SELECT DISTINCT Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_Mail
FROM DATACORE.Sucursales


---------------Insertar datos en la tabla BI_Dimension_Factura
INSERT INTO DATACORE.BI_Dimension_Factura (Factura_Numero)      
SELECT DISTINCT Factura_Numero
FROM DATACORE.Facturas

---------------Insertar datos en la tabla BI_Dimension_Ubicacion
INSERT INTO DATACORE.BI_Dimension_Ubicacion (Provincia, Localidad)
SELECT p.Provincia_Nombre, l.Localidad_Nombre
FROM DATACORE.Localidades l INNER JOIN DATACORE.Provincias p ON l.Provincia_ID=p.Provincia_ID

---------------Insertar datos en la tabla BI_Dimension_ModeloSillon
INSERT INTO DATACORE.BI_Dimension_ModeloSillon (Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo)
SELECT Sillon_Modelo_Codigo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio, Sillon_Modelo
FROM DATACORE.Modelos_De_Sillones


---------------Insertar datos en la tabla BI_Dimension_Rango_Etario
INSERT INTO DATACORE.BI_Dimension_RangoEtario(Rango_Etario_Descripcion)
VALUES ('< 25'), ('25-35'), ('35-50'), ('> 50')

---------------Insertar datos en la tabla BI_Dimension_Turno
INSERT INTO DATACORE.BI_Dimension_Turno(horario)
VALUES ('08:00 - 14:00'), ('14:00 - 20:00'), ('Fuera de horario')

---------------Insertar datos en la tabla BI_Dimension_Estado_Pedido
INSERT INTO DATACORE.BI_Dimension_Estado_Pedido(Estado_Pedido_Desc)
SELECT  DISTINCT Pedido_Numero
FROM DATACORE.Pedidos

---------------Insertar datos en la tabla BI_Dimension_TipoMaterial
INSERT INTO DATACORE.BI_Dimension_TipoMaterial(TipoMaterial_Tipo)
SELECT DISTinct TipoMaterial_Tipo
FROM DATACORE.TipoMateriales

---------------Insertar datos en la tabla BI_Dimension_Pedido
INSERT INTO DATACORE.BI_Dimension_Pedido(Pedido_Numero)
SELECT DISTINCT Pedido_Numero FROM DATACORE.Pedidos


---------------Insertar datos ne la Tabla BI_Dimension_Orden_De_Compra
INSERT INTO DATACORE.BI_Dimension_Orden_De_Compra (Compra_Numero)
SELECT Compra_Numero
FROM DATACORE.Compras
GO
--ROLLBACK
COMMIT 
