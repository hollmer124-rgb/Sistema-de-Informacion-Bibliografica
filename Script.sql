CREATE DATABASE SistemaInformacionBibliografica
GO

USE SistemaInformacionBibliografica
GO


CREATE TABLE Pais(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CodigoAlfa VARCHAR(5) NULL,
	Indicativo INT NULL,
	CONSTRAINT pkPais PRIMARY KEY (Id)
)
GO

CREATE UNIQUE INDEX ixPais_Nombre
	ON Pais(Nombre)
GO

CREATE TABLE Region(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT pkRegion PRIMARY KEY (Id),
	CONSTRAINT fkRegion_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)
GO

CREATE UNIQUE INDEX ixRegion_Nombre
	ON Region(IdPais, Nombre)
GO

CREATE TABLE Ciudad(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdRegion INT NOT NULL,
	CONSTRAINT pkCiudad PRIMARY KEY (Id),
	CONSTRAINT fkCiudad_Region FOREIGN KEY (IdRegion) REFERENCES Region(Id)
)
GO

CREATE UNIQUE INDEX ixCiudad_Nombre
	ON Ciudad(IdRegion, Nombre)
GO


CREATE TABLE Editorial(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Telefono VARCHAR(20) NULL,
	Correo VARCHAR(100) NULL,
	IdCiudad INT NOT NULL,
	CONSTRAINT pkEditorial PRIMARY KEY (Id),
	CONSTRAINT fkEditorial_Ciudad FOREIGN KEY (IdCiudad) REFERENCES Ciudad(Id)
)
GO

CREATE UNIQUE INDEX ixEditorial_Nombre
	ON Editorial(Nombre)
GO

CREATE TABLE Autor(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	TipoAutor VARCHAR(50) NULL,
	CONSTRAINT pkAutor PRIMARY KEY (Id)
)
GO

CREATE INDEX ixAutor_Nombre
	ON Autor(Nombre)
GO

CREATE TABLE TipoPublicacion(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoPublicacion PRIMARY KEY (Id)
)
GO

CREATE UNIQUE INDEX ixTipoPublicacion_Nombre
	ON TipoPublicacion(Nombre)
GO


CREATE TABLE Publicacion(
	Id INT IDENTITY(1, 1) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	FechaPublicacion DATE NULL,
	ISBN VARCHAR(20) NULL,
	ISSN VARCHAR(20) NULL,
	Edicion VARCHAR(50) NULL,
	IdEditorial INT NOT NULL,
	IdTipoPublicacion INT NOT NULL,
	CONSTRAINT pkPublicacion PRIMARY KEY (Id),
	CONSTRAINT fkPublicacion_Editorial FOREIGN KEY (IdEditorial) REFERENCES Editorial(Id),
	CONSTRAINT fkPublicacion_TipoPublicacion FOREIGN KEY (IdTipoPublicacion) REFERENCES TipoPublicacion(Id)
)
GO

CREATE INDEX ixPublicacion_Titulo
	ON Publicacion(Titulo)
GO

CREATE TABLE Volumen(
	Id INT IDENTITY(1, 1) NOT NULL,
	Numero INT NOT NULL,
	FechaPublicacion DATE NULL,
	IdPublicacion INT NOT NULL,
	CONSTRAINT pkVolumen PRIMARY KEY (Id),
	CONSTRAINT fkVolumen_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id)
)
GO


CREATE TABLE Descriptor(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(MAX) NULL,
	CONSTRAINT pkDescriptor PRIMARY KEY (Id)
)
GO

CREATE UNIQUE INDEX ixDescriptor_Nombre
	ON Descriptor(Nombre)
GO


CREATE TABLE PublicacionAutor(
	IdAutor INT NOT NULL,
	IdPublicacion INT NOT NULL,
	CONSTRAINT pkPublicacionAutor PRIMARY KEY(IdAutor, IdPublicacion),
	CONSTRAINT fkPublicacionAutor_Autor FOREIGN KEY (IdAutor) REFERENCES Autor(Id),
	CONSTRAINT fkPublicacionAutor_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id)
)
GO

CREATE TABLE PublicacionDescriptor(
	IdPublicacion INT NOT NULL,
	IdDescriptor INT NOT NULL,
	CONSTRAINT pkPublicacionDescriptor PRIMARY KEY(IdPublicacion, IdDescriptor),
	CONSTRAINT fkPublicacionDescriptor_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
	CONSTRAINT fkPublicacionDescriptor_Descriptor FOREIGN KEY (IdDescriptor) REFERENCES Descriptor(Id)
)
GO