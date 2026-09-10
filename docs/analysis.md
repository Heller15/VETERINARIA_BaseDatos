# Requisitos, Preguntas y Supuestos

**Proyecto:** GameZone / Sistema de Información para Clínica Veterinaria

## 1. Requisitos de información

### Gestión de propietarios y mascotas

- Registrar propietarios con sus datos de contacto: nombre, apellido, dirección, correo y teléfono (entidad `Propietario`, especialización de `Persona`).
- Registrar mascotas asociadas a un único propietario y a una raza del catálogo: nombre, especie, sexo, edad, peso y estado (entidad `Mascota`, relaciones `Posee` y `Tiene`).
- Mantener un catálogo de razas (`Id_raza`, `Nombre`) independiente, reutilizable entre varias mascotas.
- Consultar todas las mascotas de un mismo propietario.

### Gestión de personal (veterinarios y auxiliares)

- Registrar el personal de la clínica con sus datos base heredados de `Persona`: nombre, apellido, dirección, correo y teléfono (entidad `Personal`).
- Diferenciar dos tipos de personal, de forma excluyente: `Veterinario` (con `Cargo` y `Especialidad`) y `Auxiliar` (con `Num_licencia`).
- Consultar el personal registrado según su tipo (veterinario o auxiliar).

### Agenda de citas

- Agendar citas indicando mascota, veterinario, fecha, hora y motivo (entidad `Cita`, relaciones `Tiene` y `Atiende`).
- Registrar el estado de la cita (por ejemplo: programada, atendida, cancelada).
- Consultar el listado de citas programadas por veterinario o por mascota.

### Catálogo de servicios

- Registrar servicios ofrecidos por la clínica, con nombre, tipo y precio base (entidad `Servicio`).
- Permitir que un mismo servicio se utilice en múltiples facturas a lo largo del tiempo.

### Facturación

- Generar, para cada cita, a lo sumo una factura consolidada con estado, fecha y total (entidad `Factura`, relación `Genera`).
- Registrar en el detalle de la factura cada servicio aplicado, con su cantidad, precio unitario y subtotal (entidad `detalle_Factura`, relaciones `Contiene` y `Aplica`).
- Consultar facturas por propietario, por mascota o por fecha.

---

## 2. Preguntas y supuestos

| Pregunta / ambigüedad | Supuesto adoptado |
|---|---|
| ¿Una mascota puede tener más de un propietario (ej. una pareja)? | Se asume un único propietario por mascota, reflejado en la cardinalidad (1,1) de la relación `Posee` del lado de `Mascota`. |
| ¿Cuánto dura una cita y cómo se valida el cruce de horarios? | Se asume que la entidad `Cita` solo almacena `Fecha` y `Hora` puntuales, sin una duración ni una regla de bloqueo de horario; la validación de cruces de horario queda fuera del alcance de esta entrega. |
| ¿Una mascota puede tener varias vacunas con esquemas independientes? | Se asume que el sistema no contempla una entidad de vacunación; el seguimiento de refuerzos y fechas de aplicación queda fuera del alcance del sistema modelado. |
| ¿El inventario se descuenta automáticamente al registrar una consulta con medicamento aplicado? | Se asume que no existe una entidad de inventario de medicamentos o insumos en el modelo; los medicamentos no se gestionan como recurso independiente. |
| ¿El hospedaje se cobra por día o tarifa plana? | Se asume que el hospedaje no se modela con fechas de ingreso/salida, sino que se factura como cualquier otro registro del catálogo `Servicio`, con un `Precio_base` fijo por unidad contratada. |
| ¿Qué se considera una vacuna vencida? | Se asume que esta pregunta no aplica, dado que el modelo no incluye un módulo de vacunación. |
| ¿Los auxiliares administrativos pueden ver el historial clínico completo o solo datos de agenda/cobro? | Se asume que el modelo no incluye una entidad de historia clínica (diagnóstico, tratamiento); tanto `Veterinario` como `Auxiliar` heredan únicamente los datos de `Persona` y se diferencian por `Cargo`/`Especialidad` y `Num_licencia` respectivamente. La restricción de roles sobre citas y facturas se aborda en la Entrega 3. |
| ¿Se manejan otras especies aparte de perro/gato (aves, roedores)? | Se asume que el atributo `Especie` de `Mascota` es de texto libre, sin catálogo cerrado, lo que permite registrar cualquier especie. |
| ¿La factura es por visita completa o por cada ítem por separado? | Se asume que `Factura` tiene una relación (1,1) con `Cita` (relación `Genera`), por lo que cada cita genera como máximo una factura consolidada; los ítems individuales (servicios aplicados) se registran en `detalle_Factura`. |
| ¿El personal veterinario y auxiliar comparte los mismos datos base de contacto? | Se asume que `Veterinario` y `Auxiliar` son especializaciones disjuntas de `Personal`, y ambos heredan de `Persona` los atributos `Nombre`, `Apellido`, `Dirección`, `Correo` y `Teléfono`; un mismo empleado no puede ser auxiliar y veterinario a la vez. |
| ¿La raza de una mascota se registra como texto libre o como catálogo? | Se asume un catálogo independiente `Raza` (`Id_raza`, `Nombre`), relacionado con `Mascota` mediante la relación `Tiene`, para evitar duplicidad y estandarizar los valores. |
| ¿El precio cobrado en una factura puede diferir del precio base del servicio? | Se asume que sí: `Servicio` define un `Precio_base` de catálogo, pero `detalle_Factura` almacena su propio `Precio_unitario` y `Subtotal`, permitiendo ajustes puntuales por cantidad o descuentos en cada factura. |

---
