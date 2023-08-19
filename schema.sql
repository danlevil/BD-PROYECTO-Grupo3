-- CREACION DE LA BASE DE DATOS GRUPO 3

create schema GP03;
use gp03;
CREATE TABLE usuario (
    num_Cuenta INT PRIMARY KEY UNIQUE auto_increment,
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