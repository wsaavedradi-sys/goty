
create database SistemaNominas
go

use SistemaNominas
go

 
create table Puestos (
    IdPuesto int identity(1,1) primary key,
    NombrePuesto varchar(100) not null,
    Descripcion varchar(250) null
)
go


create table AFPs (
    IdAFP int  primary key identity(1,1),
    NombreAFP varchar(50) not null,
    Fondo decimal(5,2) not null,          
    PrimaSeguro decimal(5,2) not null,    
    Comision decimal(5,2) not null,       
    FechaVigencia date not null
)
go


create table Sedes (
    IdSede int identity(1,1) primary key,
    NombreSede varchar(100) not null,
    Direccion varchar(250) null
)
go


create table Empleados (
    IdEmpleado int identity(1,1) primary key,
	CodigoEmpleado varchar(10) not null unique,
    TipoDocumento varchar(10) null,      
    NumeroDocumento varchar(20) unique not null,
    Nombres varchar(150) not null,
    ApellidoPaterno varchar(100) not null,
    ApellidoMaterno varchar(100) null,
    FechaNacimiento date null,
    Sexo char(1) null,
    Direccion varchar(250) null,
    Telefono varchar(30) null,
    Email varchar(150) null,
    Estado varchar(20) default 'Activo',
    TipoPension varchar(10) check (TipoPension IN ('AFP','ONP')) null,
    IdAfp int  null,                        
    NumeroHijos int  default 0 not null,    
    constraint  FK_Empleado_AFP foreign key (IdAfp) references AFPs(IdAfp)
)
go

create table TiposContrato (
    IdTipoContrato int identity(1,1) primary key,
    NombreTipo varchar(50) not null,     
    Descripcion varchar(200) null
)
go

create table Contratos (
    IdContrato int identity(1,1) primary key,
    CodigoContrato varchar(10) not null unique,
    IdEmpleado int  not null,
    IdPuesto int  not null,
    IdSede int  not null,
    IdTipoContrato int  not null,      
    ModoPago varchar(20) check (ModoPago IN ('Quincenal','Mensual')) not null,
    SueldoBase decimal(10,2) not null,  
    FechaInicio date not null,
    FechaFin date null,               
    FechaRenuncia date null,          
    MotivoRenuncia varchar(250) null, 
    Estado varchar(20) default 'Vigente',             
    constraint  FK_Contrato_Empleado foreign key (IdEmpleado) references Empleados(IdEmpleado),
    constraint  FK_Contrato_Puesto foreign key (IdPuesto) references Puestos(IdPuesto),
    constraint  FK_Contrato_Sede foreign key (IdSede) references Sedes(IdSede),
    constraint  FK_Contrato_TipoContrato foreign key (IdTipoContrato) references TiposContrato(IdTipoContrato)
)
go

create table PeriodosNomina (
    IdPeriodo int identity(1,1) primary key,
    NombrePeriodo varchar(20) unique not null,    
	ModoPago varchar(20) check (ModoPago IN ('Quincenal','Mensual')) not null,
    FechaInicio date not null,
    FechaFin date not null,
    DiasHabiles int  not null,                     
    Estado varchar(20) default 'Abierto' check (Estado IN ('Abierto','En proceso','Terminada','Cerrado')),
    FechaCierre date null
)
go

create table Asistencias (
    IdAsistencia int identity(1,1) primary key,
    IdEmpleado int  not null,
    Fecha date not null,
    HorasTrabajadas decimal(5,2) default 0,
    HorasExtras decimal(5,2) default 0,
    HorasNocturnas decimal(5,2) default 0,
    EsFeriado bit default 0,
    Asistio bit default 1,
	IdPeriodo int  not null,
    constraint  FK_Asistencia_Periodo foreign key (IdPeriodo) references PeriodosNomina(IdPeriodo),
    constraint  FK_Asistencia_Empleado foreign key (IdEmpleado) references Empleados(IdEmpleado)
)
go

