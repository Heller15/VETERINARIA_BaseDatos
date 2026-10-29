CREATE TABLE historia_clinica (
    id_historia INTEGER PRIMARY KEY,
    id_mascota INTEGER NOT NULL CONSTRAINT uq_historia_clinica_mascota UNIQUE REFERENCES mascota(id_mascota) ON DELETE RESTRICT, -- RESTRICT: no se borra una mascota con historia clínica
    antecedentes VARCHAR(500) NOT NULL,
    alergias VARCHAR(300) NOT NULL,
    fecha_registro DATE NOT NULL CONSTRAINT ck_historia_fecha_no_futura CHECK (fecha_registro <= CURRENT_DATE)
);

CREATE TABLE consulta_medica (
    id_consulta INTEGER PRIMARY KEY,
    id_cita INTEGER NOT NULL CONSTRAINT uq_consulta_medica_cita UNIQUE REFERENCES cita(id_cita) ON DELETE RESTRICT, -- RESTRICT: la consulta es parte del historial clínico
    temperatura NUMERIC(4,1) CONSTRAINT ck_consulta_temperatura_rango CHECK (temperatura BETWEEN 30 AND 45),
    anamnesis VARCHAR(500) NOT NULL,
    observaciones VARCHAR(500),
    diagnostico VARCHAR(300) NOT NULL DEFAULT 'Sin hallazgos' CONSTRAINT ck_consulta_diagnostico_no_vacio CHECK (char_length(btrim(diagnostico)) > 0), -- si no hay hallazgos se registra 'Sin hallazgos'
    fecha_consulta DATE NOT NULL CONSTRAINT ck_consulta_fecha_no_futura CHECK (fecha_consulta <= CURRENT_DATE) -- se mantiene; hay que añadirla al diagrama
);

CREATE TABLE vacuna (
    id_vacuna INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL CONSTRAINT uq_vacuna_nombre UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    dosis_recomendada VARCHAR(80) NOT NULL
);

CREATE TABLE registro_vacunacion (
    id_registro INTEGER PRIMARY KEY,
    id_mascota INTEGER NOT NULL REFERENCES mascota(id_mascota) ON DELETE RESTRICT, -- RESTRICT: el carné de vacunación no se pierde
    id_vacuna INTEGER NOT NULL REFERENCES vacuna(id_vacuna) ON DELETE RESTRICT, -- RESTRICT: no se borra una vacuna ya aplicada
    lote VARCHAR(40) NOT NULL,
    fecha_aplicacion DATE NOT NULL CONSTRAINT ck_registro_aplicacion_no_futura CHECK (fecha_aplicacion <= CURRENT_DATE),
    fecha_refuerzo DATE CONSTRAINT ck_registro_refuerzo_valido CHECK (fecha_refuerzo >= fecha_aplicacion),
    CONSTRAINT uq_registro_mascota_vacuna_fecha UNIQUE (id_mascota, id_vacuna, fecha_aplicacion)
);

CREATE TABLE servicio (
    id_servicio INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL CONSTRAINT uq_servicio_nombre UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    precio_base NUMERIC(10,2) NOT NULL CONSTRAINT ck_servicio_precio_no_negativo CHECK (precio_base >= 0)
);

CREATE TABLE factura (
    id_factura INTEGER PRIMARY KEY,
    id_consulta INTEGER NOT NULL CONSTRAINT uq_factura_consulta UNIQUE REFERENCES consulta_medica(id_consulta) ON DELETE RESTRICT, -- RESTRICT: una consulta facturada no se borra
    estado VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL CONSTRAINT ck_factura_fecha_no_futura CHECK (fecha <= CURRENT_DATE),
    total NUMERIC(10,2) NOT NULL DEFAULT 0 CONSTRAINT ck_factura_total_no_negativo CHECK (total >= 0)
);

CREATE TABLE detalle_factura (
    id_factura INTEGER NOT NULL REFERENCES factura(id_factura) ON DELETE CASCADE, -- CASCADE: la línea no existe sin su factura (entidad débil)
    numero_item INTEGER NOT NULL CONSTRAINT ck_detalle_factura_item_positivo CHECK (numero_item > 0),
    id_servicio INTEGER REFERENCES servicio(id_servicio) ON DELETE RESTRICT, -- RESTRICT: se conserva el histórico de lo cobrado
    id_producto INTEGER REFERENCES producto(id_producto) ON DELETE RESTRICT, -- RESTRICT: no se borra un producto ya facturado
    cantidad INTEGER NOT NULL CONSTRAINT ck_detalle_factura_cantidad_positiva CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CONSTRAINT ck_detalle_factura_precio_no_negativo CHECK (precio_unitario >= 0),
    subtotal NUMERIC(10,2) NOT NULL CONSTRAINT ck_detalle_factura_subtotal CHECK (subtotal = cantidad * precio_unitario),
    PRIMARY KEY (id_factura, numero_item),
    CONSTRAINT ck_detalle_factura_servicio_o_producto CHECK ((id_servicio IS NOT NULL AND id_producto IS NULL) OR (id_servicio IS NULL AND id_producto IS NOT NULL)) -- cada línea cobra un servicio o un producto, nunca ambos ni ninguno
);

CREATE TABLE metodo_pago (
    id_metodo INTEGER PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL CONSTRAINT uq_metodo_pago_nombre UNIQUE
);

CREATE TABLE pago (
    id_pago INTEGER PRIMARY KEY,
    id_factura INTEGER NOT NULL REFERENCES factura(id_factura) ON DELETE RESTRICT, -- RESTRICT: no se borra una factura con pagos
    id_metodo INTEGER NOT NULL REFERENCES metodo_pago(id_metodo) ON DELETE RESTRICT, -- RESTRICT: no se borra un método ya usado
    monto NUMERIC(10,2) NOT NULL CONSTRAINT ck_pago_monto_positivo CHECK (monto > 0),
    fecha_pago DATE NOT NULL CONSTRAINT ck_pago_fecha_no_futura CHECK (fecha_pago <= CURRENT_DATE),
    referencia VARCHAR(60) CONSTRAINT uq_pago_referencia UNIQUE
);