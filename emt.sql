-- Active: 1774601231506@@127.0.0.1@3306@emt
DROP DATABASE IF EXISTS emt;

CREATE DATABASE emt
CHARSET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE emt;

CREATE TABLE lineas (
    numero           INT           PRIMARY KEY,
    tipo             VARCHAR(255),
    inicio           VARCHAR(255)  NOT NULL,
    fin              VARCHAR(255)  NOT NULL,    
    -- recorrido        VARCHAR(255)  NOT NULL,
    tramos           VARCHAR(255)  NOT NULL,
    frecuencia_media INT           UNSIGNED,
    duracion_media   INT           UNSIGNED
);

CREATE TABLE conductores (
    no_empleado       INT          PRIMARY KEY,
    nombre            VARCHAR(255) NOT NULL,
    apellidos         VARCHAR(255) NOT NULL,
    id_linea          INT,
    FOREIGN KEY (id_linea)
        REFERENCES lineas(numero)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO lineas
    (numero, tipo, inicio, fin, tramos, frecuencia_media, duracion_media)
VALUES
    (
        1,
        "convencional",
        "Plaza de Castilla",
        "Puente de Vallecas",
        "Plaza de Castilla — Paseo de la Castellana — Colón — Cibeles — Atocha — Delicias — Embajadores — Puente de Vallecas",
        8,
        50
    ), (
        3,
        "convencional",
        "Moncloa",
        "Villaverde Alto",
        "Moncloa — Argüelles — Plaza de España — Gran Vía — Sol — Atocha — Delicias — Legazpi — Usera — Orcasitas — Villaverde Alto",
        7,
        60
    ), (
        5,
        "convencional",
        "Plaza de Castilla",
        "Puerta del Ángel",
        "Plaza de Castilla — Paseo de la Castellana — Plaza de Colón — Plaza de España — Argüelles — Moncloa — Casa de Campo — Puerta del Ángel",
        8,
        65
    ), (
        7,
        "convencional",
        "Avenida de América",
        "Pueblo Nuevo",
        "Avenida de América — Goya — O'Donnell — Conde de Casal — Méndez Álvaro — Pacífico — Estrella — Pueblo Nuevo",
        11,
        38
    ),  (
        11,
        "convencional",
        "Plaza de España",
        "La Elipa",
        "Plaza de España — Gran Vía — Embajadores — Atocha — Méndez Álvaro — Conde de Casal — La Elipa",
        11,
        30
    ), (
        31,
        "convencional",
        "Plaza de Castilla",
        "Conde de Casal",
        "Plaza de Castilla — Nuevos Ministerios — Paseo del Prado/Cibeles — Atocha/Delicias — Méndez Álvaro — Conde de Casal",
        14,
        45
    ), (
        64,
        "convencional",
        "Plaza de Castilla",
        "Ramón y Cajal",
        "Plaza de Castilla — Tetuán — Alvarado — Cuatro Caminos — Bravo Murillo — Ramón y Cajal",
        15,
        40
    ), (
        82,
        "convencional",
        "Moncloa",
        "Aluche",
        "Moncloa — Argüelles — Casa de Campo — Campamento — Aluche",
        14,
        40
    ), (
        121,
        "convencional",
        "Plaza de Castilla",
        "Alameda de Osuna",
        "Plaza de Castilla — Avenida de América — Barrio de la Concepción — Canillejas — Barajas — Alameda de Osuna",
        18,
        48
    );

INSERT INTO conductores
    (no_empleado, nombre, apellidos, id_linea)
VALUES 
    ( 1001, "Marta",    "Álvarez Ruiz",   1),
    ( 1002, "Javier",   "Moreno García",  3),
    ( 1003, "Laura",    "Sánchez Díaz",   5),
    ( 1004, "Andrés",   "Romero López",   7),
    ( 1005, "Patricia", "Muñoz Herrera",  11),
    ( 1006, "David",    "Ortega Marín",   31),
    ( 1007, "Sonia",    "Castillo Pérez", 64),
    ( 1008, "Miguel",   "Torres Gómez",   121),
    ( 1009, "Elena",    "Ruiz Fernández", 1),
    ( 1010, "Fernando", "Molina Santos",  3);

-- ¿Qué líneas pasan por Atocha?

SELECT numero, tramos
FROM lineas
WHERE tramos LIKE "%Atocha%";

-- ¿Qué conductores pasan por Atocha?
SELECT
    c.no_empleado,
    CONCAT(c.nombre, " ", c.apellidos) AS conductor,
    l.numero AS linea
FROM conductores AS c
JOIN lineas l ON c.id_linea = l.numero
WHERE l.tramos LIKE "%Atocha%";

-- Líneas ordenadas por la parada inicio, y fin.
SELECT *
FROM lineas
ORDER BY inicio, fin;

-- Lista las líneas ordenadas por el tiempo que tardan completar su recorrido.
SELECT
    numero,
    CONCAT(inicio, " — ", fin) AS recorrido,
    duracion_media
FROM lineas
ORDER BY
    duracion_media DESC;

-- Reasigna a dos conductores para que intercambien lineas.
UPDATE conductores
SET id_linea = 3
WHERE no_empleado = 1005;

UPDATE conductores
SET id_linea = 11
WHERE no_empleado = 1002;

-- Elimina una linea.
DELETE FROM lineas
WHERE numero = 7;

-- Comprueba que hay un conductor sin linea asociada.
SELECT * FROM conductores WHERE id_linea IS NULL;