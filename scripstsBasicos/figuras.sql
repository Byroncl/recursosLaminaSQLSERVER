--crear db
create database figuras;
--usar db
use figuras;

-- Paso 2: consulta la vista del sistema sys.spatial_reference_systems

SELECT * FROM sys.spatial_reference_systems;
GO

-- Paso 3: profundice en el valor de srid 4326

SELECT * FROM sys.spatial_reference_systems
WHERE spatial_reference_id = 4326;
GO

-- Paso 4: consulta los sistemas de medición disponibles

SELECT DISTINCT unit_of_measure, unit_conversion_factor 
FROM sys.spatial_reference_systems;
GO

-- Paso 1 - Cambie a la base de datos AdventureWorks
Declare @forma geometry
Set @forma=geometry::STGeomFromText('CIRCULARSTRING (1 1, 2 2, 3 1, 2 0, 1 1)',0)
Select @forma

USE AdventureWorks;
GO

-- Paso 2 - Dibuja una forma usando geometría

DECLARE @Shape geometry;
SET @Shape = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SELECT @Shape;
GO

--Circulo
DECLARE @g geometry = 'CIRCULARSTRING(1 1, 2 2, 3 1, 2 0, 1 1)'
Select @g

-- Paso 3 - Dibuja dos formas

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1 
UNION ALL
SELECT @Shape2;
GO

--Paso 4: muestre lo que sucede si realiza una UNIÓN en lugar de una UNIÓN TODOS. Esto fallará ya que los tipos espaciales no son comparables.

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1 
UNION 
SELECT @Shape2;
GO

-- Paso 5 - Une las dos formas juntas

DECLARE @Shape1 geometry;
DECLARE @Shape2 geometry;
SET @Shape1 = geometry::STGeomFromText('POLYGON ((10 10, 25 15, 35 15, 40 10, 10 10))',0);
SET @Shape2 = geometry::STGeomFromText('POLYGON ((10 10, 25 5, 35 5, 40 10, 10 10))',0);
SELECT @Shape1.STUnion(@Shape2);
GO

-- Paso 6: ¿Qué distancia hay en metros desde Nueva York a Los Ángeles?

DECLARE @NewYork geography;
DECLARE @LosAngeles geography;
SET @NewYork = geography::STGeomFromText('POINT (-74.007339 40.726966)',4326);
SET @LosAngeles = geography::STGeomFromText('POINT (-118.24585 34.083375)',4326);
SELECT @NewYork.STDistance(@LosAngeles);
GO

-- Paso 7 - Dibuja el Pentágono

DECLARE @Pentagon geography;
SET @Pentagon = geography::STPolyFromText(
  'POLYGON(( -77.0532219483429 38.870863029297695,
             -77.05468297004701 38.87304314667469,
             -77.05788016319276 38.872800914712734,
             -77.05849170684814 38.870219840133124,
             -77.05556273460198 38.8690670969195,
             -77.0532219483429 38.870863029297695),
           ( -77.05582022666931 38.8702866652523,
             -77.0569360256195 38.870734733163644,
             -77.05673214773439 38.87170668418343,
             -77.0554769039154 38.871848684516294,
             -77.05491900444031 38.87097997215688,
             -77.05582022666931 38.8702866652523))',
           4326);
SELECT @Pentagon;
GO

-- Paso 8: llame al método ToString para observar el uso de los valores Z y M que se almacenan pero no se procesan

DECLARE @Point geometry;
SET @Point = geometry::STPointFromText('POINT(10 20 15 5)', 0);
SELECT @Point.ToString()
GO

-- Step 9 - Use GML para entrada

DECLARE @Point geography;
SET @Point = geography::GeomFromGml('
  <Point xmlns="http://www.opengis.net/gml">
      <pos>12 50</pos>
  </Point>',4326);
SELECT @Point;
GO

-- Paso 10 - Genere GML desde una ubicación (solo puntos de inicio y final del Canal de Panamá, no la forma completa)

DECLARE @PanamaCanal geography;
SET @PanamaCanal 
  = geography::STLineFromText('LINESTRING( -79.909 9.339, -79.536 8.942 )',4326);
SELECT @PanamaCanal,@PanamaCanal.AsGml();
GO

-- Paso 11: muestre cómo las colecciones pueden incluir diferentes tipos de objetos

DECLARE @ShapeCollection geometry;
SET @ShapeCollection = geometry::STGeomCollFromText(
   'GEOMETRYCOLLECTION( POLYGON((15 15, 10 15, 10 10, 15 15)),
                        POINT(10 10))',0);
SELECT @ShapeCollection;
GO


