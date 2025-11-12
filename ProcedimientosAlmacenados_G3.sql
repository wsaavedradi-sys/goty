
USE SistemaNominas
GO

-- ============================== PROCEDIMIENTOS ALMACENADOS PARA GESTIONAR CONTRATO LABORAL ====================================

--===========Login=================

	CREATE PROCEDURE usp_validar_usuario
		@NombreUsuario VARCHAR(50),
		@ClaveHash VARBINARY(256)
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			IdUsuario,
			NombreUsuario,
			NombreCompleto,
			Rol,
			Estado,
			FechaRegistro
		FROM Usuarios
		WHERE NombreUsuario = @NombreUsuario
		  AND ClaveHash = @ClaveHash
		  AND Estado = 'Activo';
	END
	GO

--===========Listar Contratos=================

	CREATE PROCEDURE sel_consultar_lista_contratos
	AS
	BEGIN
		SELECT 
			c.IdContrato,
			c.CodigoContrato,
			e.IdEmpleado,
			e.NumeroDocumento,
			e.Nombres + ' ' + e.ApellidoPaterno + ' ' + ISNULL(e.ApellidoMaterno,'') AS Empleado,
			p.IdPuesto,
			p.NombrePuesto,
			s.IdSede,
			s.NombreSede,
			tc.IdTipoContrato,
			tc.NombreTipo,
			c.ModoPago,
			c.SueldoBase,
			c.FechaInicio,
			c.FechaFin,
			c.Estado
		FROM Contratos c
		INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
		INNER JOIN Puestos p ON c.IdPuesto = p.IdPuesto
		INNER JOIN Sedes s ON c.IdSede = s.IdSede
		INNER JOIN TiposContrato tc ON c.IdTipoContrato = tc.IdTipoContrato;
	END
	GO
--===========Insertar Contrato=================

	create or alter procedure ins_insertar_contrato(
		@CodigoContrato varchar(10),
		@IdEmpleado int,
		@IdPuesto int,
		@IdSede int,
		@IdTipoContrato int,
		@ModoPago varchar(20),
		@SueldoBase decimal(10,2),
		@FechaInicio date,
		@FechaFin date = null
		)
		as
		begin
			insert into Contratos (CodigoContrato, IdEmpleado, IdPuesto, IdSede, IdTipoContrato, ModoPago, 
			SueldoBase, FechaInicio, FechaFin, Estado
			)
			values (@CodigoContrato,@IdEmpleado,@IdPuesto,@IdSede,@IdTipoContrato,@ModoPago,@SueldoBase,
				@FechaInicio,@FechaFin,'Vigente')
		end
		go

--===========Modificar Contrato=================

	create or alter procedure upd_modificar_contrato(
		@IdContrato int,
		@IdPuesto int,
		@IdSede int,
		@IdTipoContrato int,
		@ModoPago varchar(20),
		@SueldoBase decimal(10,2),
		@FechaInicio date,
		@FechaFin date = null,
		@Estado varchar(20)
		)
	as
	begin
		update Contratos
		set 
			IdPuesto = @IdPuesto,
			IdSede = @IdSede,
			IdTipoContrato = @IdTipoContrato,
			ModoPago = @ModoPago,
			SueldoBase = @SueldoBase,
			FechaInicio = @FechaInicio,
			FechaFin = @FechaFin,
			Estado = @Estado
		where IdContrato = @IdContrato;
	end
	go

--===========Dar de Baja Contrato=================

	create or alter procedure upd_eliminar_contrato(
    @IdContrato int,
    @FechaRenuncia date = null,
    @MotivoRenuncia varchar(250) = null
	)
	as
	begin
		update Contratos
		set 
			Estado = 'No Vigente',
			FechaRenuncia = @FechaRenuncia,
			MotivoRenuncia = @MotivoRenuncia
		where IdContrato = @IdContrato;
	end
	go



--===========Consultar afps por ID=================

	create procedure sel_obtener_afp_por_id
		@IdAfp int
	as
	begin
		select  
			IdAfp,
			NombreAFP,
			Fondo,
			PrimaSeguro,
			Comision
		from AFPs
		where IdAfp = @IdAfp
	end
	go

