
SELECT DISTINCT * FROM 
	(
		SELECT Pedido_Numero as aaaa, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_SubTotal
		FROM gd_esquema.Maestra
		WHERE Detalle_Factura_Cantidad IS NOT NULL AND Pedido_Numero = 56373904
	) a 
	JOIN 
	(
		SELECT DISTINCT Pedido_Numero, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_SubTotal, Sillon_Codigo
		FROM gd_esquema.Maestra
		WHERE Detalle_Pedido_Cantidad IS NOT NULL AND Sillon_Codigo IS NOT NULL AND Pedido_Numero = 56373904
	) b 
	ON a.aaaa = b.Pedido_Numero AND Detalle_Factura_SubTotal = Detalle_Pedido_SubTotal AND Detalle_Factura_Cantidad = Detalle_Pedido_Cantidad AND Detalle_Factura_Precio = Detalle_Pedido_Precio














-- Pedidos con detalles repetidos en multiples lineas
SELECT Pedido_Numero , Detalle_Factura_SubTotal, Detalle_Pedido_SubTotal , COUNT(*)
FROM gd_esquema.Maestra
WHERE Detalle_Factura_SubTotal IS NOT NULL AND Detalle_Pedido_SubTotal IS NOT NULL
GROUP BY Pedido_Numero, Detalle_Factura_SubTotal, Detalle_Pedido_SubTotal
HAVING COUNT(*) >1

SELECT * FROM gd_esquema.Maestra
WHERE Pedido_Numero = 56362433







-- Pedidos problematicos:
SELECT Pedido_Numero, COUNT(*)
FROM gd_esquema.Maestra
WHERE Detalle_Factura_Cantidad IS NOT NULL
GROUP BY Pedido_Numero
EXCEPT
SELECT aaaa, COUNT(*)
FROM (
	SELECT DISTINCT * FROM 
	(
		SELECT Pedido_Numero as aaaa, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_SubTotal
		FROM gd_esquema.Maestra
		WHERE Detalle_Factura_Cantidad IS NOT NULL
	) a 
	JOIN 
	(
		SELECT DISTINCT Pedido_Numero, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_SubTotal, Sillon_Codigo
		FROM gd_esquema.Maestra
		WHERE Detalle_Pedido_Cantidad IS NOT NULL AND Sillon_Codigo IS NOT NULL
	) b 
	ON a.aaaa = b.Pedido_Numero AND Detalle_Factura_SubTotal = Detalle_Pedido_SubTotal AND Detalle_Factura_Cantidad = Detalle_Pedido_Cantidad AND Detalle_Factura_Precio = Detalle_Pedido_Precio
) c
GROUP BY aaaa
-- El error se produce cuando un pedido tiene x sillones y la factura solo tiene x-y pero los valores 
-- de los sillones que no estan en la factura coinciden con alguno de los que si esta.
-- Se terminan registrando todos los del pedido, incluso los no facturados, ya que coinciden los campos
-- de los no facturados con un facturado de igual precio, cantidad, etc.


SELECT Pedido_Estado, Pedido_Numero, Sillon_Codigo, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_SubTotal, Factura_Numero , Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_SubTotal
FROM gd_esquema.Maestra WHERE Pedido_Numero = 56366477

SELECT Sillon_Codigo, Envio_Numero
FROM gd_esquema.Maestra
WHERE Sillon_Codigo IN (518505, 518506)