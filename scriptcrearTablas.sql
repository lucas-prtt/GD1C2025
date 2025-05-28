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
