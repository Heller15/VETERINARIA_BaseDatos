
CREATE TABLE persona (
    id_persona INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    correo VARCHAR(100) CONSTRAINT uq_persona_correo UNIQUE,
    telefono VARCHAR(20)
);

CREATE TABLE propietario (
    id_propietario INTEGER PRIMARY KEY REFERENCES persona(id_persona) ON DELETE RESTRICT -- RESTRICT: no se borra una persona que ya es propietaria
);

CREATE TABLE personal (
    id_personal INTEGER PRIMARY KEY REFERENCES persona(id_persona) ON DELETE RESTRICT -- RESTRICT: no se borra una persona que ya es empleada
);

CREATE TABLE veterinario (
    id_veterinario INTEGER PRIMARY KEY REFERENCES personal(id_personal) ON DELETE RESTRICT, -- RESTRICT: sus citas perderían quién las atendió
    cargo VARCHAR(40) NOT NULL DEFAULT 'Veterinario',
    especialidad VARCHAR(60) NOT NULL,
    num_licencia VARCHAR(30) NOT NULL CONSTRAINT uq_veterinario_num_licencia UNIQUE -- la licencia profesional es del veterinario
);

CREATE TABLE auxiliar (
    id_auxiliar INTEGER PRIMARY KEY REFERENCES personal(id_personal) ON DELETE RESTRICT -- RESTRICT: se conserva el registro del empleado
);

CREATE TABLE raza (
    id_raza INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL CONSTRAINT uq_raza_nombre UNIQUE
);

CREATE TABLE mascota (
    id_mascota INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    sexo VARCHAR(15) NOT NULL CONSTRAINT ck_mascota_sexo CHECK (sexo IN ('M','H')),
    edad INTEGER CONSTRAINT ck_mascota_edad_positiva CHECK (edad >= 0),
    peso NUMERIC(6,2) CONSTRAINT ck_mascota_peso_positivo CHECK (peso > 0),
    estado VARCHAR(20) NOT NULL CONSTRAINT ck_mascota_estado CHECK (estado IN ('Activo','Fallecido')),
    id_raza INTEGER NOT NULL REFERENCES raza(id_raza) ON DELETE RESTRICT, -- RESTRICT: no se borra una raza con mascotas, quedarían sin clasificar
    id_propietario INTEGER NOT NULL REFERENCES propietario(id_propietario) ON DELETE RESTRICT -- RESTRICT: no se borra un dueño con mascotas, quedarían sin responsable
);

CREATE TABLE cita (
    id_cita INTEGER PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo VARCHAR(150) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_mascota INTEGER NOT NULL REFERENCES mascota(id_mascota) ON DELETE RESTRICT, -- RESTRICT: la mascota con citas hace parte del historial
    id_veterinario INTEGER NOT NULL REFERENCES veterinario(id_veterinario) ON DELETE RESTRICT, -- RESTRICT: la cita conserva quién la atendió
    CONSTRAINT uq_cita_veterinario_fecha_hora UNIQUE (id_veterinario, fecha, hora) -- un veterinario no tiene dos citas a la misma fecha y hora
);
