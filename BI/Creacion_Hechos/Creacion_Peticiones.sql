INSERT INTO DATACORE.BI_Hecho_Peticion(Tiempo_ID,
    Rango_Etario_Cliente_ID, 
    Sucursal_ID,
    Turno_ID,
    Estado_Pedido_ID,
    Ubicacion_Cliente_ID,
    Ubicacion_Sucursal_ID,
    Pedido_ID,
    Costo_Peticion)
SELECT bdt.Tiempo_ID,--k
    bdr.Rango_Etario_ID, --k
    bds.Sucursal_ID,--k
    bdtu.Turno_ID,
    bdep.Estado_Pedido_ID,--k
    bduc.Ubicacion_ID, --k
    bdus.Ubicacion_ID, --k
    bdp.Pedido_ID, --k
    p.Pedido_Total --k
FROM DATACORE.Pedidos p 
	 INNER JOIN DATACORE.BI_Dimension_Tiempo bdt ON YEAR(p.Pedido_Fecha)=bdt.Anio AND MONTH(p.Pedido_Fecha)=bdt.Mes AND CEILING(DATEPART(MONTH, p.Pedido_Fecha) / 4.0) = bdt.Cuatrimestre
	 INNER JOIN DATACORE.BI_Dimension_Sucursales bds ON p.Sucursal_NroSucursal = bds.Sucursal_NroSucursal
	 INNER JOIN DATACORE.BI_Dimension_Estado_Pedido bdep  ON p.Pedido_Estado = bdep.Estado_Pedido_Desc
	 INNER JOIN DATACORE.Clientes c ON p.Cliente_Dni = c.Cliente_Dni
	 INNER JOIN DATACORE.Localidades lc ON c.Localidad_Id = lc.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bduc ON c.Localidad_Id = bduc.Localidad_ID AND lc.Provincia_Id=bduc.Provincia_ID
	 INNER JOIN DATACORE.BI_Dimension_Pedido bdp ON p.Pedido_Numero=bdp.Pedido_Numero
	 INNER JOIN DATACORE.Sucursales s ON p.Sucursal_NroSucursal=s.Sucursal_NroSucursal
	 INNER JOIN DATACORE.Localidades ls ON s.Localidad_Id=ls.Localidad_Id
	 INNER JOIN DATACORE.BI_Dimension_Ubicacion bdus ON s.Localidad_Id=bdus.Localidad_ID AND ls.Provincia_Id=bdus.Provincia_ID
	 INNER JOIN DATACORE.BI_Dimension_RangoEtario bdr ON bdr.Rango_Etario_Descripcion = DATACORE.RangoEtario(p.Pedido_Fecha, c.Cliente_FechaNacimiento)
	 INNER JOIN DATACORE.BI_Dimension_Turno bdtu ON bdtu.Horario = DATACORE.Turno(p.Pedido_Fecha)

	 






-----------------------------------------------------------



