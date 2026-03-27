DROP DATABASE IF EXISTS madrivet;

CREATE DATABASE madrivet
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE madrivet;

CREATE TABLE duenos(
    id_dueno       INT           PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(255)  NOT NULL,
    apellidos      VARCHAR(255)  NOT NULL,
    telefono       VARCHAR(255)  NOT NULL,
    direccion      VARCHAR(255),
    email          VARCHAR(255)
);

CREATE TABLE veterinarios(
    id_veterinario INT           PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(255)  NOT NULL,
    apellidos      VARCHAR(255)  NOT NULL,
    telefono       VARCHAR(255)  NOT NULL,
    especialidad   VARCHAR(255),
    email          VARCHAR(255)
);

CREATE TABLE mascotas(
    id_mascota     INT           PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(255)  NOT NULL,
    tipo           VARCHAR(255)  NOT NULL,
    raza           VARCHAR(255)  NOT NULL,
    edad           INT           UNSIGNED NOT NULL,
    peso           DECIMAL(5, 2) UNSIGNED NOT NULL,
    id_dueno       INT           NOT NULL,
    FOREIGN KEY (id_dueno) REFERENCES duenos(id_dueno)
);

CREATE TABLE citas(
    id_cita        INT           PRIMARY KEY AUTO_INCREMENT,
    fecha          DATE          NOT NULL,
    hora           TIME          NOT NULL,
    motivo         VARCHAR(255),
    id_mascota     INT           NOT NULL,
    id_veterinario INT           NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);

CREATE TABLE tratamientos(
    id_tratamiento INT           PRIMARY KEY AUTO_INCREMENT,
    descripcion    VARCHAR(255)  NOT NULL,
    costo          DECIMAL(8, 2) NOT NULL,
    fecha          DATE          NOT NULL,
    id_mascota     INT           NOT NULL,
    id_veterinario INT           NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);

INSERT INTO duenos
    (nombre, apellidos, telefono, direccion, email)
VALUES
    ("María",  "García López",      "612345678", "maria@email",  "Calle Mayor 1"),
    ("Juan",   "Pérez Martín",      "612345679", "juan@email",   "Av. Sol 23"),
    ("Ana",    "Rodríguez Sánchez", "612345670", "ana@email",    "Plaza Central 5"),
    ("Carlos", "López García",      "612345671", "carlos@email", "Calle Luna 12"),
    ("Laura",  "Martínez Ruiz",     "612345672", "laura@email",  "Avenida Mar 8");

INSERT INTO veterinarios
    (nombre, apellidos, especialidad, telefono, email)
VALUES
    ("Dr. Pedro",   "Sánchez Vega",   "Cirugía",          "667890123", "pedro@vet"),
    ("Dra. Carmen", "Gómez Ruiz",     "Dermatología",     "612345674", "carmen@vet"),
    ("Dr. Luis",    "Fernández Días", "Medicina General", "612345675", "luis@vet");

INSERT INTO mascotas
    (nombre, tipo, raza, edad, peso, id_dueno)
VALUES
    ("Luna",   "Perro", "Labrador",      3, 25.50, 1),
    ("Michi",  "Gato",  "Siamés",        2,  4.20, 1),
    ("Rex",    "Perro", "Pastor Alemán", 5, 32.00, 2),
    ("Coco",   "Ave",   "Periquito",     1,  0.30, 3),
    ("Bella",  "Perro", "Beagle",        4, 18.75, 4),
    ("Nemo",   "Pez",   "Payaso",        1,  0.10, 5),
    ("Toby",   "Perro", "Bulldog",       6, 22.30, 2),
    ("Pelusa", "Gato",  "Persa",         3,  5.80, 3);

INSERT INTO citas
    (fecha, hora, motivo, id_mascota, id_veterinario)
VALUES
    ('2026-04-02', '09:00', 'Alergia',     1, 1),
    ('2026-04-12', '10:30', 'Infección',   2, 1),
    ('2026-04-15', '09:30', 'Pulgas',      5, 2),
    ('2026-04-20', '08:30', 'Vómitos',     8, 2),
    ('2026-04-07', '17:00', 'Otitis',      3, 2),
    ('2026-04-17', '15:00', 'Traumatismo', 6, 1),
    ('2026-04-01', '11:30', 'Fractura',    7, 3),
    ('2026-04-30', '11:20', 'Vacuna',      4, 3);

INSERT INTO tratamientos
    (descripcion, costo, fecha, id_mascota, id_veterinario)
VALUES
    ('Anti-histamínico',   5.50,  '2026-04-12', 1, 1),
    ('Infección',          20,    '2026-04-06', 2, 1),
    ('Dermatológico',      10.50, '2026-04-07', 5, 2),
    ('Lavado de estómago', 20.80, '2026-04-08', 8, 2),
    ('Gotas',              5.60,  '2026-04-01', 3, 2),
    ('Vendaje',            8.4,   '2026-04-22', 6, 1),
    ('Entablillado',       25.60, '2026-04-17', 7, 3),
    ('Electrolitos',       10,    '2026-04-14', 4, 3);

-- SELECT 
--     m.nombre,
--     m.tipo,
--     m.raza,
--     CONCAT(d.nombre, ' ', d.apellidos) AS dueno,
--     d.telefono
-- FROM mascotas AS m
-- INNER JOIN duenos AS d
--     ON m.id_dueno = d.id_dueno;

-- SELECT
--     c.fecha,
--     c.hora,
--     m.nombre AS mascota,
--     m.tipo,
--     CONCAT(v.nombre, ' ', v.apellidos) AS veterinario,
--     v.especialidad
-- FROM citas AS c
-- INNER JOIN mascotas m
--     ON c.id_mascota = m.id_mascota
-- INNER JOIN veterinarios AS v
--     ON c.id_veterinario = v.id_veterinario;

-- SELECT
--     d.nombre AS dueno,
--     d.telefono,
--     m.nombre AS mascota,
--     m.tipo
-- FROM duenos AS d
-- LEFT JOIN mascotas AS m
--     ON d.id_dueno = m.id_dueno
-- ORDER BY
--     d.nombre;

-- UPDATE duenos
-- SET telefono = '699888777'
-- WHERE id_dueno = 1;

-- UPDATE mascotas
-- SET peso = 123
-- WHERE id_mascota IN (1,2,3,4);

-- DELETE FROM citas WHERE id_cita = 5;

-- DELETE FROM tratamientos WHERE id_tratamiento = 3;

DELETE FROM citas WHERE id_cita = 4;
DELETE FROM tratamientos WHERE id_tratamiento = 4;
DELETE FROM mascotas WHERE id_mascota = 8;

SELECT * FROM citas;

SELECT * FROM tratamientos;

SELECT * FROM mascotas;