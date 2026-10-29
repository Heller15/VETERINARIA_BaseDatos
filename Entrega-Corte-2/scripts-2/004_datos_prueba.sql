
INSERT INTO persona (id_persona, nombre, apellido, direccion, correo, telefono) VALUES
(1,  'Camila',    'Rojas Pardo',   'Calle 12 # 8-30, Valledupar',    'camila.rojas@example.com',      '3001110001'),
(2,  'Andrés',    'Mejía Soto',    'Carrera 9 # 15-22, Valledupar',  'andres.mejia@example.com',      '3001110002'),
(3,  'Valentina', 'Ortiz Herrera', 'Calle 20 # 5-41, Valledupar',    'valentina.ortiz@example.com',   '3001110003'),
(4,  'Sebastián', 'Peña Londoño',  'Avenida 6 # 30-10, Valledupar',  'sebastian.pena@example.com',    '3001110004'),
(5,  'Daniela',   'Cárdenas Vega', NULL,                             NULL,                            '3001110005'),
(6,  'Laura',     'Gómez Arias',   'Carrera 15 # 10-05, Valledupar', 'laura.gomez@example.com',       '3002220006'),
(7,  'Felipe',    'Acosta Rivera', 'Calle 8 # 12-18, Valledupar',    'felipe.acosta@example.com',     '3002220007'),
(8,  'Mariana',   'Salazar Ruiz',  'Calle 30 # 7-60, Valledupar',    'mariana.salazar@example.com',   '3002220008'),
(9,  'Julián',    'Torres Mora',   'Carrera 4 # 22-14, Valledupar',  'julian.torres@example.com',     '3002220009'),
(10, 'Natalia',   'Ibáñez Cruz',   'Calle 17 # 9-33, Valledupar',    'natalia.ibanez@example.com',    '3002220010'),
(11, 'Esteban',   'Molina Díaz',   'Carrera 11 # 18-27, Valledupar', 'esteban.molina@example.com',    '3003330011'),
(12, 'Paula',     'Navarro Gil',   'Calle 25 # 6-12, Valledupar',    'paula.navarro@example.com',     '3003330012'),
(13, 'Mateo',     'Quintero Páez', 'Avenida 3 # 14-50, Valledupar',  'mateo.quintero@example.com',    '3003330013'),
(14, 'Isabela',   'Franco Leal',   'Calle 14 # 11-09, Valledupar',   'isabela.franco@example.com',    '3003330014'),
(15, 'Samuel',    'Bravo Ochoa',   NULL,                             'samuel.bravo@example.com',      '3003330015');

-- ===== propietario (5 filas: personas 1 a 5) =====
INSERT INTO propietario (id_propietario) VALUES (1), (2), (3), (4), (5);

