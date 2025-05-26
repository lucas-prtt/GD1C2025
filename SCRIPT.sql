-- Crear esquema
CREATE SCHEMA DATACORE;
-- DROP SCHEMA DATACORE;
-- Requiere eliminar las tablas antes








-- Crear tablas y estructuras

-- EJEMPLO: 
CREATE TABLE DATACORE.ModelosDeSillones
(
	Sillon_Modelo_Codigo BIGINT PRIMARY KEY,
	Sillon_Modelo_Precio DECIMAL(18, 2) NULL,
	Sillon_Modelo NVARCHAR(255) NULL,
	Sillon_Modelo_Descripcion NVARCHAR(255) NULL
)
--Eliminar: DROP TABLE DATACORE.ModelosDeSillones









-- Rellenar las tablas

-- EJEMPLO:
INSERT INTO DATACORE.ModelosDeSillones (Sillon_Modelo_Codigo, Sillon_Modelo_Precio, Sillon_Modelo, Sillon_Modelo_Descripcion)
SELECT DISTINCT Sillon_Modelo_Codigo, Sillon_Modelo_Precio, Sillon_Modelo, Sillon_Modelo_Descripcion
FROM gd_esquema.Maestra
WHERE Sillon_Modelo_Codigo IS NOT NULL





