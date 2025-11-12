
use SistemaNominas
go

---------
----- ----Limpiar------------------------
DELETE FROM DetalleNomina; 
DELETE FROM Nominas; 
DELETE FROM Asistencias; 
DELETE FROM PeriodosNomina; 
DELETE FROM Contratos;
DELETE FROM Empleados; 
DELETE FROM TiposContrato; 
DELETE FROM Puestos; 
DELETE FROM Sedes; 
DELETE FROM AFPs; 
DELETE FROM Usuarios;
go

-----------DATOS USUARIOS ----------------------

INSERT INTO Usuarios (NombreUsuario, ClaveHash, NombreCompleto, Rol)
VALUES 
('juan.perez', HASHBYTES('SHA2_256', 'admin123'), 'Juan Pérez Castillo', 'Administrador de Nómina'),

('maria.lopez', HASHBYTES('SHA2_256', 'recursos123'), 'María López Ramírez', 'Jefe de Recursos Humanos'),

('carlos.ramos', HASHBYTES('SHA2_256', 'asistente01'), 'Carlos Ramos Díaz', 'Asistente');
GO

Select * from Usuarios
----------------------------
----------------------------

-- Inserción de Puestos------------

INSERT INTO Puestos (NombrePuesto, Descripcion) VALUES
		('Gerente de Tienda', 'Encargado de la gestión integral de la botica'),
		('Supervisor de Ventas', 'Supervisa las operaciones y cumplimiento de metas'),
		('Farmacéutico Titular', 'Responsable de la dispensación de medicamentos'),
		('Técnico en Farmacia', 'Asiste en la preparación y atención al cliente'),
		('Cajero(a)', 'Encargado del cobro y arqueo diario'),
		('Asistente Administrativo', 'Apoya en la gestión documental y trámites internos'),
		('Auxiliar de Almacén', 'Gestiona el stock y recepción de productos'),
		('Repartidor', 'Realiza entregas de pedidos a domicilio'),
		('Limpieza y Mantenimiento', 'Encargado del orden y limpieza del local'),
		('Soporte Informático', 'Brinda soporte a sistemas y equipos de la botica');
GO
--------------------------------
---------------------------------
-- Sedes
INSERT INTO Sedes (NombreSede, Direccion) VALUES
('Sede Chao', 'Av. Larco 123'),
('Sede Virú', 'Calle San Francisco 456a'),
('Sede Trujillo', 'Jr. Pizarro 789');
go
------------------
------------------
-- AFPs ----------------
INSERT INTO AFPs (NombreAFP, Fondo, PrimaSeguro, Comision, FechaVigencia) VALUES
('Prima', 10.00, 1.37, 1.60, '2024-01-01'),
('Habitat', 10.00, 1.37, 1.47, '2024-01-01'),
('Integra', 10.00, 1.37, 1.55, '2024-01-01'),
('Profuturo', 10.00, 1.37, 1.69, '2024-01-01');
go
-------------
--------------------
-- Tipos de Contrato-------------
INSERT INTO TiposContrato (NombreTipo, Descripcion) VALUES
('Indeterminado', 'Contrato sin fecha de término'),
('Plazo Fijo', 'Contrato con una fecha de fin establecida'),
('Temporal', 'Contrato por una necesidad específica o estacional');
GO
---------------------
---------------------

