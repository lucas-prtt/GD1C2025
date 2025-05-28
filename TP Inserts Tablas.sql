SELECT *
FROM gd_esquema.Maestra 

--							Localidades y provincias

-- Tabla temporal
SELECT DISTINCT Cliente_Localidad as Localidad, Cliente_Provincia as Provincia 
INTO #localidadesYProvincias           
FROM gd_esquema.Maestra 
UNION
SELECT DISTINCT Sucursal_Localidad, Sucursal_provincia
FROM gd_esquema.Maestra 
UNION
SELECT DISTINCT Proveedor_Localidad, Proveedor_Provincia
FROM gd_esquema.Maestra 
EXCEPT 
SELECT NULL, NULL
ORDER BY Localidad
-- Insertar en Provincias
INSERT INTO DATACORE.Provincias (Provincia_Nombre)
SELECT DISTINCT Provincia from #localidadesYProvincias
-- Insertar en Localidades
INSERT INTO DATACORE.Localidades (Localidad_Nombre, Provincia_Id)
SELECT Localidad, Provincia_Id
FROM #localidadesYProvincias INNER JOIN DATACORE.Provincias ON Provincia_Nombre = #localidadesYProvincias.Provincia
-- Borro tabla temporal
DROP TABLE #localidadesYProvincias


--                               Clientes
INSERT INTO DATACORE.Clientes
SELECT DISTINCT Cliente_Dni, Cliente_Nombre, Cliente_Apellido,
Cliente_FechaNacimiento, Cliente_Direccion, Cliente_Mail,
Cliente_Telefono, l.Localidad_Id
FROM 
	(SELECT DISTINCT 
		Cliente_Dni, Cliente_Nombre, Cliente_Apellido,
		Cliente_FechaNacimiento, Cliente_Direccion, Cliente_Mail,
		Cliente_Telefono, p.Provincia_Id, Cliente_Localidad
		FROM gd_esquema.Maestra a 
		INNER JOIN DATACORE.Provincias p ON a.Cliente_Provincia = p.Provincia_Nombre)
		AS cp
	INNER JOIN DATACORE.Localidades l ON (cp.Cliente_Localidad = l.Localidad_Nombre AND cp.Provincia_Id = l.Provincia_Id)






