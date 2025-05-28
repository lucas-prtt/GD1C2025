USE [GD1C2025]

SELECT *
FROM gd_esquema.Maestra 


--							LOCALIDADES Y PROVINCIAS


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



			-- FUNCION PARA OBTENER LOCALIDADID con nombre de localidad y provincia


CREATE FUNCTION DATACORE.GETLOCALIDADID( @PROVINCIA VARCHAR(255), @LOCALIDAD VARCHAR(255)) RETURNS BIGINT
AS 
BEGIN
	RETURN (SELECT l.Localidad_Id
			FROM (SELECT * FROM DATACORE.Provincias WHERE Provincia_nombre = @PROVINCIA) p 
			INNER JOIN (SELECT * FROM DATACORE.Localidades WHERE localidad_Nombre = @LOCALIDAD) l 
			ON l.Provincia_Id = p.Provincia_Id)
END



--                               CLIENTES


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
	-- Menos performante pero mas leible:
	/*
SELECT DISTINCT Cliente_Dni, Cliente_Nombre, Cliente_Apellido,
Cliente_FechaNacimiento, Cliente_Direccion, Cliente_Mail,
Cliente_Telefono, DATACORE.GETLOCALIDADID(Cliente_Provincia, Cliente_Localidad) AS Localidad_Id
FROM gd_esquema.Maestra
WHERE Cliente_Dni IS NOT NULL
	*/


--                               SUCURSALES


INSERT INTO DATACORE.Sucursales(Sucursal_NroSucursal,Sucursal_Telefono, Sucursal_Direccion, Sucursal_Mail, Localidad_Id)
SELECT 
    DISTINCT Sucursal_NroSucursal, Sucursal_telefono, Sucursal_Direccion, Sucursal_mail, DATACORE.GETLOCALIDADID(Sucursal_Provincia, Sucursal_Localidad) as Localidad_Id
FROM 
    gd_esquema.Maestra;


--								  PROVEEDORES


INSERT INTO DATACORE.Proveedores(Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, Localidad_Id)
SELECT DISTINCT Proveedor_Cuit, Proveedor_Direccion, Proveedor_Mail, Proveedor_RazonSocial, Proveedor_Telefono, DATACORE.GETLOCALIDADID(Proveedor_Provincia, Proveedor_Localidad) as Localidad_Id
	FROM gd_esquema.Maestra
	WHERE Proveedor_Cuit IS NOT NULL