-- ===== personal (10 filas: personas 6 a 15) =====
INSERT INTO personal (id_personal) VALUES (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

-- ===== veterinario (5 filas: personas 6 a 10) =====
INSERT INTO veterinario (id_veterinario, cargo, especialidad, num_licencia) VALUES
(6,  'Veterinario',             'Medicina general',       'LIC-0001'),
(7,  'Veterinario',             'Cirugía',                'LIC-0002'),
(8,  'Veterinaria especialista','Dermatología',           'LIC-0003'),
(9,  'Veterinario',             'Medicina felina',        'LIC-0004'),
(10, 'Veterinaria jefe',        'Medicina interna',       'LIC-0005');

-- ===== auxiliar (5 filas: personas 11 a 15) =====
INSERT INTO auxiliar (id_auxiliar) VALUES (11), (12), (13), (14), (15);

-- ===== raza (6 filas; la 6 queda sin mascotas a propósito) =====
INSERT INTO raza (id_raza, nombre) VALUES
(1, 'Criollo'),
(2, 'Labrador'),
(3, 'Pastor Alemán'),
(4, 'Siamés'),
(5, 'Persa'),
(6, 'Bulldog Francés');

-- ===== mascota (8 filas) =====
-- Caso "relacionado con varios": propietario 1 tiene 3 mascotas (1, 2 y 3)
-- Caso "relacionado con ninguno": propietario 5 y raza 6 no tienen mascotas
INSERT INTO mascota (id_mascota, nombre, especie, sexo, edad, peso, estado, id_raza, id_propietario) VALUES
(1, 'Max',    'Perro', 'M', 4,  28.50, 'Activo',    2, 1),
(2, 'Luna',   'Gato',  'H', 2,   4.20, 'Activo',    4, 1),
(3, 'Toby',   'Perro', 'M', 6,  22.00, 'Activo',    1, 1),
(4, 'Mía',    'Gato',  'H', 3,   3.80, 'Activo',    5, 2),
(5, 'Rocky',  'Perro', 'M', 8,  31.40, 'Activo',    3, 3),
(6, 'Nala',   'Perro', 'H', 1,   9.50, 'Activo',    1, 4),
(7, 'Simba',  'Gato',  'M', 10,  5.10, 'Fallecido', 4, 3),
(8, 'Bella',  'Perro', 'H', 5,  24.00, 'Activo',    2, 2);

-- ===== cita (8 filas; veterinarios 6 a 10) =====
-- La 7 (Cancelada) y la 8 (Pendiente) no generan consulta
INSERT INTO cita (id_cita, fecha, hora, motivo, estado, id_mascota, id_veterinario) VALUES
(1, '2026-09-15', '09:00', 'Control general',     'Atendida',  1, 6),
(2, '2026-09-15', '10:00', 'Vacunación anual',    'Atendida',  2, 9),
(3, '2026-09-22', '08:30', 'Revisión de la piel', 'Atendida',  3, 8),
(4, '2026-10-01', '14:00', 'Cojera pata trasera', 'Atendida',  5, 7),
(5, '2026-10-06', '11:00', 'Control de peso',     'Atendida',  4, 10),
(6, '2026-10-13', '15:30', 'Desparasitación',     'Atendida',  6, 6),
(7, '2026-10-20', '09:00', 'Chequeo general',     'Cancelada', 8, 6),
(8, '2026-11-05', '10:00', 'Control general',     'Pendiente', 1, 6);

-- ===== historia_clinica (6 filas; las mascotas 7 y 8 aún no tienen historia) =====
INSERT INTO historia_clinica (id_historia, id_mascota, antecedentes, alergias, fecha_registro) VALUES
(1, 1, 'Vacunas al día, sin cirugías previas',          'Ninguna conocida',           '2026-09-15'),
(2, 2, 'Esterilizada a los 8 meses',                    'Alergia a la proteína de pollo', '2026-09-15'),
(3, 3, 'Otitis recurrente en el último año',            'Ninguna conocida',           '2026-09-22'),
(4, 4, 'Cuadro de gripe felina a los 6 meses',          'Ninguna conocida',           '2026-10-06'),
(5, 5, 'Displasia de cadera diagnosticada a los 5 años','Alergia a la penicilina',    '2026-10-01'),
(6, 6, 'Cachorra sin antecedentes',                     'Ninguna conocida',           '2026-10-13');

-- ===== consulta_medica (6 filas; una por cada cita atendida) =====
-- La consulta 3 no trae diagnóstico: se usa el valor por defecto 'Sin hallazgos'
INSERT INTO consulta_medica (id_consulta, id_cita, temperatura, anamnesis, observaciones, diagnostico, fecha_consulta) VALUES
(1, 1, 38.5, 'Dueña reporta buen apetito y energía',        NULL,                           'Paciente sano',               '2026-09-15'),
(2, 2, 38.8, 'Visita para vacunación anual',                'Se aplicó vacuna triple felina','Apta para vacunación',        '2026-09-15'),
(3, 3, 38.6, 'Rascado frecuente en las orejas',             'Se limpia el oído externo',     DEFAULT,                       '2026-09-22'),
(4, 4, 39.1, 'Cojea desde hace tres días',                  'Dolor al mover la cadera',     'Agravamiento de displasia',   '2026-10-01'),
(5, 5, NULL, 'Control de peso programado',                  NULL,                           'Sobrepeso leve',              '2026-10-06'),
(6, 6, 38.9, 'Desparasitación de rutina',                   'Se entrega dosis de refuerzo', 'Desparasitada correctamente', '2026-10-13');

-- ===== proveedor (5 filas; el 5 no tiene compras) =====
INSERT INTO proveedor (id_proveedor, nombre, direccion, telefono, correo) VALUES
(1, 'VetDistribuciones S.A.S.',   'Zona Industrial, Valledupar', '6055550101', 'ventas@vetdistribuciones.example.com'),
(2, 'Farmapet del Cesar',         'Carrera 7 # 14-20, Valledupar','6055550102', 'pedidos@farmapet.example.com'),
(3, 'Alimentos Animal del Caribe','Calle 15 # 3-45, Valledupar',  '6055550103', 'contacto@animalcaribe.example.com'),
(4, 'PetSupply Colombia',         NULL,                           '6055550104', 'info@petsupply.example.com'),
(5, 'Insumos Clínicos del Norte', 'Avenida 5 # 20-11, Valledupar', '6055550105', NULL);

-- ===== producto (6 filas; el 6 está agotado: stock 0) =====
INSERT INTO producto (id_producto, nombre, descripcion, precio_venta, stock) VALUES
(1, 'Gotas óticas',        'Limpieza y tratamiento de oídos',  18000.00, 25),
(2, 'Alimento dietético',  'Bolsa de 2 kg para control de peso',45000.00, 12),
(3, 'Antipulgas',          'Pipeta mensual',                    32000.00, 30),
(4, 'Shampoo medicado',    NULL,                                28000.00, 15),
(5, 'Collar isabelino',    'Talla mediana',                     15000.00,  8),
(6, 'Vitaminas',           'Suplemento en tabletas',            22000.00,  0);

-- ===== compra_proveedor (5 filas; el proveedor 1 tiene 2 compras) =====
INSERT INTO compra_proveedor (id_compra, id_proveedor, fecha_compra, estado, total) VALUES
(1, 1, '2026-08-10', 'Recibida',  680000.00),
(2, 1, '2026-08-25', 'Recibida',   90000.00),
(3, 2, '2026-09-05', 'Recibida',  510000.00),
(4, 3, '2026-09-20', 'Recibida',  190000.00),
(5, 4, '2026-10-22', 'Pendiente', 330000.00);

-- ===== detalle_compra (7 filas; cada total coincide con la suma de sus líneas) =====
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 20, 12000.00, 240000.00),
(2, 1, 3, 20, 22000.00, 440000.00),
(3, 2, 5, 10,  9000.00,  90000.00),
(4, 3, 2, 10, 30000.00, 300000.00),
(5, 3, 6, 15, 14000.00, 210000.00),
(6, 4, 4, 10, 19000.00, 190000.00),
(7, 5, 3, 15, 22000.00, 330000.00);

