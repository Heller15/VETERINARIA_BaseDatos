--error de primary key,null,unique
insert into persona(id_persona,nombre,apellido,direccion,correo,telefono)values
(1, 'Juan', 'Maestre', 'Calle 12 # 5-20', 'juan.maestre@gmail.com', '3001234567'),
(2, 'María', 'Pérez', 'Carrera 7 # 15-30', 'maria.perez@gmail.com', '3012345678'),
(1, null, 'Gómez', 'Calle 20 # 8-45', 'carlos.gomez@hotmail.com', '3023456789'),
(4, 'Laura', 'Rodríguez', 'Carrera 9 # 10-12', 'juan.maestre@gmail.com', '3034567890'),
(5, 'Andrés', null, 'Calle 15 # 3-18', 'andres.martinez@outlook.com'),

insert into propietario(id_propietario)values
(6)


--ERROR DE Borrado 
INSERT INTO persona (id_persona, nombre, apellido, direccion, correo, telefono)
VALUES (7, 'Daniel', 'Hernández', 'Calle 8 # 12-25', 'daniel.hernandez@hotmail.com', '3067890123');

INSERT INTO personal (id_personal) VALUES (7);

INSERT INTO veterinario (id_veterinario, cargo, especialidad)
VALUES (7, 'Veterinario', 'Medicina general');

DELETE FROM personal WHERE id_personal = 7;


--error Fecha,negativos y numeric
INSERT INTO raza (id_raza, nombre) VALUES
(1, 'Labrador'),
(2, 'Labrador'),
(2, 'Siamés'),

INSERT INTO mascota (id_mascota, nombre, especie, sexo, edad, peso, estado, id_raza, id_propietario) VALUES
(1, 'Firulais', 'Perro', 'Macho', -3, 12448.504, 'Activo', 1, 1),
(2, null, 'Gato', 'Hembra', 2, 4.20, 'Activo', 3, 2),
(3, 'Rocky', null, 'Macho', 5, 28.00, 'Activo', 1, 3),
(4, 'Mia', 'Gato', null, 1, 3.10, 'Activo', 2, 4),
(5, 'Max', 'Perro', 'Macho', 4, -20.30, 'Activo', 7, 5),
(6, 'Nala', 'Perro', 'Hembra', 6, 15.80, 'Activo', 2, 8);

insert into cita(id_cita,fecha,hora,motivo,estado,id_mascota,id_veterinario) values
(1, '2026-14-20', '08:00', 'Vacunación anual', 'Realizada', 1, 7),
(2, '2026-10-45', '09:00', 'Control general', 'Realizada', 2, 7),
(3, '2026-10-21', '10:30', 'Revisión de piel', 'Realizada', 3, 6)