create table Usuarios (
    IdUsuario int identity(1,1) primary key,
    NombreUsuario varchar(50) not null unique,
    ClaveHash VARBINARY(256) not null,         
    NombreCompleto varchar(150) not null,
    Rol varchar(50) not null,
    Estado varchar(20) default 'Activo',
    FechaRegistro datetime2 default sysdatetime()
)
go

create table Nominas (
    IdNomina int identity(1,1) primary key,
    IdPeriodo int  not null,
    ProcesadoPor int  not null,                      
    FechaProcesado datetime2 default sysdatetime(),
    Estado varchar(20) default 'Procesada' check (Estado IN ('Procesada','Cerrada','Anulada')),
    CerradoPor int  null,                           
    FechaCierre datetime2 null,
    AnuladoPor int  null,                           
    FechaAnulacion datetime2 null,
    MotivoAnulacion varchar(250) null,
    constraint  FK_Nomina_Periodo foreign key (IdPeriodo) references PeriodosNomina(IdPeriodo),
    constraint  FK_Nomina_ProcesadoPor foreign key (ProcesadoPor) references Usuarios(IdUsuario),
    constraint  FK_Nomina_CerradoPor foreign key (CerradoPor) references Usuarios(IdUsuario),
    constraint  FK_Nomina_AnuladoPor foreign key (AnuladoPor) references Usuarios(IdUsuario)
)
go

create table DetalleNomina (
    IdDetalleNomina int identity(1,1) primary key,
    IdPeriodo int  not null,
    IdContrato int  not null,
    IdEmpleado int  not null,    
	IdNomina int  not null,
    DiasTrabajados int  not null,
    SueldoBase decimal(12,2) not null,      
    SueldoPeriodo decimal(12,2) not null,   
    SalarioHora decimal(12,4) not null,     
    HorasExtras decimal(10,2) default 0,    
    PagoHorasExtras decimal(12,2) default 0,
    HorasNocturnas decimal(10,2) default 0,
    RecargoNocturno decimal(12,2) default 0,
    DiasFeriadosTrabajados int  default 0,
    PagoFeriado decimal(12,2) default 0,  
    AsignacionFamiliar decimal(12,2) default 0,           
    Gratificacion decimal(12,2) default 0,                
    BonificacionExtraordinaria decimal(12,2) default 0,    
    TotalUltimaGratificacion decimal(12,2) default 0,      
    RemuneracionComputable decimal(12,2) default 0,
    TotalIngresos decimal(12,2) not null,                  
    IngresosAcumuladosAno decimal(14,2) default 0,        
    MesesRestantesAno int  default 0,                      
    TotalIngresosProyectadosAnual decimal(14,2) default 0,
    MontoImponibleAnual decimal(14,2) default 0,           
    MontoImponiblePeriodo decimal(12,2) default 0,        
    ImpuestoAnual decimal(14,2) default 0,                 
    RentaQuintaMensual decimal(12,2) default 0,
    SueldoAsegurable decimal(12,2) default 0,              
    AporteONP decimal(12,2) default 0,                     
    AporteAFP decimal(12,2) default 0,                     
    PrimaSeguroAFP decimal(12,2) default 0,                
    ComisionAFP decimal(12,2) default 0,                  
    TotalDescuentos decimal(12,2) not null, 
    EsSalud decimal(12,2) default 0,                       
    CTS decimal(12,2) default 0,                           
    TotalAportesEmpleador decimal(12,2) default 0,  
    SueldoNeto decimal(12,2) not null,    
    AplicaGratificacion bit default 0,
    AplicaCTS bit default 0,
    Mes int  not null,                                      
    Anio int  not null,
    FechaProcesado datetime2 default sysutcdatetime(),
    constraint  FK_DetalleNomina_Nomina foreign key (IdNomina) references Nominas(IdNomina),
    constraint  FK_DetalleNomina_Periodo foreign key (IdPeriodo) references PeriodosNomina(IdPeriodo),
    constraint  FK_DetalleNomina_Contrato foreign key (IdContrato) references Contratos(IdContrato),
    constraint  FK_DetalleNomina_Empleado foreign key (IdEmpleado) references Empleados(IdEmpleado)
)
go