--===========Consultar empleados por DNI=================


	
	CREATE PROCEDURE sel_consultar_dni_empleado
	    @NumeroDocumento VARCHAR(20)
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			E.IdEmpleado,
			E.NumeroDocumento,
			E.Nombres,
			E.ApellidoPaterno,
			E.ApellidoMaterno,
			E.Sexo,
			E.FechaNacimiento,
			E.Direccion,
			E.Telefono,
			E.Email,
			E.NumeroHijos,
			E.TipoPension,
			E.IdAfp,
			A.NombreAFP,
			A.Fondo,
			A.PrimaSeguro,
			A.Comision
		FROM Empleados E
		LEFT JOIN AFPs A ON E.IdAfp = A.IdAfp
		WHERE E.NumeroDocumento = @NumeroDocumento
		  AND E.Estado = 'Activo'
	END
	GO

--===========Consultar Puestos=================

	create procedure sel_obtener_puestos
	as

	set nocount on 

		select IdPuesto, NombrePuesto
		from Puestos
	go
--===========Consultar Tipo de Contrato =================

	create procedure sel_obtener_tipo_contrato
		as

		set nocount on 

			select IdTipoContrato, NombreTipo
			from TiposContrato
		go

--===========Consultar Sedes =================

	create procedure sel_obtener_sede
		as

		set nocount on 

			select IdSede, NombreSede
			from Sedes
		go


--=========== Consultar contratos por estado =================

	CREATE PROCEDURE sel_consultar_contrato_por_estado
		@Estado VARCHAR(20)
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			c.IdContrato,
			c.CodigoContrato,
			e.IdEmpleado,
			e.NumeroDocumento,
			e.Nombres + ' ' + e.ApellidoPaterno + ' ' + ISNULL(e.ApellidoMaterno, '') AS Empleado,
			p.IdPuesto,
			p.NombrePuesto,
			s.IdSede,
			s.NombreSede,
			tc.IdTipoContrato,
			tc.NombreTipo,
			c.ModoPago,
			c.SueldoBase,
			c.FechaInicio,
			c.FechaFin,
			c.Estado
		FROM Contratos c
		INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
		INNER JOIN Puestos p ON c.IdPuesto = p.IdPuesto
		INNER JOIN Sedes s ON c.IdSede = s.IdSede
		INNER JOIN TiposContrato tc ON c.IdTipoContrato = tc.IdTipoContrato
		WHERE c.Estado = @Estado
	END
	GO

--=========== Consultar contratos por tipo de contrato =================

	create procedure sel_consultar_contrato_por_tipo_contrato
		@IdTipoContrato int
	as
	begin
		select 
			c.IdContrato,
			c.CodigoContrato,
			e.IdEmpleado,
			e.NumeroDocumento,
			e.Nombres + ' ' + e.ApellidoPaterno + ' ' + isnull(e.ApellidoMaterno,'') as Empleado,
			p.IdPuesto,
			p.NombrePuesto,
			s.IdSede,
			s.NombreSede,
			tc.IdTipoContrato,
			tc.NombreTipo,
			c.ModoPago,
			c.SueldoBase,
			c.FechaInicio,
			c.FechaFin,
			c.Estado
		from contratos c
		inner join empleados e on c.IdEmpleado = e.IdEmpleado
		inner join puestos p on c.IdPuesto = p.IdPuesto
		inner join sedes s on c.IdSede = s.IdSede
		inner join tiposcontrato tc on c.IdTipoContrato = tc.IdTipoContrato
		where c.IdTipoContrato = @IdTipoContrato
	end
	go

--=========== Consultar contratos por fecha inicio =================

	create procedure sel_consultar_contrato_por_fecha_inicio
	@FechaInicio date
	as
	begin
		select 
			c.IdContrato,
			c.CodigoContrato,
			e.IdEmpleado,
			e.NumeroDocumento,
			e.Nombres + ' ' + e.ApellidoPaterno + ' ' + isnull(e.ApellidoMaterno,'') as Empleado,
			p.IdPuesto,
			p.NombrePuesto,
			s.IdSede,
			s.NombreSede,
			tc.IdTipoContrato,
			tc.NombreTipo,
			c.ModoPago,
			c.SueldoBase,
			c.FechaInicio,
			c.FechaFin,
			c.Estado
		from contratos c
		inner join empleados e on c.IdEmpleado = e.IdEmpleado
		inner join puestos p on c.IdPuesto = p.IdPuesto
		inner join sedes s on c.IdSede = s.IdSede
		inner join tiposcontrato tc on c.IdTipoContrato = tc.IdTipoContrato
		where c.FechaInicio = @FechaInicio
	end
	go