-- Empleados 
INSERT INTO Empleados (CodigoEmpleado, TipoDocumento, NumeroDocumento, Nombres, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Sexo, Direccion, Telefono, Email, Estado, TipoPension, IdAfp, NumeroHijos) VALUES
('E0001','DNI','70845123','Fiorella','Quispe','Cruz','1995-03-12','F','Av. Brasil 1421, Lima','987321654','fiorella.quispe@gmail.com','Activo','AFP',1,1),
('E0002','DNI','71485692','Luis','Huamán','Rojas','1989-09-24','M','Jr. Los Pinos 214, Arequipa','987456321','luis.huaman@gmail.com','Activo','AFP',2,2),
('E0003','DNI','72356412','Diana','Cáceres','Pérez','1996-12-05','F','Av. La Cultura 550, Cusco','912345678','diana.caceres@gmail.com','Activo','ONP',NULL,0),
('E0004','DNI','71523698','Kevin','Condori','Torres','1992-07-08','M','Av. San Felipe 840, Lima','965874123','kevin.condori@gmail.com','Activo','AFP',3,1),
('E0005','DNI','71984562','Milagros','Vásquez','Flores','1997-02-19','F','Calle Comercio 430, Arequipa','976123458','milagros.vasquez@gmail.com','Activo','AFP',4,0),
('E0006','DNI','70693214','José','Ramírez','Huerta','1985-05-11','M','Av. Los Héroes 312, Lima','954632781','jose.ramirez@gmail.com','Activo','ONP',NULL,2),
('E0007','DNI','71259643','Natalia','Poma','Luna','1999-08-30','F','Jr. Las Flores 215, Cusco','981654723','natalia.poma@gmail.com','Activo','AFP',1,0),
('E0008','DNI','73485219','Marco','Salinas','Mendoza','1990-10-02','M','Av. Garcilaso 789, Lima','945128376','marco.salinas@gmail.com','Activo','AFP',2,1),
('E0009','DNI','72654132','Rosa','Calle','Huillca','1987-01-21','F','Calle Bolognesi 340, Arequipa','954783216','rosa.calle@gmail.com','Activo','ONP',NULL,3),
('E0010','DNI','73369541','Andrés','Zapata','Mamani','1995-09-18','M','Av. Ejército 1020, Arequipa','986745123','andres.zapata@gmail.com','Activo','AFP',3,1),
('E0011','DNI','72156987','Gabriela','Loayza','Condori','1994-04-15','F','Av. Grau 310, Cusco','987456321','gabriela.loayza@gmail.com','Activo','AFP',2,0),
('E0012','DNI','71965231','Julio','Ticona','Apaza','1988-12-08','M','Jr. Independencia 121, Lima','943215698','julio.ticona@gmail.com','Activo','AFP',1,2),
('E0013','DNI','72984561','Patricia','Soto','Quispe','1993-06-21','F','Av. Arequipa 1780, Lima','954786123','patricia.soto@gmail.com','Activo','ONP',NULL,0),
('E0014','DNI','73561249','Miguel','Córdova','Yupanqui','1990-02-10','M','Jr. Junín 541, Arequipa','945632178','miguel.cordova@gmail.com','Activo','AFP',4,1),
('E0015','DNI','72456318','Yessenia','Torres','Camacho','1998-09-29','F','Av. Bolognesi 640, Cusco','954789321','yessenia.torres@gmail.com','Activo','AFP',3,0),
('E0016','DNI','70789452','Ricardo','Pérez','Valdez','1987-01-12','M','Calle Progreso 400, Lima','985471236','ricardo.perez@gmail.com','Activo','AFP',1,1),
('E0017','DNI','71325849','Carla','Ramos','Lazo','1992-10-25','F','Av. Miraflores 732, Arequipa','996587412','carla.ramos@gmail.com','Activo','ONP',NULL,0),
('E0018','DNI','72014536','Edgar','Mamani','Soto','1985-05-03','M','Av. La Paz 250, Cusco','976854231','edgar.mamani@gmail.com','Activo','AFP',2,2),
('E0019','DNI','71987452','Lucía','Cruz','Huanca','1999-07-19','F','Av. Los Incas 712, Lima','912458763','lucia.cruz@gmail.com','Activo','AFP',3,1),
('E0020','DNI','72874125','Fernando','Choque','Ramírez','1988-08-09','M','Jr. Tarapacá 302, Arequipa','934562781','fernando.choque@gmail.com','Activo','ONP',NULL,0),
('E0021','DNI','72459613','Denisse','Paredes','Calla','1996-03-21','F','Av. San Martín 450, Lima','974125836','denisse.paredes@gmail.com','Activo','AFP',1,1),
('E0022','DNI','71354789','Raúl','Gutierrez','Soto','1987-11-08','M','Av. Unión 895, Cusco','912345897','raul.gutierrez@gmail.com','Activo','AFP',4,0),
('E0023','DNI','72214756','Melissa','Reyna','Ticona','1994-06-16','F','Av. Los Andes 820, Arequipa','954789631','melissa.reyna@gmail.com','Activo','AFP',2,2),
('E0024','DNI','71895264','Héctor','Flores','Quispe','1989-05-22','M','Calle San Juan 312, Lima','985632741','hector.flores@gmail.com','Activo','ONP',NULL,1),
('E0025','DNI','71698412','Verónica','Sánchez','Campos','1991-01-04','F','Av. Grau 450, Cusco','932147856','veronica.sanchez@gmail.com','Activo','AFP',3,0),
('E0026','DNI','71984631','Esteban','Chávez','Ramos','1984-04-10','M','Jr. Lima 800, Arequipa','956478321','esteban.chavez@gmail.com','Activo','AFP',2,3),
('E0027','DNI','73254198','Pamela','Mendoza','Huerta','1993-10-07','F','Av. Salaverry 201, Lima','976541283','pamela.mendoza@gmail.com','Activo','AFP',4,0),
('E0028','DNI','73456921','Juan','Lopez','Arana','1990-08-19','M','Jr. Santa Rosa 150, Cusco','934785621','juan.lopez@gmail.com','Activo','ONP',NULL,2),
('E0029','DNI','72541693','Paola','Arias','Medina','1997-02-24','F','Av. Arequipa 456, Lima','945612378','paola.arias@gmail.com','Activo','AFP',1,0),
('E0030','DNI','72985476','Rodrigo','Campos','Vilca','1985-03-13','M','Av. Independencia 230, Arequipa','985412637','rodrigo.campos@gmail.com','Activo','AFP',2,1),
('E0031','DNI','71598426','Cindy','Apaza','Solis','1992-11-21','F','Jr. Sucre 102, Cusco','954789612','cindy.apaza@gmail.com','Activo','AFP',3,0),
('E0032','DNI','72469853','Renato','Carrillo','Tello','1988-09-03','M','Av. Miraflores 890, Lima','976541239','renato.carrillo@gmail.com','Activo','ONP',NULL,1),
('E0033','DNI','73245981','Karla','Villanueva','Vargas','1994-07-14','F','Av. Grau 890, Arequipa','981236547','karla.villanueva@gmail.com','Activo','AFP',4,0),
('E0034','DNI','71456329','Antonio','Ramos','Silva','1986-05-06','M','Calle Comercio 320, Lima','987412536','antonio.ramos@gmail.com','Activo','AFP',1,2),
('E0035','DNI','72145896','Camila','Huertas','Cáceres','1997-10-30','F','Jr. Santa Ana 412, Cusco','952314876','camila.huertas@gmail.com','Activo','AFP',2,0),
('E0036','DNI','72365814','Diego','Gamarra','Quispe','1985-04-12','M','Av. Primavera 890, Arequipa','976584123','diego.gamarra@gmail.com','Activo','ONP',NULL,3),
('E0037','DNI','72694513','Tatiana','Pérez','López','1991-02-01','F','Av. San Felipe 450, Lima','987145632','tatiana.perez@gmail.com','Activo','AFP',3,0),
('E0038','DNI','71984573','Sebastián','Valdez','Huamán','1988-08-18','M','Av. San Martín 900, Cusco','954781263','sebastian.valdez@gmail.com','Activo','AFP',2,1),
('E0039','DNI','72895147','Vania','Yupanqui','Chávez','1999-11-05','F','Av. Grau 350, Lima','934875126','vania.yupanqui@gmail.com','Activo','AFP',1,0),
('E0040','DNI','73569421','Hugo','Zamora','Paredes','1984-06-12','M','Calle Lima 410, Arequipa','945861237','hugo.zamora@gmail.com','Activo','ONP',NULL,2),
('E0041','DNI','71369524','Liliana','Paredes','Nina','1995-03-28','F','Av. La Paz 210, Cusco','987451236','liliana.paredes@gmail.com','Activo','AFP',3,1),
('E0042','DNI','72541678','Gustavo','Cruz','Camacho','1987-09-09','M','Av. Túpac Amaru 700, Lima','956874123','gustavo.cruz@gmail.com','Activo','AFP',4,0),
('E0043','DNI','71784563','Ruth','Huerta','Apaza','1993-01-11','F','Calle San Juan 800, Arequipa','945123678','ruth.huerta@gmail.com','Activo','ONP',NULL,0),
('E0044','DNI','72456913','Jorge','Nina','Valdez','1989-08-07','M','Av. Garcilaso 500, Cusco','965874312','jorge.nina@gmail.com','Activo','AFP',2,2),
('E0045','DNI','72295147','Claudia','Campos','Ramos','1998-02-14','F','Av. Los Héroes 320, Lima','954632178','claudia.campos@gmail.com','Activo','AFP',1,0),
('E0046','DNI','71894635','Daniel','Rojas','Puma','1986-10-17','M','Av. Arequipa 460, Arequipa','912365874','daniel.rojas@gmail.com','Activo','AFP',4,1),
('E0047','DNI','72658941','Alejandra','Ticona','Torres','1997-09-30','F','Av. Grau 780, Cusco','934785612','alejandra.ticona@gmail.com','Activo','AFP',3,0),
('E0048','DNI','73214586','César','Choque','Gonzales','1988-07-25','M','Jr. Junín 210, Lima','987654312','cesar.choque@gmail.com','Activo','ONP',NULL,2),
('E0049','DNI','72145693','Brenda','Mamani','Vilca','1996-11-01','F','Av. Miraflores 600, Arequipa','976214583','brenda.mamani@gmail.com','Activo','AFP',2,0),
('E0050','DNI','73521496','Adrián','Flores','Huerta','1989-05-19','M','Av. San Martín 990, Lima','945632781','adrian.flores@gmail.com','Activo','AFP',1,1);
GO