-- ===== vacuna (5 filas; la 5 aún no se ha aplicado a ninguna mascota) =====
INSERT INTO vacuna (id_vacuna, nombre, tipo, dosis_recomendada) VALUES
(1, 'Triple felina',   'Felina', 'Una dosis anual'),
(2, 'Antirrábica',     'Canina y felina', 'Una dosis anual'),
(3, 'Parvovirus',      'Canina', 'Refuerzo cada mes en cachorros'),
(4, 'Moquillo',        'Canina', 'Refuerzo cada mes en cachorros'),
(5, 'Leucemia felina', 'Felina', 'Dos dosis separadas por 4 semanas');

-- ===== registro_vacunacion (6 filas; la mascota 6 recibe dos vacunas el mismo día) =====
INSERT INTO registro_vacunacion (id_registro, id_mascota, id_vacuna, lote, fecha_aplicacion, fecha_refuerzo) VALUES
(1, 1, 2, 'LT-A101', '2026-09-15', '2027-09-15'),
(2, 2, 1, 'LT-F202', '2026-09-15', '2027-09-15'),
(3, 3, 3, 'LT-P303', '2026-09-22', NULL),
(4, 5, 2, 'LT-A104', '2026-10-01', '2027-10-01'),
(5, 6, 3, 'LT-P305', '2026-10-13', '2026-11-13'),
(6, 6, 4, 'LT-M306', '2026-10-13', '2026-11-13');

-- ===== servicio (6 filas) =====
INSERT INTO servicio (id_servicio, nombre, tipo, precio_base) VALUES
(1, 'Consulta general',    'Consulta',      50000.00),
(2, 'Vacunación',          'Prevención',    35000.00),
(3, 'Desparasitación',     'Prevención',    25000.00),
(4, 'Limpieza de oídos',   'Procedimiento', 30000.00),
(5, 'Cirugía menor',       'Cirugía',      180000.00),
(6, 'Radiografía',         'Diagnóstico',   90000.00);

-- ===== factura (5 filas: consultas 1 a 5; la consulta 6 aún no se factura) =====
INSERT INTO factura (id_factura, id_consulta, estado, fecha, total) VALUES
(1, 1, 'Pagada',    '2026-09-15',  50000.00),
(2, 2, 'Pagada',    '2026-09-15',  85000.00),
(3, 3, 'Pagada',    '2026-09-22',  98000.00),
(4, 4, 'Pendiente', '2026-10-01', 140000.00),
(5, 5, 'Pagada',    '2026-10-06',  95000.00);

-- ===== detalle_factura (10 filas; cada línea es un servicio o un producto, nunca ambos) =====
INSERT INTO detalle_factura (id_factura, numero_item, id_servicio, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, NULL, 1, 50000.00,  50000.00),
(2, 1, 1, NULL, 1, 50000.00,  50000.00),
(2, 2, 2, NULL, 1, 35000.00,  35000.00),
(3, 1, 1, NULL, 1, 50000.00,  50000.00),
(3, 2, 4, NULL, 1, 30000.00,  30000.00),
(3, 3, NULL, 1, 1, 18000.00,  18000.00),
(4, 1, 1, NULL, 1, 50000.00,  50000.00),
(4, 2, 6, NULL, 1, 90000.00,  90000.00),
(5, 1, 1, NULL, 1, 50000.00,  50000.00),
(5, 2, NULL, 2, 1, 45000.00,  45000.00);

-- ===== metodo_pago (5 filas; 'Nequi' todavía no se ha usado) =====
INSERT INTO metodo_pago (id_metodo, nombre) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta débito'),
(3, 'Tarjeta crédito'),
(4, 'Transferencia'),
(5, 'Nequi');

-- ===== pago (5 filas; la factura 2 se paga en dos partes: caso "varios") =====
INSERT INTO pago (id_pago, id_factura, id_metodo, monto, fecha_pago, referencia) VALUES
(1, 1, 1, 50000.00, '2026-09-15', NULL),
(2, 2, 2, 50000.00, '2026-09-15', 'TD-0001'),
(3, 2, 1, 35000.00, '2026-09-15', NULL),
(4, 3, 4, 98000.00, '2026-09-22', 'TRF-0001'),
(5, 5, 3, 95000.00, '2026-10-06', 'TC-0002');