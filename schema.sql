-- CREACION DE LA BASE DE DATOS GRUPO 3

create schema GP03;
use gp03;
CREATE TABLE usuario (
    numCuenta INT PRIMARY KEY UNIQUE auto_increment,
    u_nombre VARCHAR(255),
    u_apellido VARCHAR(255),
    u_genero VARCHAR(10),
    u_contraseña VARCHAR(255),
    u_email VARCHAR(255) UNIQUE,
    u_fechaNacimiento DATE,
    u_LugarNacimiento VARCHAR(255),
    u_PaisResidencia VARCHAR(255),
    u_Biografia TEXT,
    u_nacionalidad VARCHAR(255),
    u_fechaRegistro DATETIME
);

CREATE TABLE testADN(
    idADN INT PRIMARY KEY UNIQUE auto_increment,
    resumenADN VARCHAR(1000),
    estimacionEtnica VARCHAR(1000),
    mapaEtnico VARCHAR(1000),
    numCuenta  INT FOREING KEY REFERENCES usuario(numCuenta)
);

CREATE TABLE Familiar (
    IdFamiliar INT PRIMARY KEY,
    f_Género VARCHAR(10),
    f_Nombre VARCHAR(255),
    f_Apellido VARCHAR(255),
    f_FechaNacimiento DATE,
    f_Defunción VARCHAR(20),
    f_Biografía TEXT,
    f_Nacionalidad VARCHAR(255),
    f_CorreoElectrónico VARCHAR(255),
    f_Dirección VARCHAR(255),
    f_Ciudad VARCHAR(255),
    f_Religión VARCHAR(255),
    f_País VARCHAR(255),
    f_Teléfono VARCHAR(20),
    f_Ocupación VARCHAR(255),
    f_Educación VARCHAR(255),
    IdArbol INT NOT NULL,
    num_Cuenta INT,
    FOREIGN KEY (IdArbol) REFERENCES Arbol(IdArbol),
    FOREIGN KEY (num_Cuenta) REFERENCES Usuario(num_Cuenta)
);