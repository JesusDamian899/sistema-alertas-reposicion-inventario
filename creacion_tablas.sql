CREATE TABLE maestro_productos(
	sku INT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	categoria VARCHAR(50) NOT NULL,
	precio DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE inventario_almacen(
	sku INT PRIMARY KEY,
	cantidad_disponible INT NOT NULL CHECK(cantidad_disponible>=0),
	fecha_actualizacion DATETIME NOT NULL DEFAULT GETDATE(), 

	CONSTRAINT FK_inventario_sku
		FOREIGN KEY(sku) REFERENCES maestro_productos(sku)
);
GO

CREATE TABLE dim_calendario(
	fecha DATE PRIMARY KEY,
	año INT NOT NULL,
	mes VARCHAR(15) NOT NULL,
	dia_semana VARCHAR(15) NOT NULL

);
GO

CREATE TABLE ventas_diarias(
	id_venta INT PRIMARY KEY,
	sku INT NOT NULL,
	fecha DATE NOT NULL,
	cantidad_venta INT NOT NULL CHECK(cantidad_venta>0),

	CONSTRAINT FK_ventas_sku
		FOREIGN KEY(sku) REFERENCES maestro_productos(sku),

	CONSTRAINT FK_ventas_fecha
		FOREIGN KEY(fecha) REFERENCES dim_calendario(fecha)
);
GO
