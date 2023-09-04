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
call eliminarArboles(5,31 ,@msj);
select @msj;
drop procedure eliminarArboles;