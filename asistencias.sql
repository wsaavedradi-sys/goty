

/*
====================================================================
  SCRIPT DE GENERACIÓN DE ASISTENCIAS - ENERO 2025 (ASISTENCIA PERFECTA)
====================================================================
*/

USE SistemaNominas
GO

PRINT ' Limpiando asistencias de Enero 2025 (Periodos 13 y 14)...';
DELETE FROM Asistencias WHERE IdPeriodo IN (13, 14);
GO

PRINT 'Comenzando la inserción de asistencias perfectas para Enero 2025...';


DECLARE @IdEmpleado INT = 1;
DECLARE @FechaActual DATE;
DECLARE @IdPeriodo INT;


WHILE @IdEmpleado <= 50
BEGIN
    SET @FechaActual = '2025-01-01'; 

    WHILE @FechaActual <= '2025-01-31'
    BEGIN
        
        IF @FechaActual <= '2025-01-15'
            SET @IdPeriodo = 13; 
        ELSE
            SET @IdPeriodo = 14; 

        
        IF @FechaActual = '2025-01-01'
        BEGIN
            INSERT INTO Asistencias (IdEmpleado, Fecha, HorasTrabajadas, HorasExtras, HorasNocturnas, EsFeriado, Asistio, IdPeriodo)
            VALUES (@IdEmpleado, @FechaActual, 0.00, 0.00, 0.00, 1, 0, @IdPeriodo);
        END
        ELSE IF DATENAME(WEEKDAY, @FechaActual) NOT IN ('Saturday', 'Sunday')
        BEGIN
            INSERT INTO Asistencias (IdEmpleado, Fecha, HorasTrabajadas, HorasExtras, HorasNocturnas, EsFeriado, Asistio, IdPeriodo)
            VALUES (@IdEmpleado, @FechaActual, 8.00, 0.00, 0.00, 0, 1, @IdPeriodo);
        END

        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END

    SET @IdEmpleado = @IdEmpleado + 1;
END
	
PRINT ' Proceso completado. Se generaron 1150 registros de asistencia (50 empleados * 23 días).';
GO


/*
====================================================================
  SCRIPT DE GENERACIÓN DE ASISTENCIAS - FEBRERO 2025 (CON HORAS EXTRAS)
====================================================================
*/

PRINT 'Limpiando asistencias de Febrero 2025 (Periodos 15 y 16)...';
DELETE FROM Asistencias WHERE IdPeriodo IN (15, 16);
GO


PRINT 'Comenzando la inserción de asistencias con Horas Extras (Febrero 2025)...';

DECLARE @IdEmpleado INT = 1;
DECLARE @FechaActual DATE;
DECLARE @IdPeriodo INT;
DECLARE @HorasExtras DECIMAL(5,2);
DECLARE @HorasNocturnas DECIMAL(5,2);
DECLARE @DiaSemana INT;



WHILE @IdEmpleado <= 50
BEGIN
    SET @FechaActual = '2025-02-01'; 

    WHILE @FechaActual <= '2025-02-28' 
    BEGIN
        
        IF @FechaActual <= '2025-02-15'
            SET @IdPeriodo = 15; 
        ELSE
            SET @IdPeriodo = 16; 

        IF DATENAME(WEEKDAY, @FechaActual) NOT IN ('Saturday', 'Sunday')
        BEGIN
            SET @HorasExtras = 0.00;
            SET @HorasNocturnas = 0.00;
            
            SET @DiaSemana = DATEPART(WEEKDAY, @FechaActual);


            IF @IdEmpleado BETWEEN 1 AND 10 AND @DiaSemana = 2 
                SET @HorasExtras = 2.00;


            ELSE IF @IdEmpleado BETWEEN 11 AND 20 AND @DiaSemana = 4 
                SET @HorasExtras = 1.50;

            ELSE IF @IdEmpleado BETWEEN 21 AND 30 AND @DiaSemana = 6 
                SET @HorasNocturnas = 2.00;
            
            ELSE IF @IdEmpleado BETWEEN 31 AND 40 AND @DiaSemana IN (3, 5)
                SET @HorasExtras = 1.00;
            

            INSERT INTO Asistencias (IdEmpleado, Fecha, HorasTrabajadas, HorasExtras, HorasNocturnas, EsFeriado, Asistio, IdPeriodo)
            VALUES (@IdEmpleado, @FechaActual, 8.00, @HorasExtras, @HorasNocturnas, 0, 1, @IdPeriodo);
        END

        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END

    SET @IdEmpleado = @IdEmpleado + 1;
