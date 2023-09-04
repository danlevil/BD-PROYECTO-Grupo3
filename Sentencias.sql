use gp03;
/*
1) Eliminar un arbol
	Si el usuario es colaborador NO puede eliminar ese arbol
    Si el usuario es dueño       SÍ puede eliminar ese arbol.
*/
DELIMITER //
CREATE PROCEDURE eliminarArboles (IN idUsuario INT, IN Arbol INT , OUT msj VARCHAR(255))
    BEGIN
		Declare condicion int;
        select IdSitio into condicion  from sitio where Dueño=idUsuario and IdArbol=Arbol;
        if ( condicion is NULL) then
			set msj= "No es dueño de ese arbol no lo puede eliminar";
            select msj;
		else 
			Delete from arbol where  IdArbol= Arbol;
            select * from arbol;
		end if;
    
    END //
DELIMITER ;
call eliminarArboles(5,5 ,@msj);

/*
2)Muestra los miembros de un determinado arbol que hayan nacido en el año especificado
*/
DELIMITER //
CREATE PROCEDURE buscarFamiliares (IN Arbol INT, IN anio INT)
	BEGIN
		SELECT f_Nombre, f_Apellido
		FROM Familiar
		WHERE IdArbol = Arbol AND year(f_FechaNacimiento) = anio;
	END //
DELIMITER ;	
call buscarFamiliares(30,1990);

/*
3) Agregar un nuevo usuario
	Se crea un nuevo registro en usuarios
    Automaticamente se crea un arbol y un sitio
*/
DELIMITER //
CREATE TRIGGER AgregarArbolYSitio
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    DECLARE nuevoId INT;
    INSERT INTO Arbol (nombreArbol) VALUES (CONCAT('Arbol de ', NEW.u_nombre));
    SET nuevoId = LAST_INSERT_ID();
    INSERT INTO Sitio (nombreSitio, Dueño, IdArbol) VALUES (CONCAT('Sitio de ', NEW.u_nombre), NEW.numCuenta, nuevoId);
END;
//
DELIMITER ;

INSERT INTO usuario (u_nombre, u_apellido, u_genero, u_contraseña, u_email, u_fechaNacimiento, u_LugarNacimiento, u_PaisResidencia, u_Biografia,  u_fechaRegistro)
VALUES ('Daniel', 'Villamar', 'Masculino', 'mi_contraseña', 'dan@example.com', '2002-05-15', null, 'Ecuador', 'Biografía DV',  NOW());

SELECT * FROM gp03.usuario;

/*
4)Mostrar información basica de cada arbol:
	Numero de colaboradores
    Numero de Familiares que pertenecen al arbol
*/
select distinct s.IdSitio, s.nombreSitio as Nombre_del_sitio, count( T.colaborador) colaboradores_en_ese_arbol ,
(select count(IdArbol) from familiar as f where f.IdArbol= s.IdArbol)as Numero_de_Familiares
from sitio as s
left join sitioscolaboradores as T ON s.IdSitio=T.IdSitio
group by s.IdSitio;

/*
5)Agregar un hermano a un familiar con una verificacion.
*/
DELIMITER //
CREATE PROCEDURE InsertarHermano(
    IN hermano_id INT,
    IN familiar_id INT,
    OUT msj VARCHAR(255)
)
BEGIN
	IF(hermano_id <> familiar_id) then
		INSERT INTO hermanos (hermanos, familiar)
		VALUES (hermano_id, familiar_id);
	Else 
		Set msj= "Una persona no puede ser su propio hermano";
        select msj;
	END IF;
END;
//
DELIMITER ;
INSERT INTO Familiar (f_Género, f_Nombre, f_Apellido, f_FechaNacimiento, f_Defunción, f_Biografía, f_CorreoElectrónico, f_Religión, f_Teléfono, f_Ocupación, f_Educación, f_ubicacion, IdArbol, numCuenta)
VALUES ('Masculino', 'Juana', 'Pazmiño', '2000-05-15', NULL, 'Biografía de Juan Pérez', 'juan@example.com', 'Cristiana', null, 'Ingeniero', 'Licenciado en Informática', 1, 1, 123456);
INSERT INTO Familiar (f_Género, f_Nombre, f_Apellido, f_FechaNacimiento, f_Defunción, f_Biografía, f_CorreoElectrónico, f_Religión, f_Teléfono, f_Ocupación, f_Educación, f_ubicacion, IdArbol, numCuenta)
VALUES ('Femenino', 'María Belen', 'Carrasco', '2001-08-20', NULL, 'Biografía de María González', 'maria@example.com', null , '+9876543210', 'Médica', 'Doctora en Medicina', 2, 2, 654321);

call InsertarHermano(32,32, @msj);