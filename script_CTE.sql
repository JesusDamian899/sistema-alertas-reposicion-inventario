

SELECT * FROM inventario_almacen
SELECT * FROM ventas_diarias
GO

--CTE PromedioVenta
WITH PromedioVenta AS (
    SELECT
        sku,
        AVG(CAST(cantidad_venta AS DECIMAL(10,2))) AS promedio_de_venta
    FROM ventas_diarias
    GROUP BY sku
)
SELECT
    inv.sku,
    inv.cantidad_disponible AS cantidad,
    COALESCE(vta.promedio_de_venta,0) AS promedio_de_venta
FROM inventario_almacen AS inv
LEFT JOIN PromedioVenta AS vta
    ON vta.sku = inv.sku;
	