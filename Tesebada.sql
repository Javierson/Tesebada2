
CREATE DATABASE Tesebada ON
(NAME = Tesebada, FILENAME =
'E:\Universidad Materias\Tesebada\Tesebada.mdf')
LOG ON 
(NAME='Tesebada_Log', FILENAME =
'E:\Universidad Materias\Tesebada\Tesebada_Log.ldf');

USE Tesebada;

CREATE TABLE VENTAS(
ID INT NOT NULL,
PROD NVARCHAR(200) NOT NULL,
CANTIDAD DECIMAL(10,4) NOT NULL,
PRECIO MONEY  NOT  NULL,
COSTO MONEY NOT NULL,
VENTA INT NOT NULL,
TS DATETIME NOT NULL,
LINEA NVARCHAR(50) NOT NULL,
CAJA NVARCHAR(10) NOT NULL,
CAJERO NVARCHAR(10) NOT NULL);

BULK INSERT VENTAS
FROM 'E:\Universidad Materias\Tesebada\Repositorio de datos\Tarea1.Datos.txt'
WITH(
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n',
FIRSTROW = 2);
-- LASTROW = 200);
-- Año, mes, dia
-- año, dia, mes
-- Los tres articulos mas vendidos y su cantidad

--SELECT @@TRANCOUNT

SELECT * FROM VENTAS;

SELECT TOP 3
-- PROD,
-- SUM(CANTIDAD),
-- COUNT(VENTA),
COUNT(DISTINCT VENTA) VENTAS
FROM VENTAS
GROUP BY PROD
ORDER BY COUNT(*) DESC

-- La linea de articulos mas vendida y porque


-- Insert

USE [Tesebada]
GO

INSERT INTO [dbo].[Ventas] ([ID], [PROD], [CANTIDAD], [PRECIO], [COSTO], [VENTA], [TS], [LINEA], [CAJA], [CAJERO])
     VALUES
           (730751
           ,'RECARGA TELCEL'
           ,1
           ,30
           ,1
           ,402090
           ,2014/01/01
           ,'AIRE'
           ,'CAJA1'
           ,'CAJERO2')
GO


--


-- REALIZAR UN REPORTE EN EL QUE SE VEA EL TOTAL VENDIDO POR CADA CAJA Y MES DEL ANO

SELECT *
FROM(
SELECT
DATEPART(MONTH, TS) M, LINEA, COUNT(*) CONTEO
FROM VENTAS
GROUP BY DATEPART(MONTH, TS), CAJA ) S
PIVOT (
SUM(CONTEO)
FOR M IN ( [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] ) ) PT
ORDER BY DATEPART(MONTH, TS), CAJA

-- MANERA MAS VERSATIL

SELECT CAJA,
SUM(CASE WHEN DATEPART(MONTH, TS) = 1 THEN CANTIDAD
ELSE 0 END)

-- Realizar un listado de cuáles son los 3 artículos más Vendidos de cada mes

