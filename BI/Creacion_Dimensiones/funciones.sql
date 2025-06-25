
CREATE FUNCTION DATACORE.Cuatrimestre (@fecha datetime) 
RETURNS INTEGER 
AS
BEGIN
DECLARE @id int;

SET @id = CASE 
        WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
        WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3
        ELSE NULL
    END;

    RETURN @id;
END

GO

-- Recibe una edad int y devuelve el id del rango de esa edad
CREATE FUNCTION DATACORE.RangoEtario(
@FechaFactura DATETIME2, @FechaNacimientoCliente DATETIME2)
RETURNS NVARCHAR(30)
AS 
BEGIN
DECLARE @Resultado NVARCHAR(50);
DECLARE @Diferencia INTEGER
SET @Diferencia = DATEDIFF(YEAR, @FechaNacimientoCliente, @FechaFactura)
IF @Diferencia < 25
SET @Resultado = '< 25'
ELSE IF @Diferencia < 35
SET @Resultado = '25-35'
ELSE IF @Diferencia < 50
SET @Resultado = '35-50'
ELSE 
SET @Resultado = '> 50'
RETURN @Resultado
END
GO


-- Funcion que calcula en que turno ocurre una DateTime
CREATE FUNCTION DATACORE.Turno(
@FechaFactura DATETIME2)
RETURNS NVARCHAR(30)
AS 
BEGIN
DECLARE @Resultado NVARCHAR(50);
DECLARE @Hora Integer = DATEPART(HOUR, @FechaFactura)
IF @Hora >= 8 AND @Hora <14
SET @Resultado = '08:00 - 14:00'
ELSE IF @Hora >= 14 AND @HORA <= 20
SET @Resultado = '14:00 - 20:00'
ELSE 
SET @Resultado = 'Fuera de horario'
RETURN @Resultado
END
GO

