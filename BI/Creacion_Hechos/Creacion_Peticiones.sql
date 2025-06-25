INSERT INTO DATACORE.BI_Hecho_Peticion (
        Tiempo_ID,
        Rango_Etario_Cliente_ID,
        Turno_ID,
        Estado_Pedido_ID,
        Ubicacion_Cliente_ID,
        Ubicacion_Sucursal_ID,
        Sucursal_ID,
        Dias_De_Fabricacion_ID,
        Cantidad_Peticiones,
        Costo_Peticion
)
SELECT Tiempo_ID, Rango_Etario_ID, p.Turno_ID, bdep.Estado_Pedido_ID, bdus.Ubicacion_ID,
bdc.Ubicacion_ID, Sucursal_ID, 
ISNULL(Dias_Fabricacion_ID, (SELECT Dias_Fabricacion_ID FROM DATACORE.BI_Dimension_Dias_De_Fabricacion WHERE Dias_De_Fabricacion IS NULL))
, COUNT(DISTINCT p.Pedido_Numero), SUM(p.Pedido_Total) 
FROM 
	(SELECT DISTINCT
		dp.Pedido_Numero, p.Pedido_Fecha, t.Turno_ID ,p.Sucursal_NroSucursal, p.Pedido_Estado, p.Cliente_Dni,  DATEDIFF(DAY , p.Pedido_Fecha, f.Factura_Fecha) AS 'Dias_Fabricacion', p.Pedido_Total, f.Factura_Numero
	FROM DATACORE.Detalles_Pedidos dp
	INNER JOIN DATACORE.Pedidos p ON dp.Pedido_Numero = p.Pedido_Numero
	LEFT JOIN DATACORE.Detalles_Facturas df ON dp.Pedido_Numero = df.Pedido_Numero AND dp.Sillon_Codigo = df.Sillon_Codigo
	LEFT JOIN DATACORE.Facturas f ON df.Factura_Numero = f.Factura_Numero
	INNER JOIN DATACORE.BI_Dimension_Turno t ON t.Horario = DATACORE.Turno(p.Pedido_Fecha)
	) p
	LEFT JOIN DATACORE.BI_Dimension_Dias_De_Fabricacion df ON df.Dias_De_Fabricacion = p.Dias_Fabricacion
		INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND CEILING(DATEPART(MONTH, p.Pedido_Fecha) / 4.0) = bdt.Cuatrimestre
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
GROUP BY Tiempo_ID, Rango_Etario_ID, p.Turno_ID, Estado_Pedido_ID, bdus.Ubicacion_ID, bdc.Ubicacion_ID, Sucursal_ID, Dias_Fabricacion_ID 