--=========== Consultar contratos por fecha fin =================

	create procedure sel_consultar_contrato_por_fecha_fin
	@FechaFin date
	as
	begin
		select 
			c.IdContrato,
			c.CodigoContrato,
			e.IdEmpleado,
			e.NumeroDocumento,
			e.Nombres + ' ' + e.ApellidoPaterno + ' ' + isnull(e.ApellidoMaterno,'') as Empleado,
			p.IdPuesto,
			p.NombrePuesto,
			s.IdSede,
			s.NombreSede,
			tc.IdTipoContrato,
			tc.NombreTipo,
			c.ModoPago,
			c.SueldoBase,
			c.FechaInicio,
			c.FechaFin,
			c.Estado
		from contratos c
		inner join empleados e on c.IdEmpleado = e.IdEmpleado
		inner join puestos p on c.IdPuesto = p.IdPuesto
		inner join sedes s on c.IdSede = s.IdSede
		inner join tiposcontrato tc on c.IdTipoContrato = tc.IdTipoContrato
		where c.FechaFin = @FechaFin
	end
	go

-- ============================== PROCEDIMIENTOS ALMACENADOS PARA PROCESAR NOMINA POR PERIODO ====================================


--=========== Listar Periodos Disponibles para Procesar =================

	create procedure sel_consultar_lista_periodos_disponibles
	as
	begin
		select 
			IdPeriodo,
			NombrePeriodo,
			ModoPago,
			FechaInicio,
            FechaFin,  
			DiasHabiles,
			Estado
		from PeriodosNomina
		where Estado in ('Terminada')
		order by FechaInicio desc
	end
	go


--=========== Consultar Lista de Periodos Disponibles por Tipo de Pago =================

	create procedure sel_consultar_lista_periodos_disponibles_por_tipopago
	@ModoPago varchar(20)
	as
	begin
		select 
			IdPeriodo,
			NombrePeriodo,
			ModoPago,
			FechaInicio, 
            FechaFin,  
			DiasHabiles,
			Estado
		from PeriodosNomina
		where ModoPago = @ModoPago
		and Estado in ('Abierto','En proceso','Terminada')
		order by FechaInicio desc
	end
	go

--=========== Consultar Lista de Periodos Disponibles por Estado =================

	create procedure sel_consultar_lista_periodos_disponibles_por_estado
	@Estado varchar(20)
	as
	begin
		select 
			IdPeriodo,
			NombrePeriodo,
			ModoPago,
			FechaInicio, 
            FechaFin,  
			DiasHabiles,
			Estado
		from PeriodosNomina
		where Estado = @Estado
		and Estado <> 'Cerrado'
		order by FechaInicio desc
	end
	go

--=========== Consultar Lista de Periodos por Fecha Inicio y/o Fecha Fin =================

	create procedure sel_consultar_lista_periodos_por_fechas
	@FechaInicio date = null,
	@FechaFin date = null
	as
	begin
		select 
			IdPeriodo,
			NombrePeriodo,
			ModoPago,
            FechaInicio,  
            FechaFin,  			
			DiasHabiles,
			Estado
		from PeriodosNomina
		where 
			(@FechaInicio is null or FechaInicio >= @FechaInicio)
			and (@FechaFin is null or FechaFin <= @FechaFin)
			and Estado <> 'Cerrado'
		order by FechaInicio desc
	end
	go

--=========== Insertar Nomina =================

	CREATE PROCEDURE ins_insertar_nomina
		@IdPeriodo INT,
		@ProcesadoPor INT
	AS
	BEGIN
		SET NOCOUNT ON;

		DECLARE @ExisteNomina INT;

		SELECT @ExisteNomina = COUNT(*) 
		FROM Nominas 
		WHERE IdPeriodo = @IdPeriodo AND Estado IN ('Procesada', 'Cerrada');

		IF @ExisteNomina > 0
			RETURN;

		INSERT INTO Nominas (IdPeriodo, ProcesadoPor, FechaProcesado, Estado)
		VALUES (@IdPeriodo, @ProcesadoPor, GETDATE(), 'Procesada');
	END
	GO


