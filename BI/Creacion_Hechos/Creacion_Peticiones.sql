/*INSERT INTO DATACORE.BI_Hecho_Peticion(
    Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Dias_De_Fabricacion_ID,
    Cantidad_Peticiones ,
    Costo_Peticion)
SELECT 
    bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID,
    COUNT(DISTINCT p.Pedido_Numero) ,
    SUM(p.Pedido_Total)     
FROM DATACORE.Pedidos p 
	 INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND CEILING(DATEPART(MONTH, p.Pedido_Fecha) / 4.0) = bdt.Cuatrimestre
	 INNER JOIN DATACORE.BI_Dimension_Sucursales bds ON p.Sucursal_NroSucursal = bds.Sucursal_NroSucursal
	 INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bdep  ON p.Pedido_Estado = bdep.Estado_Pedido_Desc
	 INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
	 INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bduc ON c.Localidad_Id = bduc.Localidad_ID AND lc.Provincia_Id=bduc.Provincia_ID
	 INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal=s.Sucursal_NroSucursal
	 INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id=ls.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bdus ON s.Localidad_Id=bdus.Localidad_ID AND ls.Provincia_Id=bdus.Provincia_ID
	 INNER JOIN DATACORE.BI_Dimension_RangoEtario bdr ON bdr.Rango_Etario_Descripcion = DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento)
	 INNER JOIN DATACORE.BI_Dimension_Turno bdtu ON bdtu.Horario = DATACORE.Turno(p.Pedido_Fecha)
     INNER JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion bddf ON bddf.Dias_De_Fabricacion = (
		SELECT DISTINCT DATEDIFF(DAY, Pedido_Fecha, Factura_Fecha)
		FROM DATACORE.Facturas faux
		INNER JOIN DATACORE.Detalles_Facturas dtfaux ON dtfaux.Factura_Numero = faux.Factura_Numero
		INNER JOIN DATACORE.Detalles_Pedidos dtpaux ON dtfaux.Sillon_Codigo = dtpaux.Sillon_Codigo AND dtpaux.Pedido_Numero = dtfaux.Pedido_Numero
		INNER JOIN DATACORE.Pedidos paux ON dtpaux.Pedido_Numero = paux.Pedido_Numero
		WHERE paux.Pedido_Numero= p.Pedido_Numero)

GROUP BY bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID
*/



INSERT INTO DATACORE.BI_Hecho_Peticion(
    Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Dias_De_Fabricacion_ID,
    Cantidad_Peticiones ,
    Costo_Peticion)
SELECT
    bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID,
    COUNT(DISTINCT p.Pedido_Numero) ,
    SUM(p.Pedido_Total)    
FROM DATACORE.Pedidos p 
	 INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND DATACORE.Cuatrimestre(Pedido_Fecha) = bdt.Cuatrimestre
	 INNER JOIN DATACORE.BI_Dimension_Sucursales bds ON p.Sucursal_NroSucursal = bds.Sucursal_NroSucursal
	 INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bdep  ON p.Pedido_Estado = bdep.Estado_Pedido_Desc
	 INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
	 INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bduc ON c.Localidad_Id = bduc.Localidad_ID AND lc.Provincia_Id=bduc.Provincia_ID
	 INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal=s.Sucursal_NroSucursal
	 INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id=ls.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bdus ON s.Localidad_Id=bdus.Localidad_ID AND ls.Provincia_Id=bdus.Provincia_ID
	 INNER JOIN DATACORE.BI_Dimension_RangoEtario bdr ON bdr.Rango_Etario_Descripcion = DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento)
	 INNER JOIN DATACORE.BI_Dimension_Turno bdtu ON bdtu.Horario = DATACORE.Turno(p.Pedido_Fecha)
	 INNER JOIN DATACORE.Detalles_Pedidos dtp ON dtp.Pedido_Numero = p.Pedido_Numero
	 INNER JOIN DATACORE.Detalles_Facturas dtf ON dtp.Pedido_Numero = dtf.Pedido_Numero AND dtp.Sillon_Codigo = dtf.Sillon_Codigo
	 INNER JOIN DATACORE.Facturas fac ON fac.Factura_Numero = dtf.Factura_Numero
     INNER JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion bddf ON bddf.Dias_De_Fabricacion = DATEDIFF(DAY, p.Pedido_Fecha, fac.Factura_Fecha)

GROUP BY bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID

/*
CREATE PROCEDURE DATACORE.Importar_Hechos_Peticion
AS
BEGIN
    -- CTE: Calcula días de fabricación por pedido (puede ser NULL si no fue facturado)
    WITH DiasFabricacionPorPedido AS (
        SELECT 
            p.Pedido_Numero,
            DATEDIFF(DAY, p.Pedido_Fecha, f.Factura_Fecha) AS DiasFabricacion
        FROM DATACORE.Pedidos p
        LEFT JOIN DATACORE.Detalles_Pedidos dp ON dp.Pedido_Numero = p.Pedido_Numero
        LEFT JOIN DATACORE.Detalles_Facturas df ON df.Pedido_Numero = dp.Pedido_Numero AND df.Sillon_Codigo = dp.Sillon_Codigo
        LEFT JOIN DATACORE.Facturas f ON f.Factura_Numero = df.Factura_Numero
    ),
    
    TempPeticiones AS (
        SELECT 
            DATACORE.getTiempoID(p.Pedido_Fecha) AS TiempoID,
            DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento) AS RangoEtario,
            DATACORE.Turno(p.Pedido_Fecha) AS Turno,
            p.Pedido_Estado AS EstadoPedido,
            s.Sucursal_NroSucursal AS NroSucursal,

            lc.Localidad_ID AS LocalidadIDCliente,
            lc.Provincia_ID AS ProvinciaIDCliente,
            ls.Localidad_ID AS LocalidadIDSucursal,
            ls.Provincia_ID AS ProvinciaIDSucursal,

            dfpp.DiasFabricacion AS DiasFabricacion,
            COUNT(DISTINCT p.Pedido_Numero) AS CantidadPeticiones,
            SUM(p.Pedido_Total) AS CostoTotal
        FROM DATACORE.Pedidos p
        INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
        INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
        INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal = s.Sucursal_NroSucursal
        INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id = ls.Localidad_Id
        LEFT JOIN DiasFabricacionPorPedido dfpp ON p.Pedido_Numero = dfpp.Pedido_Numero
        GROUP BY 
            DATACORE.getTiempoID(p.Pedido_Fecha),
            DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento),
            DATACORE.Turno(p.Pedido_Fecha),
            p.Pedido_Estado,
            s.Sucursal_NroSucursal,
            lc.Localidad_ID, lc.Provincia_ID,
            ls.Localidad_ID, ls.Provincia_ID,
            dfpp.DiasFabricacion
    )

    INSERT INTO DATACORE.BI_Hecho_Peticion (
        Tiempo_ID,
        Rango_Etario_Cliente_ID,
        Sucursal_ID,
        Turno_ID,
        Estado_Pedido_ID,
        Ubicacion_Cliente_ID,
        Ubicacion_Sucursal_ID,
        Dias_De_Fabricacion_ID,
        Cantidad_Peticiones,
        Costo_Peticion
    )
    SELECT 
        tp.TiempoID,
        bre.Rango_Etario_ID,
        bs.Sucursal_ID,
        bt.Turno_ID,
        bep.Estado_Pedido_ID,
        buc.Ubicacion_ID,
        bus.Ubicacion_ID,
        bdf.Dias_Fabricacion_ID,
        tp.CantidadPeticiones,
        tp.CostoTotal
    FROM TempPeticiones tp
    INNER JOIN DATACORE.BI_Dimension_Sucursales bs ON bs.Sucursal_NroSucursal = tp.NroSucursal
    INNER JOIN DATACORE.BI_Dimension_RangoEtario bre ON bre.Rango_Etario_Descripcion = tp.RangoEtario
    INNER JOIN DATACORE.BI_Dimension_Turno bt ON bt.Horario = tp.Turno
    INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bep ON bep.Estado_Pedido_Desc = tp.EstadoPedido
    INNER JOIN DATACORE.BI_Dimension_Ubicacion buc ON buc.Localidad_ID = tp.LocalidadIDCliente AND buc.Provincia_ID = tp.ProvinciaIDCliente
    INNER JOIN DATACORE.BI_Dimension_Ubicacion bus ON bus.Localidad_ID = tp.LocalidadIDSucursal AND bus.Provincia_ID = tp.ProvinciaIDSucursal
    LEFT JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion bdf ON bdf.Dias_De_Fabricacion = tp.DiasFabricacion
END
GO

*/


/*
CREATE PROCEDURE DATACORE.Importar_Hechos_Peticion
AS
BEGIN
INSERT INTO DATACORE.BI_Hecho_Peticion(
    Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Dias_De_Fabricacion_ID,
    Cantidad_Peticiones ,
    Costo_Peticion)
SELECT 
    bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID,
    COUNT(p.Pedido_Numero) ,
    SUM(p.Pedido_Total)
FROM DATACORE.Pedidos p 
	 INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND CEILING(DATEPART(MONTH, p.Pedido_Fecha) / 4.0) = bdt.Cuatrimestre
	 INNER JOIN DATACORE.BI_Dimension_Sucursales bds ON p.Sucursal_NroSucursal = bds.Sucursal_NroSucursal
	 INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bdep  ON p.Pedido_Estado = bdep.Estado_Pedido_Desc
	 INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
	 INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bduc ON c.Localidad_Id = bduc.Localidad_ID AND lc.Provincia_Id=bduc.Provincia_ID
	 INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal=s.Sucursal_NroSucursal
	 INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id=ls.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bdus ON s.Localidad_Id=bdus.Localidad_ID AND ls.Provincia_Id=bdus.Provincia_ID
	 INNER JOIN DATACORE.BI_Dimension_RangoEtario bdr ON bdr.Rango_Etario_Descripcion = DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento)
	 INNER JOIN DATACORE.BI_Dimension_Turno bdtu ON bdtu.Horario = DATACORE.Turno(p.Pedido_Fecha)
     INNER JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion bddf ON bddf.Dias_De_Fabricacion = (
		SELECT DISTINCT COALESCE(DATEDIFF(DAY, Pedido_Fecha, Factura_Fecha), -1)
		FROM DATACORE.Facturas faux
		INNER JOIN DATACORE.Detalles_Facturas dtfaux ON dtfaux.Factura_Numero = faux.Factura_Numero
		INNER JOIN DATACORE.Detalles_Pedidos dtpaux ON dtfaux.Sillon_Codigo = dtpaux.Sillon_Codigo AND dtpaux.Pedido_Numero = dtfaux.Pedido_Numero
		RIGHT JOIN DATACORE.Pedidos paux ON dtpaux.Pedido_Numero = paux.Pedido_Numero
		WHERE paux.Pedido_Numero= p.Pedido_Numero)
GROUP BY bdt.Tiempo_ID,
    bdr.Rango_Etario_ID, 
    bds.Sucursal_ID,
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,
    bduc.Ubicacion_ID, 
    bdus.Ubicacion_ID,
    bddf.Dias_Fabricacion_ID
END*/