END

PRINT 'Proceso completado. Se generaron 1000 registros de asistencia (50 empleados * 20 días laborables).';
GO


/*
====================================================================
  SCRIPT DE GENERACIÓN DE ASISTENCIAS - MARZO 2025 (CON FALTAS/INASISTENCIAS)
====================================================================
*/

PRINT '🧹 Limpiando asistencias de Marzo 2025 (Periodos 17 y 18)...';
DELETE FROM Asistencias WHERE IdPeriodo IN (17, 18);
GO

PRINT 'Comenzando la inserción de asistencias con Faltas (Marzo 2025)...';

DECLARE @IdEmpleado INT = 1;
DECLARE @FechaActual DATE;
DECLARE @IdPeriodo INT;
DECLARE @Asistio INT;
DECLARE @HorasTrabajadas DECIMAL(5,2);
DECLARE @HorasExtras DECIMAL(5,2);
DECLARE @EsFeriado INT;

DECLARE @FaltaLunesQ1 DATE = '2025-03-03';
DECLARE @FaltaMartesQ2 DATE = '2025-03-18';
DECLARE @FaltaMiercolesQ2 DATE = '2025-03-19';
DECLARE @FaltaPrimerosQ1_1 DATE = '2025-03-03';
DECLARE @FaltaPrimerosQ1_2 DATE = '2025-03-04';
DECLARE @FaltaPrimerosQ1_3 DATE = '2025-03-05';
DECLARE @FaltaQ2_Mix DATE = '2025-03-25'; 
DECLARE @ExtraQ2_Mix DATE = '2025-03-26'; 

WHILE @IdEmpleado <= 50
BEGIN
    SET @FechaActual = '2025-03-01'; 

    WHILE @FechaActual <= '2025-03-31'
    BEGIN
        
        IF @FechaActual <= '2025-03-15'
            SET @IdPeriodo = 17; 
        ELSE
            SET @IdPeriodo = 18; 

        IF DATENAME(WEEKDAY, @FechaActual) NOT IN ('Saturday', 'Sunday')
        BEGIN
            SET @Asistio = 1;
            SET @HorasTrabajadas = 8.00;
            SET @HorasExtras = 0.00;
            SET @EsFeriado = 0;
            

            IF @IdEmpleado BETWEEN 1 AND 10 AND @FechaActual = @FaltaLunesQ1
            BEGIN
                SET @Asistio = 0;
                SET @HorasTrabajadas = 0.00;
            END

            ELSE IF @IdEmpleado BETWEEN 11 AND 20 AND @FechaActual IN (@FaltaMartesQ2, @FaltaMiercolesQ2)
            BEGIN
                SET @Asistio = 0;
                SET @HorasTrabajadas = 0.00;
            END
            
            ELSE IF @IdEmpleado BETWEEN 21 AND 30 AND @FechaActual IN (@FaltaPrimerosQ1_1, @FaltaPrimerosQ1_2, @FaltaPrimerosQ1_3)
            BEGIN
                SET @Asistio = 0;
                SET @HorasTrabajadas = 0.00;
            END
            
            ELSE IF @IdEmpleado BETWEEN 31 AND 40 
            BEGIN
                IF @FechaActual = @FaltaQ2_Mix 
                BEGIN
                    SET @Asistio = 0;
                    SET @HorasTrabajadas = 0.00;
                END
                ELSE IF @FechaActual = @ExtraQ2_Mix 
                BEGIN
                    SET @HorasExtras = 1.00;
                END
            END

            INSERT INTO Asistencias (IdEmpleado, Fecha, HorasTrabajadas, HorasExtras, HorasNocturnas, EsFeriado, Asistio, IdPeriodo)
            VALUES (@IdEmpleado, @FechaActual, @HorasTrabajadas, @HorasExtras, 0.00, @EsFeriado, @Asistio, @IdPeriodo);
        END


        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END

    SET @IdEmpleado = @IdEmpleado + 1;
END

PRINT ' Proceso completado. Se generaron 1150 registros de asistencia (50 empleados * 23 días laborables).';
GO