--=========== Insertar Detalle de Nómina =================

	CREATE PROCEDURE ins_insertar_detalle_nomina
		@IdPeriodo INT,
		@IdContrato INT,
		@IdEmpleado INT,
		@IdNomina INT,
		@DiasTrabajados INT,
		@SueldoBase DECIMAL(12,2),
		@SueldoPeriodo DECIMAL(12,2),
		@SalarioHora DECIMAL(12,4),
		@HorasExtras DECIMAL(10,2),
		@PagoHorasExtras DECIMAL(12,2),
		@HorasNocturnas DECIMAL(10,2),
		@RecargoNocturno DECIMAL(12,2),
		@DiasFeriadosTrabajados INT,
		@PagoFeriado DECIMAL(12,2),
		@AsignacionFamiliar DECIMAL(12,2),
		@Gratificacion DECIMAL(12,2),

		@BonificacionExtraordinaria DECIMAL(12,2),
		@TotalUltimaGratificacion DECIMAL(12,2),

		@RemuneracionComputable DECIMAL(12,2),

		@TotalIngresos DECIMAL(12,2),

		@IngresosAcumuladosAno DECIMAL(14,2),
		@MesesRestantesAno INT,
		@TotalIngresosProyectadosAnual DECIMAL(14,2),
		@MontoImponibleAnual DECIMAL(14,2),
		@MontoImponiblePeriodo DECIMAL(12,2),
		@ImpuestoAnual DECIMAL(14,2),
		@RentaQuintaMensual DECIMAL(12,2),

		@SueldoAsegurable DECIMAL(12,2),

		@AporteONP DECIMAL(12,2),
		@AporteAFP DECIMAL(12,2),
		@PrimaSeguroAFP DECIMAL(12,2),
		@ComisionAFP DECIMAL(12,2),
		@TotalDescuentos DECIMAL(12,2),

		@EsSalud DECIMAL(12,2),
		@CTS DECIMAL(12,2),

		@TotalAportesEmpleador DECIMAL(12,2),
		@SueldoNeto DECIMAL(12,2),
		@AplicaGratificacion BIT,
		@AplicaCTS BIT,
		@Mes INT,
		@Anio INT
	AS
	BEGIN
		SET NOCOUNT ON;

		INSERT INTO DetalleNomina (
			IdPeriodo, IdContrato, IdEmpleado, IdNomina, DiasTrabajados, SueldoBase, SueldoPeriodo, SalarioHora, HorasExtras, PagoHorasExtras,
			HorasNocturnas, RecargoNocturno, DiasFeriadosTrabajados, PagoFeriado, AsignacionFamiliar, Gratificacion, BonificacionExtraordinaria,
			TotalUltimaGratificacion, RemuneracionComputable, TotalIngresos, IngresosAcumuladosAno, MesesRestantesAno, TotalIngresosProyectadosAnual,
			MontoImponibleAnual, MontoImponiblePeriodo, ImpuestoAnual, RentaQuintaMensual, SueldoAsegurable, AporteONP, AporteAFP, PrimaSeguroAFP,
			ComisionAFP, TotalDescuentos, EsSalud, CTS, TotalAportesEmpleador, SueldoNeto,
			AplicaGratificacion, AplicaCTS, Mes, Anio
		)
		VALUES (
			@IdPeriodo, @IdContrato, @IdEmpleado, @IdNomina, @DiasTrabajados, @SueldoBase, @SueldoPeriodo, @SalarioHora, @HorasExtras, @PagoHorasExtras,
			@HorasNocturnas, @RecargoNocturno, @DiasFeriadosTrabajados, @PagoFeriado, @AsignacionFamiliar, @Gratificacion,
			@BonificacionExtraordinaria, @TotalUltimaGratificacion, @RemuneracionComputable, @TotalIngresos, @IngresosAcumuladosAno,
			@MesesRestantesAno, @TotalIngresosProyectadosAnual, @MontoImponibleAnual, @MontoImponiblePeriodo,
			@ImpuestoAnual, @RentaQuintaMensual, @SueldoAsegurable, @AporteONP, @AporteAFP,
			@PrimaSeguroAFP, @ComisionAFP, @TotalDescuentos,
			@EsSalud, @CTS, @TotalAportesEmpleador, @SueldoNeto,
			@AplicaGratificacion, @AplicaCTS, @Mes, @Anio
		);
	END
	GO
	
