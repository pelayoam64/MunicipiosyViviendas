--Obtener CREATE TABLE que generen las tablas de la base de datos considerando todas las restricciones de integridad oportunas. 

CREATE TABLE MUNICIPIO (  
cod_municipio INT PRIMARY KEY AUTO_INCREMENT, 
nombre VARCHAR(100) NOT NULL, 
provincia VARCHAR(100) NOT NULL  
);  

CREATE TABLE VIVIENDAS( 
cod_vivienda INT PRIMARY KEY AUTO_INCREMENT,  
metrosCuadrados INT, 
codigoPostal VARCHAR(5), 
direccion VARCHAR(150), 
cod_municipio INT, 
DNI VARCHAR(9), 
FOREIGN KEY (cod_municipio) REFERENCES MUNICIPIO(cod_municipio) 
 ); 

CREATE TABLE PERSONA ( 
DNI VARCHAR(9) PRIMARY KEY,  
Telefono VARCHAR(9), 
Nombre VARCHAR(100) NOT NULL, 
cod_vivienda INT, 
FOREIGN KEY (cod_vivienda) REFERENCES VIVIENDAS(cod_vivienda)
); 

-- Obtener los INSERT necesarios para introducir al menos 4 registros en cada tabla (se recomienda leer las consultas antes de insertar los datos).

INSERT INTO PERSONA (DNI, Telefono, Nombre, cod_vivienda) VALUES  
('71721014A', '684258407', 'Pablo', 7), 
('50511250J', '777777777', 'Eljuanjo', 8), 
('45500480P', '100001101', 'Fausto', 9), 
('45411512J', '999412506', 'Hulio', 10),  
('71754151J', '787895004', 'Ramoncin', 11), 
('85865113M', '585141516', 'Elnervio', 12);  

INSERT INTO MUNICIPIO (nombre, provincia) VALUES  
('Luarca', 'Asturias'),  
('Valdés', 'Asturias'),  
('Navia', 'Asturias'),  
('Avilés', 'Asturias'),  
('Tineo', 'Asturias'),  
('Oviedo', 'Asturias'), 
('Colunga', 'Asturias'), 
('Morcín', 'Asturias'), 
('Boal', 'Asturias');  

INSERT INTO VIVIENDAS (metrosCuadrados, codigoPostal, direccion, cod_municipio, DNI) VALUES 
(100, '33100', 'Calle Mayor 1', 1, '71721014A'), 
(120, '33200', 'Calle Principal 2', 2, '50511250J'), 
(150, '33300', 'Avenida Central 3', 3, '45500480P'), 
(130, '33400', 'Plaza Grande 4', 4, '45411512J'), 
(110, '33500', 'Calle Pequeña 5', 5, '71754151J'), 
(140, '33600', 'Calle Nueva 6', 6, '85865113M'); 




--Consultas

-- Nombre y teléfono de los habitantes de Luarca
SELECT PERSONA.Nombre, PERSONA.Telefono
FROM PERSONA
INNER JOIN VIVIENDAS ON PERSONA.cod_vivienda = VIVIENDAS.cod_vivienda
INNER JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Luarca';
-- Nombre y teléfono de los habitantes del municipio de Valdés
SELECT PERSONA.Nombre, PERSONA.Telefono
FROM PERSONA
INNER JOIN VIVIENDAS ON PERSONA.cod_vivienda = VIVIENDAS.cod_vivienda
INNER JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Valdés';

--Dirección y metros cuadrados de las viviendas del municipio de Navia.

SELECT VIVIENDAS.direccion, VIVIENDAS.metrosCuadrados
FROM VIVIENDAS
INNER JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Navia';

--Nombre y teléfono de aquellas personas que poseen una vivienda en Navia.
SELECT PERSONA.Nombre, PERSONA.Telefono
FROM PERSONA
JOIN VIVIENDAS ON PERSONA.cod_vivienda = VIVIENDAS.cod_vivienda
JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Navia';
--De todas las viviendas del municipio de Avilés, su dirección, localidad y nombre del propietario.
SELECT VIVIENDAS.direccion, MUNICIPIO.nombre AS localidad, PERSONA.Nombre AS propietario
FROM VIVIENDAS
JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
JOIN PERSONA ON VIVIENDAS.DNI = PERSONA.DNI
WHERE MUNICIPIO.nombre = 'Avilés';
--Nombre, dirección y teléfono de todos los cabeza de familia empadronados en el municipio de Tineo.
SELECT PERSONA.Nombre, VIVIENDAS.direccion, PERSONA.Telefono
FROM PERSONA
JOIN VIVIENDAS ON PERSONA.cod_vivienda = VIVIENDAS.cod_vivienda
JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Tineo';
--Dirección completa de todas las viviendas del municipio de Oviedo y nombre y teléfono de su propietario para todas aquellas que superan los 150 m2.
SELECT VIVIENDAS.direccion, PERSONA.Nombre, PERSONA.Telefono
FROM VIVIENDAS
JOIN PERSONA ON VIVIENDAS.DNI = PERSONA.DNI
JOIN MUNICIPIO ON VIVIENDAS.cod_municipio = MUNICIPIO.cod_municipio
WHERE MUNICIPIO.nombre = 'Oviedo' AND VIVIENDAS.metrosCuadrados > 150;
--Nombre de todos los municipios de Asturias en los que la superficie media de sus viviendas supera los 70 m2.
SELECT MUNICIPIO.nombre
FROM MUNICIPIO
JOIN VIVIENDAS ON MUNICIPIO.cod_municipio = VIVIENDAS.cod_municipio
GROUP BY MUNICIPIO.nombre
HAVING AVG(VIVIENDAS.metrosCuadrados) > 70;
--Nombre de cada municipio de Asturias y cantidad de viviendas en cada uno de ellos que supera los 300 m2
SELECT MUNICIPIO.nombre, COUNT(*) AS cantidad_viviendas
FROM MUNICIPIO
JOIN VIVIENDAS ON MUNICIPIO.cod_municipio = VIVIENDAS.cod_municipio
WHERE VIVIENDAS.metrosCuadrados > 300
GROUP BY MUNICIPIO.nombre;
--Número total de cabezas de familia empadronados en el municipio de Proaza.
