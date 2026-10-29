CREATE TABLE proveedor (
    id_proveedor INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL CONSTRAINT uq_proveedor_nombre UNIQUE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100) CONSTRAINT uq_proveedor_correo UNIQUE
);

CREATE TABLE producto (
    id_producto INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL CONSTRAINT uq_producto_nombre UNIQUE,
    descripcion VARCHAR(255),
    precio_venta NUMERIC(10,2) NOT NULL CONSTRAINT ck_producto_precio_no_negativo CHECK (precio_venta >= 0),
    stock INTEGER NOT NULL CONSTRAINT ck_producto_stock_no_negativo CHECK (stock >= 0)
);

CREATE TABLE compra_proveedor (
    id_compra INTEGER PRIMARY KEY,
    id_proveedor INTEGER NOT NULL REFERENCES proveedor(id_proveedor) ON DELETE RESTRICT, -- RESTRICT: no se borra un proveedor con compras
    fecha_compra DATE NOT NULL CONSTRAINT ck_compra_fecha_no_futura CHECK (fecha_compra <= CURRENT_DATE),
    estado VARCHAR(20) NOT NULL,
    total NUMERIC(10,2) NOT NULL CONSTRAINT ck_compra_total_no_negativo CHECK (total >= 0)
);

CREATE TABLE detalle_compra (
    id_detalle_compra INTEGER PRIMARY KEY,
    id_compra INTEGER NOT NULL REFERENCES compra_proveedor(id_compra) ON DELETE CASCADE, -- CASCADE: la línea no existe sin su compra
    id_producto INTEGER NOT NULL REFERENCES producto(id_producto) ON DELETE RESTRICT, -- RESTRICT: no se borra un producto ya comprado
    cantidad INTEGER NOT NULL CONSTRAINT ck_detalle_compra_cantidad_positiva CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CONSTRAINT ck_detalle_compra_precio_no_negativo CHECK (precio_unitario >= 0),
    subtotal NUMERIC(10,2) NOT NULL CONSTRAINT ck_detalle_compra_subtotal CHECK (subtotal = cantidad * precio_unitario),
    CONSTRAINT uq_detalle_compra_compra_producto UNIQUE (id_compra, id_producto)
);