--------------
---------------
-- Inserción de Contratos (100 registros coherentes con 80% vigentes y 20% finalizados)
INSERT INTO Contratos (CodigoContrato, IdEmpleado, IdPuesto, IdSede, IdTipoContrato, ModoPago, SueldoBase, FechaInicio, FechaFin, FechaRenuncia, MotivoRenuncia, Estado) VALUES
-- Contratos Vigentes (40)
('C0001',1,3,1,1,'Mensual',3200.00,'2022-11-01',NULL,NULL,NULL,'Vigente'),
('C0002',2,4,2,2,'Mensual',2100.00,'2023-04-15','2024-04-14',NULL,NULL,'Vigente'),
('C0003',3,5,3,1,'Quincenal',1800.00,'2021-09-10',NULL,NULL,NULL,'Vigente'),
('C0004',4,2,1,2,'Mensual',2500.00,'2025-01-01','2026-05-01',NULL,NULL,'Vigente'),
('C0005',5,6,2,1,'Mensual',2700.00,'2020-07-05',NULL,NULL,NULL,'Vigente'),
('C0006',6,1,1,1,'Mensual',4500.00,'2021-03-01',NULL,NULL,NULL,'Vigente'),
('C0007',7,3,2,2,'Mensual',3100.00,'2023-08-10','2024-08-09',NULL,NULL,'Vigente'),
('C0008',8,4,1,3,'Mensual',7900.00,'2024-01-10','2024-07-10',NULL,NULL,'Vigente'),
('C0009',9,5,3,2,'Quincenal',1700.00,'2023-09-01','2024-09-01',NULL,NULL,'Vigente'),
('C0010',10,7,1,1,'Mensual',2000.00,'2022-10-01',NULL,NULL,NULL,'Vigente'),
('C0011',11,2,2,2,'Mensual',4600.00,'2023-02-01','2024-02-01',NULL,NULL,'Vigente'),
('C0012',12,3,3,1,'Mensual',3200.00,'2021-06-15',NULL,NULL,NULL,'Vigente'),
('C0013',13,5,1,3,'Mensual',4600.00,'2024-03-01','2024-08-31',NULL,NULL,'Vigente'),
('C0014',14,1,2,1,'Mensual',5400.00,'2021-04-01',NULL,NULL,NULL,'Vigente'),
('C0015',15,6,3,2,'Mensual',2100.00,'2023-06-01','2024-06-01',NULL,NULL,'Vigente'),
('C0016',16,4,1,1,'Mensual',2000.00,'2021-10-05',NULL,NULL,NULL,'Vigente'),
('C0017',17,8,2,3,'Mensual',1600.00,'2024-02-01','2024-07-31',NULL,NULL,'Vigente'),
('C0018',18,2,1,2,'Mensual',2700.00,'2023-08-01','2024-08-01',NULL,NULL,'Vigente'),
('C0019',19,3,3,1,'Mensual',3100.00,'2021-05-01',NULL,NULL,NULL,'Vigente'),
('C0020',20,5,1,3,'Mensual',1800.00,'2024-01-10','2024-06-30',NULL,NULL,'Vigente'),
('C0021',21,9,3,1,'Mensual',1500.00,'2022-03-01',NULL,NULL,NULL,'Vigente'),
('C0022',22,10,1,2,'Mensual',2500.00,'2023-04-01','2024-04-01',NULL,NULL,'Vigente'),
('C0023',23,8,2,3,'Mensual',1700.00,'2023-09-10','2024-09-09',NULL,NULL,'Vigente'),
('C0024',24,4,3,1,'Mensual',2000.00,'2021-12-01',NULL,NULL,NULL,'Vigente'),
('C0025',25,2,1,2,'Mensual',2900.00,'2023-05-01','2024-05-01',NULL,NULL,'Vigente'),
('C0026',26,3,2,3,'Mensual',3100.00,'2021-01-01',NULL,NULL,NULL,'Vigente'),
('C0027',27,5,1,2,'Mensual',1800.00,'2023-07-01','2024-07-01',NULL,NULL,'Vigente'),
('C0028',28,7,2,1,'Mensual',1900.00,'2022-02-01',NULL,NULL,NULL,'Vigente'),
('C0029',29,4,3,2,'Mensual',2200.00,'2023-06-15','2024-06-15',NULL,NULL,'Vigente'),
('C0030',30,6,1,1,'Mensual',2400.00,'2022-09-01',NULL,NULL,NULL,'Vigente'),
('C0031',31,2,2,1,'Mensual',2700.00,'2023-04-01','2024-04-01',NULL,NULL,'Vigente'),
('C0032',32,3,3,2,'Mensual',3200.00,'2021-08-15',NULL,NULL,NULL,'Vigente'),
('C0033',33,1,1,1,'Mensual',3500.00,'2020-07-01',NULL,NULL,NULL,'Vigente'),
('C0034',34,5,2,3,'Mensual',1600.00,'2023-09-01','2024-09-01',NULL,NULL,'Vigente'),
('C0035',35,8,1,2,'Mensual',1700.00,'2023-05-10','2024-05-09',NULL,NULL,'Vigente'),
('C0036',36,6,3,3,'Mensual',2200.00,'2021-10-10',NULL,NULL,NULL,'Vigente'),
('C0037',37,4,1,2,'Mensual',2100.00,'2023-06-01','2024-06-01',NULL,NULL,'Vigente'),
('C0038',38,9,2,1,'Mensual',1500.00,'2022-04-01',NULL,NULL,NULL,'Vigente'),
('C0039',39,10,3,3,'Mensual',2500.00,'2023-07-01','2024-07-01',NULL,NULL,'Vigente'),
('C0040',40,2,2,1,'Mensual',2900.00,'2021-03-01',NULL,NULL,NULL,'Vigente'),
-- Contratos Finalizados (5)
('C0041',41,5,3,2,'Mensual',1800.00,'2022-05-01','2023-05-01',NULL,NULL,'No Vigente'),
('C0042',42,3,1,2,'Mensual',3000.00,'2021-06-01','2022-06-01',NULL,NULL,'No Vigente'),
('C0043',43,8,2,3,'Mensual',1700.00,'2023-01-01','2023-12-31',NULL,NULL,'No Vigente'),
('C0044',44,6,1,1,'Mensual',2300.00,'2020-05-01','2021-05-01',NULL,NULL,'No Vigente'),
('C0045',45,4,2,3,'Mensual',2000.00,'2022-02-01','2023-02-01',NULL,NULL,'No Vigente'),
-- Contratos Renunciados (5)
('C0046',46,5,3,2,'Mensual',1800.00,'2023-01-01','2023-12-31','2023-09-15','Renuncia voluntaria por motivos personales','No Vigente'),
('C0047',47,2,1,1,'Mensual',2700.00,'2022-05-01','2023-05-01','2023-03-20','Renuncia por nueva oportunidad laboral','No Vigente'),
('C0048',48,3,2,3,'Mensual',3100.00,'2022-07-01','2023-07-01','2023-06-10','Renuncia por traslado de residencia','No Vigente'),
('C0049',49,6,3,1,'Mensual',2300.00,'2023-03-01','2024-03-01','2023-12-20','Renuncia anticipada por estudios','No Vigente'),
('C0050',50,4,1,2,'Mensual',2000.00,'2022-10-01','2023-10-01','2023-08-30','Renuncia voluntaria','No Vigente');
GO
--------------------------------------------------
-------------------------------------------------
--Inserción de Periodos 
INSERT INTO PeriodosNomina (NombrePeriodo, ModoPago, FechaInicio, FechaFin, DiasHabiles, Estado, FechaCierre)
VALUES
-- Periodos Mensuales (2024)
('ENERO-2024', 'Mensual', '2024-01-01', '2024-01-31', 22, 'Terminada', NULL),
('FEBRERO-2024', 'Mensual', '2024-02-01', '2024-02-29', 21, 'Terminada', NULL),
('MARZO-2024', 'Mensual', '2024-03-01', '2024-03-31', 21, 'Terminada', NULL),
('ABRIL-2024', 'Mensual', '2024-04-01', '2024-04-30', 22, 'Terminada', NULL),
('MAYO-2024', 'Mensual', '2024-05-01', '2024-05-31', 23, 'Terminada', NULL),
('JUNIO-2024', 'Mensual', '2024-06-01', '2024-06-30', 20, 'Terminada', NULL),
('JULIO-2024', 'Mensual', '2024-07-01', '2024-07-31', 23, 'Terminada', NULL),
('AGOSTO-2024', 'Mensual', '2024-08-01', '2024-08-31', 22, 'Terminada', NULL),
('SEPTIEMBRE-2024', 'Mensual', '2024-09-01', '2024-09-30', 21, 'Terminada', NULL),
('OCTUBRE-2024', 'Mensual', '2024-10-01', '2024-10-31', 23, 'Terminada', NULL),
('NOVIEMBRE-2024', 'Mensual', '2024-11-01', '2024-11-30', 20, 'En proceso', NULL),
('DICIEMBRE-2024', 'Mensual', '2024-12-01', '2024-12-31', 21, 'Abierto', NULL),

