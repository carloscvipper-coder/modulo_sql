DROP DATABASE IF EXISTS dominos;

CREATE DATABASE dominos
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE dominos;

CREATE TABLE repartidores(
    id       INT          PRIMARY KEY AUTO_INCREMENT,
    nombre   VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL
);

CREATE TABLE tipo_pizza(
    id     INT          PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
);

CREATE TABLE producto(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    precio   INT NOT NULL,
    cantidad INT NOT NULL,
);

CREATE TABLE pedidos(
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    id_repartidor INT           NOT NULL,
    precio        INT           NOT NULL,
    direccion     VARCHAR(256)  NOT NULL,
    descripcion   VARCHAR(256)  NOT NULL,
    nombre        VARCHAR(256)  NOT NULL,
    telefono      VARCHAR(256),
    realizado     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    entregado     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id)
);

INSERT INTO
    repartidores(nombre, apellido)
VALUES
    ("Aitor",  "Tilla"),
    ("Tomás",  "Cao"),
    ("Paco",   "Merlo"),
    ("Elsa",   "Brosón"),
    ("Elsa",   "Pato"),
    ("Debora", "Melo"),
    ("Marcia", "Ana"),
    ("Zoila",  "Cerda"),
    ("Elvis",  "Tek"),
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

-- Repartidores que NO han llevado ningún pedido.
SELECT
    r.nombre,
    r.apellido
FROM repartidores r
LEFT JOIN pedidos p ON r.id = p.id_repartidor
WHERE p.id IS NULL
GROUP BY r.id;

-- Repartidores y la cantidad total de pedidos realizados, ordenados de mayor a menor pedidos
-- SELECT
--     r.nombre,
--     r.apellido,
--     (
--         SELECT COUNT(*) FROM pedidos WHERE pedidos.id_repartidor = r.id
--     ) AS total_pedidos
-- FROM repartidores r
-- ORDER BY total_pedidos DESC;

-- Lo mismo de arriba pero sin usar una sub-query, solo con LEFT JOIN y GROUP BY.
SELECT
    r.nombre,
    r.apellido,
    COUNT(p.id) AS total_pedidos
FROM repartidores AS r
LEFT JOIN pedidos AS p ON p.id_repartidor = r.id
GROUP BY r.nombre
HAVING total_pedidos = 0
ORDER BY total_pedidos DESC;

-- Pedidos ya repartidos
SELECT *
FROM pedidos
WHERE entregado > realizado;

-- Actualiza la hora de los pedidos finalizados
UPDATE pedidos
SET entregado = CURRENT_TIMESTAMP
WHERE pedidos.id IN (2,4,6,8,10);

-- Borramos un pedido que nunca se entrego
DELETE FROM pedidos
WHERE entregado = realizado;