--=========== Ver detalle Nómina Procesada =================

	CREATE PROCEDURE sel_detalle_nomina_procesada
    @IdPeriodo INT
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
		    e.IdEmpleado,
			e.NumeroDocumento,
			CONCAT(e.ApellidoPaterno, ' ', e.ApellidoMaterno, ' ', e.Nombres) AS Nombres,
			c.IdContrato,
			c.CodigoContrato,
			d.SueldoNeto
		FROM DetalleNomina d
		INNER JOIN Contratos c ON d.IdContrato = c.IdContrato
		INNER JOIN Empleados e ON c.IdEmpleado = e.IdEmpleado
		INNER JOIN Nominas n ON d.IdNomina = n.IdNomina
		WHERE n.IdPeriodo = @IdPeriodo
		  AND n.Estado = 'Procesada';
	END
	GO


--=========== Cerrar Nómina =================

	CREATE PROCEDURE upd_cerrar_nomina
    @IdPeriodo INT,
    @CerradoPor INT
	AS
	BEGIN
		SET NOCOUNT ON;

		UPDATE Nominas
		SET Estado = 'Cerrada',
			CerradoPor = @CerradoPor,
			FechaCierre = SYSDATETIME()
		WHERE IdPeriodo = @IdPeriodo AND Estado = 'Procesada';

		UPDATE PeriodosNomina
		SET Estado = 'Cerrado',
			FechaCierre = SYSDATETIME()
		WHERE IdPeriodo = @IdPeriodo;
	END
	GO

--=========== Anular Nómina =================

	CREATE PROCEDURE upd_anular_nomina
		@IdPeriodo INT,
		@AnuladoPor INT,
		@MotivoAnulacion VARCHAR(250)
	AS
	BEGIN
		SET NOCOUNT ON;

		UPDATE Nominas
		SET Estado = 'Anulada',
			AnuladoPor = @AnuladoPor,
			FechaAnulacion = SYSDATETIME(),
			MotivoAnulacion = @MotivoAnulacion
		WHERE IdPeriodo = @IdPeriodo AND Estado IN ('Procesada','Cerrada');
	END
	GO

-- ============================== CONSULTA PARA GENERAR REPORTE DE NOMINA ====================================


-- ===================== Obtener Asistencias =====================
	CREATE PROCEDURE sel_asistencias_por_empleado_y_periodo
		@IdEmpleado INT,
		@IdPeriodo INT
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			IdAsistencia,
			IdEmpleado,
			Fecha,
			HorasTrabajadas,
			HorasExtras,
			HorasNocturnas,
			EsFeriado,
			Asistio,
			IdPeriodo
		FROM Asistencias
		WHERE IdEmpleado = @IdEmpleado
		  AND IdPeriodo = @IdPeriodo;
	END
	GO


-- ===================== Listar Periodos Cerrados =====================

	CREATE PROCEDURE sel_listar_periodos_cerrados
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
		    IdPeriodo,
			NombrePeriodo,
			FechaInicio,  
            FechaFin,  
			DiasHabiles,
			ModoPago
		FROM PeriodosNomina
		WHERE Estado = 'Cerrado'
		ORDER BY FechaFin DESC;
	END
	GO

-- ===================== Filtrar Periodos Cerrados por Fecha =====================
	
	CREATE PROCEDURE sel_listar_periodos_cerrados_por_fecha
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
		    IdPeriodo,
			NombrePeriodo,
            FechaInicio,  
            FechaFin,  			
			DiasHabiles,
			ModoPago
		FROM PeriodosNomina
		WHERE Estado = 'Cerrado'
		  AND (@FechaInicio IS NULL OR FechaInicio >= @FechaInicio)
		  AND (@FechaFin IS NULL OR FechaFin <= @FechaFin)
		ORDER BY FechaFin DESC;
	END
	GO

