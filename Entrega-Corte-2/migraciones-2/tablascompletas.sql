
CREATE TABLE persona (
    id_persona INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
);

CREATE TABLE propietario (
    id_propietario INTEGER PRIMARY KEY REFERENCES persona(id_persona) ON DELETE RESTRICT
);

CREATE TABLE personal (
    id_personal INTEGER PRIMARY KEY REFERENCES persona(id_persona) ON DELETE RESTRICT
);

CREATE TABLE veterinario (
    id_veterinario INTEGER PRIMARY KEY REFERENCES personal(id_personal) ON DELETE RESTRICT,
    cargo VARCHAR(40) NOT NULL DEFAULT 'Veterinario',
    especialidad VARCHAR(60) NOT NULL
);

CREATE TABLE auxiliar (
    id_auxiliar INTEGER PRIMARY KEY REFERENCES personal(id_personal) ON DELETE RESTRICT,
    num_licencia VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE raza (
    id_raza INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mascota (
    id_mascota INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    sexo VARCHAR(15) NOT NULL,
    edad INTEGER  Constraint edad_positiva CHECK (edad >= 0),
    peso NUMERIC(6,2) CHECK (peso > 0),
    estado VARCHAR(20) NOT NULL ,
    id_raza INTEGER NOT NULL REFERENCES raza(id_raza) ON DELETE RESTRICT,
    id_propietario INTEGER NOT NULL REFERENCES propietario(id_propietario) ON DELETE RESTRICT
);

CREATE TABLE cita (
    id_cita INTEGER PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo VARCHAR(150) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_mascota INTEGER NOT NULL REFERENCES mascota(id_mascota) ON DELETE RESTRICT,
    id_veterinario INTEGER NOT NULL REFERENCES veterinario(id_veterinario) ON DELETE RESTRICT,
    CONSTRAINT cita_unica UNIQUE (id_veterinario, fecha, hora)
);

CREATE TABLE historia_clinica (
    id_historia INTEGER PRIMARY KEY,
    id_mascota INTEGER NOT NULL UNIQUE REFERENCES mascota(id_mascota) ON DELETE RESTRICT,
    antecedentes TEXT NOT NULL ,
    alergias TEXT NOT NULL ,
    fecha_registro DATE NOT NULL constraint fecha_ingreso check( fecha_registro <=CURRENT_DATE) 
);

CREATE TABLE consulta_medica (
    id_consulta INTEGER PRIMARY KEY,
    id_cita INTEGER NOT NULL UNIQUE REFERENCES cita(id_cita) ON DELETE RESTRICT,
    anamnesis TEXT NOT NULL,
    observaciones TEXT,
    diagnostico TEXT NOT NULL,
    fecha_consulta DATE NOT NULL constraint fecha_ingreso check( fecha_consulta <=CURRENT_DATE)
);

CREATE TABLE vacuna (
    id_vacuna INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    dosis_recomendada VARCHAR(80) NOT NULL
);

CREATE TABLE registro_vacunacion (
    id_registro INTEGER PRIMARY KEY,
    id_mascota INTEGER NOT NULL REFERENCES mascota(id_mascota) ON DELETE RESTRICT,
    id_vacuna INTEGER NOT NULL REFERENCES vacuna(id_vacuna) ON DELETE RESTRICT,
    lote VARCHAR(40) NOT NULL,
    fecha_aplicacion DATE NOT NULL constraint fecha_aplicada check( fecha_aplicada <=CURRENT_DATE),|
    fecha_refuerzo DATE not null CONSTRAINT fecha_refuerzo_valida CHECK (fecha_refuerzo >= fecha_aplicacion),
    UNIQUE (id_mascota, id_vacuna, fecha_aplicacion)
);

CREATE TABLE servicio (
    id_servicio INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    precio_base NUMERIC(10,2) NOT NULL CONSTRAINT precio_positivo CHECK (precio_base >= 0)
);

CREATE TABLE factura (
    id_factura INTEGER PRIMARY KEY,
    id_cita INTEGER NOT NULL UNIQUE REFERENCES cita(id_cita) ON DELETE RESTRICT,
    estado VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL CONSTRAINT fecha_act check (fecha= CURRENT_DATE),
    total NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);

CREATE TABLE detalle_factura (
    id_detalle INTEGER PRIMARY KEY,
    id_factura INTEGER NOT NULL REFERENCES factura(id_factura) ON DELETE CASCADE,
    id_servicio INTEGER NOT NULL REFERENCES servicio(id_servicio) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL constraint cantidad_pos CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal NUMERIC(10,2) NOT NULL constraint calculo_subtotal CHECK (subtotal = cantidad * precio_unitario),
    UNIQUE (id_factura, id_servicio)
);

CREATE TABLE metodo_pago (
    id_metodo INTEGER PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pago (
    id_pago INTEGER PRIMARY KEY,
    id_factura INTEGER NOT NULL REFERENCES factura(id_factura) ON DELETE RESTRICT,
    id_metodo INTEGER NOT NULL REFERENCES metodo_pago(id_metodo) ON DELETE RESTRICT,
    monto NUMERIC(10,2) NOT NULL Constraint monto_positivo CHECK (monto > 0),
    fecha_pago DATE NOT NULL constraint fecha_pagar check (fecha_pago= CURRENT_DATE),
    referencia VARCHAR(60) UNIQUE
);

CREATE TABLE proveedor (
    id_proveedor INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE
);

CREATE TABLE producto (
    id_producto INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    descripcion TEXT,
    precio_venta NUMERIC(10,2) NOT NULL constraint precio_para_venta CHECK (precio_venta >= 0),
    stock INTEGER NOT NULL constraint stock_positivo check (stock >= 0)
);

CREATE TABLE compra_proveedor (
    id_compra INTEGER PRIMARY KEY,
    id_proveedor INTEGER NOT NULL REFERENCES proveedor(id_proveedor) ON DELETE RESTRICT,
    fecha_compra DATE NOT NULL constraint fecha_actual check (fecha_compra=CURRENT_DATE,) 
    estado VARCHAR(20) NOT NULL 
    total NUMERIC(10,2) NOT NULL constraint total_pos CHECK (total >= 0)
);

CREATE TABLE detalle_compra (
    id_detalle_compra INTEGER PRIMARY KEY,
    id_compra INTEGER NOT NULL REFERENCES compra_proveedor(id_compra) ON DELETE CASCADE,
    id_producto INTEGER NOT NULL REFERENCES producto(id_producto) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL constraint cantidad_positiva CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL constraint precio_uni CHECK (precio_unitario >= 0),
    subtotal NUMERIC(10,2) NOT NULL constraint calcular_subtotal CHECK (subtotal = cantidad * precio_unitario),
    UNIQUE (id_compra, id_producto)
);


