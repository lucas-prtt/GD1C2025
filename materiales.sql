CREATE PROCEDURE DATACORE.ImportarMateriales
AS 
BEGIN
DECLARE micursor CURSOR FOR
	SELECT DISTINCT m.Material_Nombre, m.Material_Descripcion, Material_Precio, t.TipoMaterial_Id, t.TipoMaterial_Tipo,Tela_Color, Tela_Textura, Madera_Color, Madera_Dureza, Relleno_Densidad
	FROM gd_esquema.Maestra m INNER JOIN DATACORE.TipoMateriales t ON t.TipoMaterial_Tipo = m.Material_Tipo
	WHERE Material_Tipo IS NOT NULL
OPEN micursor
DECLARE @NOMBRE varchar(255)
DECLARE @DESCRIPCION varchar(255)
DECLARE @PRECIO decimal(18, 2)
DECLARE @TIPOID bigint
DECLARE @TIPO varchar(255)
DECLARE @TELACOLOR varchar(255)
DECLARE @TELATEXTURA varchar(255)
DECLARE @MADERACOLOR varchar(255)
DECLARE @MADERADUREZA varchar(255)
DECLARE @RELLENODENSIDAD decimal(5, 2)
DECLARE @MATERIALID bigint
FETCH micursor INTO @NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID, @TIPO, @TELACOLOR, @TELATEXTURA, @MADERACOLOR, @MADERADUREZA, @RELLENODENSIDAD
WHILE (@@FETCH_STATUS = 0)
	BEGIN
	INSERT INTO DATACORE.Materiales (Material_Nombre, Material_Descripcion, Material_Precio, TipoMaterial_Id)
	VALUES (@NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID)
	SET @MATERIALID = SCOPE_IDENTITY();
	IF @TIPO = 'Madera'
		BEGIN
		INSERT INTO DATACORE.Maderas (TipoMaterial_Id, Madera_Color, Madera_Dureza)
		VALUES (@MATERIALID, @MADERACOLOR, @MADERADUREZA)
		END
	IF @TIPO = 'Tela'
		BEGIN
		INSERT INTO DATACORE.Telas (TipoMaterial_Id, Tela_Color, Tela_Textura)
		VALUES (@MATERIALID, @TELACOLOR, @TELATEXTURA)
		END
	IF @TIPO = 'Relleno' 
		BEGIN
		INSERT INTO DATACORE.Rellenos (TipoMaterial_Id, Relleno_Densidad)
		VALUES (@MATERIALID, @RELLENODENSIDAD)
		END
	FETCH micursor INTO @NOMBRE, @DESCRIPCION, @PRECIO, @TIPOID, @TIPO, @TELACOLOR, @TELATEXTURA, @MADERACOLOR, @MADERADUREZA, @RELLENODENSIDAD
	END
	CLOSE micursor
	DEALLOCATE micursor

END
EXEC ImportarMateriales