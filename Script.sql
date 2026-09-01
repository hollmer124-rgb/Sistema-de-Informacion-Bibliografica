CREATE DATABASE SistemaInformacionBibliografica
GO

USE SistemaInformacionBibliografica

GO


CREATE TABLE TipoPublicacion(
	Id INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(200) NULL,

	CONSTRAINT pkTipoPublicacion PRIMARY KEY(Id)
)
GO
CREATE UNIQUE INDEX ixTipoPublicacion_Nombre ON TipoPublicacion(Nombre)
GO




CREATE TABLE UbicacionGeografica(
	Id INT IDENTITY(1,1) NOT NULL,
	Pais VARCHAR(100) NOT NULL,
	Departamento VARCHAR(100) NULL,
	Ciudad VARCHAR(100) NOT NULL,

	CONSTRAINT pkUbicacionGeografica PRIMARY KEY(Id)
)
GO




CREATE TABLE Editorial(
	Id INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(150) NOT NULL,
	Telefono VARCHAR(30) NULL,
	Correo VARCHAR(100) NULL,
	Direccion VARCHAR(150) NULL,
	IdUbicacion INT NOT NULL,

	CONSTRAINT pkEditorial PRIMARY KEY(Id),
	CONSTRAINT fkEditorial_Ubicacion FOREIGN KEY(IdUbicacion) REFERENCES UbicacionGeografica(Id)
)
GO

CREATE UNIQUE INDEX ixEditorial_Nombre ON Editorial(Nombre)
GO




CREATE TABLE Autor(
	Id INT IDENTITY(1,1) NOT NULL,
	TipoAutor VARCHAR(30) NOT NULL,
	Nombres VARCHAR(100) NULL,
	Apellidos VARCHAR(100) NULL,
	NombreCorporativo VARCHAR(150) NULL,

	CONSTRAINT pkAutor PRIMARY KEY(Id)
)
GO




CREATE TABLE Serie(
	Id INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(150) NOT NULL,
	Periodicidad VARCHAR(50) NULL,

	CONSTRAINT pkSerie PRIMARY KEY(Id)
)
GO

CREATE UNIQUE INDEX ixSerie_Nombre ON Serie(Nombre)
GO




CREATE TABLE Volumen(
	Id INT IDENTITY(1,1) NOT NULL,
	Numero INT NOT NULL,
	FechaInicio DATE NULL,
	FechaFin DATE NULL,
	IdSerie INT NOT NULL,

	CONSTRAINT pkVolumen PRIMARY KEY(Id),
	CONSTRAINT fkVolumen_Serie FOREIGN KEY(IdSerie) REFERENCES Serie(Id)
)
GO

CREATE UNIQUE INDEX ixVolumen_Numero ON Volumen(IdSerie, Numero)
GO



CREATE TABLE Descriptor(
	Id INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,

	CONSTRAINT pkDescriptor PRIMARY KEY(Id)
)
GO

CREATE UNIQUE INDEX ixDescriptor_Nombre ON Descriptor(Nombre)
GO




CREATE TABLE Publicacion(
	Id INT IDENTITY(1,1) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	Subtitulo VARCHAR(200) NULL,
	FechaPublicacion DATE NULL,
	ISBN VARCHAR(30) NULL,
	ISSN VARCHAR(30) NULL,
	Idioma VARCHAR(50) NULL,
	NumeroPaginas INT NULL,

	IdTipoPublicacion INT NOT NULL,
	IdEditorial INT NOT NULL,
	IdSerie INT NULL,
	IdVolumen INT NULL,

	CONSTRAINT pkPublicacion PRIMARY KEY(Id),

	CONSTRAINT fkPublicacion_TipoPublicacion FOREIGN KEY(IdTipoPublicacion) REFERENCES TipoPublicacion(Id),

	CONSTRAINT fkPublicacion_Editorial FOREIGN KEY(IdEditorial) REFERENCES Editorial(Id),

	CONSTRAINT fkPublicacion_Serie FOREIGN KEY(IdSerie) REFERENCES Serie(Id),

	CONSTRAINT fkPublicacion_Volumen FOREIGN KEY(IdVolumen) REFERENCES Volumen(Id)
)
GO

CREATE INDEX ixPublicacion_Titulo ON Publicacion(Titulo)
GO




CREATE TABLE PublicacionAutor(
	IdPublicacion INT NOT NULL,
	IdAutor INT NOT NULL,

	CONSTRAINT pkPublicacionAutor PRIMARY KEY(IdPublicacion, IdAutor),

	CONSTRAINT fkPublicacionAutor_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),

	CONSTRAINT fkPublicacionAutor_Autor FOREIGN KEY(IdAutor) REFERENCES Autor(Id)
)
GO




CREATE TABLE PublicacionDescriptor(
	IdPublicacion INT NOT NULL,
	IdDescriptor INT NOT NULL,

	CONSTRAINT pkPublicacionDescriptor PRIMARY KEY(IdPublicacion, IdDescriptor),

	CONSTRAINT fkPublicacionDescriptor_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),

	CONSTRAINT fkPublicacionDescriptor_Descriptor FOREIGN KEY(IdDescriptor) REFERENCES Descriptor(Id)
)
GO