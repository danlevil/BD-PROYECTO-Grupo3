-- CREACION DE LA BASE DE DATOS GRUPO 3

create schema GP03;
use gp03;
CREATE TABLE usuario (
    numCuenta INT PRIMARY KEY UNIQUE auto_increment not null,
    u_nombre VARCHAR(255) not null,
    u_apellido VARCHAR(255) not null,
    u_genero VARCHAR(10),
    u_contraseña VARCHAR(255) not null,
    u_email VARCHAR(255) UNIQUE not null,
    u_fechaNacimiento DATE,
    u_LugarNacimiento VARCHAR(255),
    u_PaisResidencia VARCHAR(255),
    u_Biografia TEXT,
    u_fechaRegistro DATETIME not null
);

CREATE TABLE Arbol (
	IdArbol int primary key unique not null auto_increment,
    nombreArbol varchar(255)
);
CREATE TABLE testADN(
    idADN INT PRIMARY KEY UNIQUE auto_increment,
    resumenADN VARCHAR(1000),
    estimacionEtnica VARCHAR(1000),
    mapaEtnico VARCHAR(1000),
    numCuenta  INT ,
    FOREIGn KEY (numCuenta) REFERENCES usuario(numCuenta)
        on delete cascade
);



CREATE TABLE PAISES(
	codigoPais int primary key auto_increment not null unique,
    nombrePais varchar(100)
);
CREATE TABLE DIRECCIONES(
	codigoDireccion int primary key auto_increment not null,
    calle varchar(255),
    numeroCalle int
);
CREATE TABLE ubicaciones(
	codigoUbicacion int primary key auto_increment not null,
    pais int,
    direccion int,
    foreign key (pais) references PAISES(codigoPais)
        on delete cascade,
    foreign key (direccion) references DIRECCIONES(codigoDireccion)
        on delete cascade
);

CREATE TABLE Sitio(
	IdSitio int primary key unique not null auto_increment,
    nombreSitio varchar(255),
    Dueño int,
    IdArbol int,
    foreign key (IdArbol) references Arbol(IdArbol)
        on delete cascade,
    foreign key (Dueño) references usuario(numCuenta)
        on delete cascade
);

create table sitiosColaboradores(
	IdSitio int,
    colaborador int,
    foreign key (IdSitio) references Sitio(IdSitio)
        on delete cascade,
    foreign key (colaborador) references usuario(numCuenta)
        on delete cascade
);
CREATE TABLE Familiar (
    IdFamiliar INT PRIMARY KEY auto_increment not null unique,
    f_Género VARCHAR(10),
    f_Nombre VARCHAR(255),
    f_Apellido VARCHAR(255),
    f_FechaNacimiento DATE,
    f_Defunción VARCHAR(20),
    f_Biografía TEXT,
    f_CorreoElectrónico VARCHAR(255),
    f_Religión VARCHAR(255),
    f_Teléfono VARCHAR(20),
    f_Ocupación VARCHAR(255),
    f_Educación VARCHAR(255),
    f_ubicacion int,
    IdArbol INT NOT NULL,
    numCuenta INT,
    FOREIGN KEY (IdArbol) REFERENCES Arbol(IdArbol)
        on delete cascade,
    FOREIGN KEY (numCuenta) REFERENCES Usuario(numCuenta)
        on delete cascade,
    FOREIGN KEY (f_ubicacion) REFERENCES ubicaciones(codigoUbicacion)
        on delete cascade
);
create table padres (
	idPadres int auto_increment primary key not null unique,
    padre int,
    madre int,
    hijo int,
    foreign key (padre) references familiar(IdFamiliar),
    foreign key (madre) references familiar(IdFamiliar),
    foreign key (hijo)  references familiar(IdFamiliar)
);
create table hermanos(
	idHermanos int auto_increment primary key not null unique,
    hermanos int,
    familiar int,
    foreign key (hermanos) references familiar(IdFamiliar),
    foreign key (familiar) references familiar(IdFamiliar)
);
create table parejas(
	idParejas int auto_increment primary key not null unique,
    pareja int,
    familiar int,
    foreign key (pareja) references familiar(IdFamiliar),
    foreign key (familiar) references familiar(IdFamiliar)
);
create table hijo(
	idHijo int auto_increment primary key not null unique,
    hijo int,
    familiar int,
    foreign key (hijo) references familiar(IdFamiliar),
    foreign key (familiar) references familiar(IdFamiliar)
);
CREATE TABLE Graficos(
	ID_grafico int primary key unique auto_increment not null,
	tipoGrafico varchar(255),
	estilo varchar(255),
	IdArbol int,
    foreign key (IdArbol) references Arbol(IdArbol)
		ON DELETE cascade
);