('ENERO-2025-1', 'Quincenal', '2025-01-01', '2025-01-15', 11, 'Terminada', NULL),
('ENERO-2025-2', 'Quincenal', '2025-01-16', '2025-01-31', 10, 'Terminada', NULL),
('fEBRERO-2025-1', 'Quincenal', '2025-02-01', '2025-02-15', 10, 'Terminada', NULL),
('fEBRERO-2025-2', 'Quincenal', '2025-02-16', '2025-02-28', 9, 'Terminada', NULL),
('MARZO-2025-1', 'Quincenal', '2025-03-01', '2025-03-15', 11, 'Terminada', NULL),
('MARZO-2025-2', 'Quincenal', '2025-03-16', '2025-03-31', 10, 'Terminada', NULL),
('ABRABRIL1Q-2025-1', 'Quincenal', '2025-04-01', '2025-04-15', 10, 'Abierto', NULL);
GO

select * from PeriodosNomina









SELECT COUNT(*) FROM Contratos WHERE Estado = 'Vigente'


SELECT COUNT(*) FROM Empleados


SELECT COUNT(*) 
                    FROM Contratos 
                    WHERE FechaFin BETWEEN GETDATE() AND DATEADD(DAY,7,GETDATE()) 
                    AND Estado = 'Vigente'


SELECT TOP 5 
    e.Nombres, 
    c.CodigoContrato, 
    c.FechaFin
FROM Contratos c
INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
WHERE c.FechaFin = DATEADD(DAY, 5, CAST(GETDATE() AS DATE))
  AND c.Estado = 'Vigente'
ORDER BY c.FechaFin ASC;


WITH ContratosProximos AS
(
    SELECT TOP 7 *
    FROM Contratos
    WHERE Estado = 'Vigente'
    ORDER BY FechaFin ASC
)
UPDATE Contratos
SET FechaFin = DATEADD(DAY, 5, CAST(GETDATE() AS DATE))
FROM Contratos c
INNER JOIN ContratosProximos cp ON c.CodigoContrato = cp.CodigoContrato;

