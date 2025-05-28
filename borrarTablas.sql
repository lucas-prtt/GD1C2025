CREATE PROCEDURE DataCore.borrarTablas -- Eliminar todas las tablas de la base de datos 
AS
BEGIN
    
    DROP TABLE IF EXISTS DataCore.Envios;
    DROP TABLE IF EXISTS DataCore.Detalles_Facturas;
    DROP TABLE IF EXISTS DataCore.Facturas;
    DROP TABLE IF EXISTS DataCore.Pedidos_Cancelacion;
    DROP TABLE IF EXISTS DataCore.Detalles_Pedidos;
    DROP TABLE IF EXISTS DataCore.Pedidos;
    DROP TABLE IF EXISTS DataCore.Detalles_Compras;
    DROP TABLE IF EXISTS DataCore.Compras;
    DROP TABLE IF EXISTS DataCore.Materiales_Sillones;
    DROP TABLE IF EXISTS DataCore.Sillones;
    DROP TABLE IF EXISTS DataCore.Materiales;
    DROP TABLE IF EXISTS DataCore.Rellenos;
    DROP TABLE IF EXISTS DataCore.Maderas;
    DROP TABLE IF EXISTS DataCore.Telas;
    DROP TABLE IF EXISTS DataCore.TipoMateriales;
    DROP TABLE IF EXISTS DataCore.Modelos_Sillones;
    DROP TABLE IF EXISTS DataCore.Medidas;
    DROP TABLE IF EXISTS DataCore.Clientes;
    DROP TABLE IF EXISTS DataCore.Sucursales;
    DROP TABLE IF EXISTS DataCore.Proveedores;
    DROP TABLE IF EXISTS DataCore.Localidades;
    DROP TABLE IF EXISTS DataCore.Provincias;
END

GO