-- ===================== Consulta Para Generar Reporte  =====================

	CREATE PROCEDURE sel_Generar_Reporte
		@IdNomina INT,
		@IdUsuario INT  
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			CONCAT('R', RIGHT('00000' + CAST(N.IdNomina AS VARCHAR(5)), 5)) AS CodigoReporte, 
			PN.ModoPago,
			PN.FechaInicio,
			PN.FechaFin,
			GETDATE() AS FechaGeneracion,
			U.NombreUsuario AS GeneradoPor
		FROM Nominas N
		INNER JOIN PeriodosNomina PN ON N.IdPeriodo = PN.IdPeriodo
		INNER JOIN Usuarios U ON U.IdUsuario = @IdUsuario
		WHERE N.IdNomina = @IdNomina;

		SELECT 
			E.CodigoEmpleado,
			E.NumeroDocumento,
			CONCAT(E.Nombres, ' ', E.ApellidoPaterno, ' ', ISNULL(E.ApellidoMaterno, '')) AS NombreCompleto,
			C.FechaInicio,
			C.FechaFin,
			P.NombrePuesto,
			S.NombreSede,
			C.ModoPago,

			(ISNULL(SUM(A.HorasTrabajadas), 0) + ISNULL(SUM(A.HorasExtras), 0) + ISNULL(SUM(A.HorasNocturnas), 0)) AS TotalHoras,

			MAX(DN.DiasTrabajados),
			DN.SueldoBase,

			DN.SueldoPeriodo,
			DN.AsignacionFamiliar,
			DN.PagoHorasExtras,
			DN.RecargoNocturno,
			DN.PagoFeriado,
			DN.Gratificacion,
			DN.BonificacionExtraordinaria,
			DN.TotalIngresos,

			DN.AporteONP,
			DN.AporteAFP,
			DN.PrimaSeguroAFP,
			DN.ComisionAFP,
			DN.RentaQuintaMensual,
			DN.TotalDescuentos,

			DN.EsSalud,
			DN.CTS,
			DN.TotalAportesEmpleador,

			DN.SueldoNeto

		FROM Nominas N
		INNER JOIN PeriodosNomina PN ON N.IdPeriodo = PN.IdPeriodo
		INNER JOIN DetalleNomina DN ON PN.IdPeriodo = DN.IdPeriodo
		INNER JOIN Contratos C ON DN.IdContrato = C.IdContrato
		INNER JOIN Empleados E ON DN.IdEmpleado = E.IdEmpleado
		INNER JOIN Puestos P ON C.IdPuesto = P.IdPuesto
		INNER JOIN Sedes S ON C.IdSede = S.IdSede
		LEFT JOIN Asistencias A ON A.IdEmpleado = E.IdEmpleado AND A.IdPeriodo = PN.IdPeriodo

		WHERE N.IdNomina = @IdNomina

		GROUP BY 
			E.CodigoEmpleado, E.NumeroDocumento, E.Nombres, E.ApellidoPaterno, E.ApellidoMaterno,
			C.FechaInicio, C.FechaFin, P.NombrePuesto, S.NombreSede, C.ModoPago,
			DN.SueldoBase, DN.SueldoPeriodo, DN.AsignacionFamiliar, DN.PagoHorasExtras, 
			DN.RecargoNocturno, DN.PagoFeriado, DN.Gratificacion, DN.BonificacionExtraordinaria,
			DN.TotalIngresos, DN.AporteONP, DN.AporteAFP, DN.PrimaSeguroAFP, DN.ComisionAFP,
			DN.RentaQuintaMensual, DN.TotalDescuentos, DN.EsSalud, DN.CTS, DN.TotalAportesEmpleador,
			DN.SueldoNeto

		ORDER BY E.CodigoEmpleado;

		SELECT 
			SUM(DN.SueldoNeto) AS TotalSueldosNetos
		FROM Nominas N
		INNER JOIN PeriodosNomina PN ON N.IdPeriodo = PN.IdPeriodo
		INNER JOIN DetalleNomina DN ON PN.IdPeriodo = DN.IdPeriodo
		WHERE N.IdNomina = @IdNomina;
	END
	GO
