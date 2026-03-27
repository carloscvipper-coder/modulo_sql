DROP DATABASE IF EXISTS dominos;

CREATE DATABASE IF NOT EXISTS dominos
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE dominos;

CREATE TABLE IF NOT EXISTS repartidores(
    id       INT          PRIMARY KEY AUTO_INCREMENT,
    nombre   VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS pedidos(
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    id_repartidor INT           NOT NULL,
    precio        INT           NOT NULL,
    direccion     VARCHAR(256)  NOT NULL,
    descripcion   VARCHAR(256)  NOT NULL,
    nombre        VARCHAR(256)  NOT NULL,
    telefono      VARCHAR(256),
    realizado     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    entregado     TIMESTAMP     DEFAULT,
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id)
);

INSERT INTO
    repartidores(nombre, apellido)
VALUES
    ("Elsa",   "Brosón"),
    ("Elsa",   "Pato"),
    ("Debora", "Melo"),
    ("Tomás",  "Cao"),
    ("Marcia", "Ana"),
    ("Zoila",  "Cerda"),
    ("Elvis",  "Tek"),
    ("Paco",   "Merlo"),
    ("Aitor",  "Tilla"),
    ("Ana",    "Tomia"),
    ("Lola",   "Mento")
;

INSERT INTO
    pedidos(id_repartidor, precio, direccion, descripcion, nombre)
VALUES
    (4,  2359, "Almudena 38",      "Pizza Barbacoa Mediana",    "Debora Carne"),
    (9,  5066, "Cuatro Caminos 4", "Pizza Carbonara Familiar",  "Igor Dito"),
    (5,  1360, "Alcala 123",       "Pizza Especial Mediana",    "Elsa Ponido"),
    (11,  400, "Zarzuela 44",      "Pizza Barbacoa Individual", "Ali Cate"),
    (10, 2359, "Amparo 33",        "Pizza Carnivora Familiar",  "Mario Neta"),
    (1,  1154, "Carnero 12",       "Pizza Vegetal Mediana",     "Paca Garte"),
    (1,  8492, "Embajadores 38",   "Pizza Barbacoa Mediana",    "Elvis Tek"),
    (6,  1928, "Farmacia 14",      "Pizza Pepperoni Familiar",  "Rosa Melo"),
    (11, 1234, "Nao 10",           "Pizza Carbonara Familiar",  "Armando Bronca"),
    (2,  5638, "Madera 11",        "Pizza Barbacoa Familiar",   "Lola Mento");

-- Repartidores que han llevado algún pedido, ordenados de menor id.
SELECT *
FROM repartidores r
JOIN pedidos p ON r.id = p.id_repartidor
GROUP BY r.id;

-- Repartidores que NO han llevado ningún pedido.
SELECT
    r.nombre,
    r.apellido
FROM repartidores r
LEFT JOIN pedidos p ON r.id = p.id_repartidor
WHERE p.id IS NULL
GROUP BY r.id;

-- Repartidores y la cantidad total de pedidos realizados, ordenados de mayor a menor pedidos
SELECT
    r.nombre,
    r.apellido,
    (
        SELECT COUNT(*) FROM pedidos WHERE pedidos.id_repartidor = r.id
    ) AS total_pedidos
FROM repartidores r
ORDER BY total_pedidos DESC;

-- Repartidores que han llevado algún pedido, ordenados de menor id.
SELECT COUNT(*)
FROM repartidores r
JOIN pedidos p ON r.id = p.id_repartidor
GROUP BY r.id;

-- Pedidos de pizza familiar
SELECT *
FROM pedidos
WHERE descripcion LIKE "%familiar%";

-- Pedidos aun en reparto
SELECT *
FROM pedidos
WHERE entregado = realizado;

-- Pedidos ya repartidos
SELECT *
    FROM pedidos
WHERE entregado > realizado;

-- Clientes que vuelven
-- SELECT *
-- FROM pedidos
-- WHERE nombre 

-- Asigna telefonos a unos cuantos pedidos
UPDATE
    pedidos
SET
    telefono = CASE id
    WHEN 1 THEN '666123456'
    WHEN 2 THEN '666123457'
    WHEN 3 THEN '666123458'
    WHEN 4 THEN '666123459'
    WHEN 5 THEN '666123450'
    ELSE NULL
END
WHERE
    id IN(1, 2, 3, 4, 5);

-- Actualiza la hora de los pedidos finalizados
UPDATE pedidos
SET entregado = CURRENT_TIMESTAMP
WHERE pedidos.id IN (2,4,6,8,10);

-- Borramos un pedido que nunca se entrego
DELETE FROM pedidos
WHERE entregado = realizado;