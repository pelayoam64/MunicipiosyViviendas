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
FOREIGN KEY (cod_vivienda) REFERENCES VIVIENDAS(cod_vivienda), 
FOREIGN KEY (DNI) REFERENCES VIVIENDAS(DNI) 

 ); 

-- Obtener los INSERT necesarios para introducir al menos 4 registros en cada tabla (se recomienda leer las consultas antes de insertar los datos).

INSERT INTO PERSONA (DNI, Telefono, Nombre, cod_vivienda) VALUES  
('71721014A', '684258407', 'Pablo', 1), 
('50511250J', '777777777', 'Eljuanjo', 2), 
('45500480P', '100001101', 'Fausto', 3), 
('45411512J', '999412506', 'Hulio', 4),  
('71754151J', '787895004', 'Ramoncin', 5), 
('85865113M', '585141516', 'Elnervio', 6);  

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