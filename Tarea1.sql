
USE Tesebada;

-- Script de importacion bulkinsert

BULK INSERT VENTAS
FROM 'E:\Universidad Materias\Tesebada\Repositorio de datos\Tarea1.Datos.txt'
WITH(
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n',
FIRSTROW = 2);

-- Los tres articulos mas vendidos y la cantidad

SELECT PROD PRODUCTO, COUNT(VENTA) [TOTAL DE VENTAS], SUM(CANTIDAD) CANTIDAD
FROM VENTAS
WHERE PROD NOT LIKE ''
GROUP BY PROD
ORDER BY PROD, [TOTAL DE VENTAS], CANTIDAD DESC;

-- La linea de artículos mas vendida y porque

SELECT TOP 1 PROD PRODUCTO, SUM(CANTIDAD) CANTIDAD
FROM VENTAS
GROUP BY PROD
ORDER BY CANTIDAD DESC

SELECT PROD PRODUCTO, SUM(CANTIDAD) CANTIDAD, PRECIO, COSTO, COUNT(VENTA) VENTA
FROM VENTAS
WHERE PROD LIKE 'HUEVO PIEZA'
GROUP BY PROD , CANTIDAD, PRECIO, COSTO, VENTA

-- Realizar un reporte en el que se vea el total vendido por cada caja y mes del año

SELECT (CANTIDAD*PRECIO) [TOTAL VENDIDO], CAJA, MONTH(TS) MES, YEAR(TS) AÑO
FROM VENTAS
GROUP BY (CANTIDAD*PRECIO), CAJA, MONTH(TS), YEAR(TS)
ORDER BY CAJA, MES, AÑO

-- Realizar un listado de cuáles son los 3 artículos más vendidos de cada mes

SELECT * FROM VENTAS;

-- Mostrar un reporte los importes vendidos por cajero y una columna para cada mes



-- A que hora/Bloque del día se compran más artículos por venta.
-- Dividir el día en 4 bloques. A de 6-10hrs, B 11-14hrs, C 15-18hrs y D 19-22hrs

SELECT SUM(CANTIDAD) CANTIDAD, DATEPART(HOUR, TS) HORA
FROM VENTAS
WHERE DATEPART(HOUR, TS) BETWEEN 6 AND 10
GROUP BY DATEPART(HOUR, TS)
UNION(
SELECT SUM(CANTIDAD) CANTIDAD, DATEPART(HOUR, TS) HORA
FROM VENTAS
WHERE DATEPART(HOUR, TS) BETWEEN 11 AND 14
GROUP BY DATEPART(HOUR, TS))
UNION(
SELECT SUM(CANTIDAD) CANTIDAD, DATEPART(HOUR, TS) HORA
FROM VENTAS
WHERE DATEPART(HOUR, TS) BETWEEN 15 AND 18
GROUP BY DATEPART(HOUR, TS))
UNION(
SELECT SUM(CANTIDAD) CANTIDAD, DATEPART(HOUR, TS) HORA
FROM VENTAS
WHERE DATEPART(HOUR, TS) BETWEEN 19 AND 22
GROUP BY DATEPART(HOUR, TS))
-- GROUP BY SUM(CANTIDAD), DATEPART(HOUR, TS)
ORDER BY DATEPART(HOUR, TS)

-- Verificar esta tendencia durante los cuartos del año.
-- Producir un reporte en el que ponga el promedio de artículos vendidos por bloque, por cuarto del año



-- Sacar un listado de artículos y meses durante los cuales un artículo se vendió por debajo del 5% de utilidad

