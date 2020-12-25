/*=========================================PROCEDIMENTALES=====================================*/

/*YA TODOS LOS TRIGGER EXCEPTO UNO CORREN FULL*/

/*Mantener Pieza*/

/*El numero maximo de piezas que se pueden solicitar es 50*/
CREATE OR REPLACE TRIGGER Maximos_tubos
BEFORE INSERT ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :NEW.cantidad_piezas > 50 THEN
		RAISE_APPLICATION_ERROR(-20001,'El Numero maximo de piezas que se pueden solicitar es 50');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO bodega VALUES('Bodega Central', 'Villavicencio', 'Meta');
INSERT INTO pedido_pieza VALUES(1548578,'Pozos Petroleros', 25, 'Aceptado', 'Bodega Central', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/19', 'yyyy/mm/dd') );
/*DisparadorNoOK*/
INSERT INTO bodega VALUES('Bodega San Juan 3', 'Villavicencio', 'Meta');
INSERT INTO pedido_pieza VALUES(6565321, 'Pozos Petroleros', 51, 'Aceptado', 'Bodega San Juan 3', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/19', 'yyyy/mm/dd'));
/*XDisparador*/
DROP TRIGGER Maximos_tubos;



/*El numero de pedido se genera automaticamente y empieza en 1*/
CREATE OR REPLACE TRIGGER Id_Pedido
BEFORE INSERT ON pedido_pieza
FOR EACH ROW
DECLARE x INTEGER;	
BEGIN
	IF :New.numero_pedido IS NULL THEN
       :NEW.numero_pedido := 1;
	ELSE
        SELECT MAX(numero_pedido) INTO x FROM pedido_pieza;
		:NEW.numero_pedido := x+1;
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO pedido_pieza VALUES(NULL, 'Pozos Petroleros', 49, 'Aceptado', 'Bodega San Juan 3', TO_DATE('2020/11/25', 'yyyy/mm/dd'),TO_DATE('2020/11/29', 'yyyy/mm/dd'));
/*NO se puede tener disparadorNoOk en este trigger puesto que este es un trigger autoincremental, osea no tiene un caso de fallo*/
/*XDisparador*/
DROP TRIGGER Id_pedido;



/*solo se pueden actualizar pedidos si no estan aceptados*/
CREATE OR REPLACE TRIGGER Actualizacion_pedidos
BEFORE UPDATE ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :OLD.estado = 'Aceptado' THEN
		RAISE_APPLICATION_ERROR(-20002,'Solo se pueden actualizar pedidos si no estan aceptados');
	END IF;
END;
/
/*DisparadorOk*/	
INSERT INTO pedido_pieza VALUES(858562, 'Pozos Petroleros',48, 'No Aceptados', NULL, NULL, NULL);
UPDATE pedido_pieza SET estado = 'Aceptado', bodega_reclamo = 'Bodega Central' , fecha_pedido = TO_DATE('2020/11/25', 'yyyy/mm/dd') , fecha_llegada =  TO_DATE('2020/11/29', 'yyyy/mm/dd') WHERE pedido_pieza.numero_pedido = 858562;
/*DisparadorNoOK*/
INSERT INTO pedido_pieza VALUES(9565241, 'Pozos Petroleros', 30, 'Aceptado', 'Bodega Central', TO_DATE('2020/11/25', 'yyyy/mm/dd'),TO_DATE('2020/11/29', 'yyyy/mm/dd') );
UPDATE pedido_pieza SET estado = 'No Aceptado', bodega_reclamo = NULL , fecha_pedido = NULL , fecha_llegada = NULL WHERE pedido_pieza.numero_pedido = 9565241;
/*XDisparador*/
DROP TRIGGER Actualizacion_pedidos;




/*No se pueden eliminar pedidos Aceptados*/
CREATE OR REPLACE TRIGGER Eliminacion_Pedidos
BEFORE DELETE ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :OLD.estado = 'Aceptado' THEN
		RAISE_APPLICATION_ERROR(-20003,'No se pueden eliminar pedidos Aceptados');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO pedido_pieza VALUES(8585963, 'Pozos Petroleros', 38, 'No Aceptados', NULL, NULL, NULL);
DELETE FROM pedido_pieza WHERE pedido_pieza.numero_pedido = 8585963;
/*DisparadorNoOK*/
INSERT INTO pedido_pieza VALUES(3252410, 'Pozos Petroleros', 42, 'Aceptado', 'Bodega Central', TO_DATE('2020/11/25', 'yyyy/mm/dd'), TO_DATE('2020/11/27', 'yyyy/mm/dd'));
DELETE FROM pedido_pieza WHERE pedido_pieza.numero_pedido = 3252410;
/*XDisparador*/
DROP TRIGGER Eliminacion_Pedidos;



/*================================================================================================================================*/
/*Mantener Personal*/



/*No se puede actualizar el departamento de experiencia*/
/*No se puede actualizar el departamento de experiencia*/
CREATE OR REPLACE TRIGGER Actualizacion_dpto_experto
BEFORE UPDATE ON experto
FOR EACH ROW
BEGIN
	IF NOT(:New.departamento_experiencia = 'Pozos Petroleros') THEN
		RAISE_APPLICATION_ERROR(-20004,'No se puede actualizar el departamento de experiencia');            
	END IF;                                                                                                
END;
/

/*DisparadorOk*/
INSERT INTO empleado VALUES('Diego','Chicuazuque','E001566','TECNICO ERA 1','diego.chicuazuque@petrolinventories.com.co','3118654069','<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E0009856</Jefe_dpto>
	<Jefe_ingeniero>E0003255</Jefe_ingeniero>
	<Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>', '5262305888');
INSERT INTO experto VALUES('E001566','Pozos Petroleros');
UPDATE experto SET id = 'E001999', departamento_experiencia = 'Pozos Petroleros' WHERE experto.id = 'E001566';

/*DisparadorNoOK*/
INSERT INTO empleado VALUES('Luisa','Castellanos','E001958','TECNICO ERA 1','luisa.castellanos@petrolinventories.com.co','3153225895','<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E0009856</Jefe_dpto>
	<Jefe_ingeniero>E0003255</Jefe_ingeniero>
	<Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>', '6589524881');
INSERT INTO experto VALUES('E001958','Pozos Petroleros');
UPDATE experto SET id = 'E001466', departamento_experiencia = 'Corporativos' WHERE experto.id = 'E001958';

/*XDisparador*/
DROP TRIGGER Actualizacion_dpto_experto;


/*======================================MANTENER INVENTARIO===============================================*/

/*No pueden haber mas de 5 bodegas por departamento*/

CREATE OR REPLACE TRIGGER Nro_Bodegas
BEFORE INSERT ON bodega
FOR EACH ROW
DECLARE x NUMBER;                                              
BEGIN
	SELECT COUNT(bodega.departamento) INTO x
	FROM bodega;
	IF x >= 5 THEN
		RAISE_APPLICATION_ERROR(-20005,'No pueden haber mas de 5 bodegas por departamento');
	END IF;
END;
/

DELETE FROM bodega;
/*DisparadorOk*/
insert into bodega  values ('Bodega San Martin', 'Acacias', 'Meta');
insert into bodega  values ('Bodega La Esperanza', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega Chichimene 1', 'Acacias', 'Meta');
insert into bodega  values ('Bodega San Juan 3', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega Central', 'Funza', 'Cundinamarca');

DELETE FROM bodega;
/*DisparadorNoOK*/
insert into bodega  values ('Bodega San Isidro', 'Acacias', 'Cesar');
insert into bodega  values ('Bodega San Esperancita', 'Villavicencio', 'Cesar');
insert into bodega  values ('Bodega San Pedro', 'Acacias', 'Cesar');
insert into bodega  values ('Bodega San Juan 6', 'Villavicencio', 'Cesar');
insert into bodega  values ('Bodega Central 3', 'Mesetas', 'Cesar');
insert into bodega  values ('Bodega San Fernando', 'Guamal', 'Cesar');



/*No se puede actualizar la ubicacion de la bodega*/
CREATE OR REPLACE TRIGGER Ubicacion_bodega
BEFORE UPDATE ON bodega
FOR EACH ROW
BEGIN
	IF :NEW.departamento != :OLD.departamento OR :NEW.municipio != :OLD.municipio THEN
		RAISE_APPLICATION_ERROR(-20006,'No se puede actualizar la ubicacion de la bodega');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO bodega VALUES('Bodega 13', 'Cajicá', 'Cundinamarca');
UPDATE bodega SET nombre_bodega = 'Bodega 14', municipio = 'Cajicá', departamento = 'Cundinamarca' WHERE bodega.nombre_bodega = 'Bodega 13';

/*DisparadorNoOK*/
INSERT INTO bodega VALUES('Bodega la 25', 'Funza', 'Cundinamarca');
UPDATE bodega SET  municipio = 'Yopal', departamento = 'Casanare' WHERE bodega.nombre_bodega = 'Bodega la 25';

/*XDisparador*/
DROP TRIGGER Ubicacion_bodega;



/*No se puede eliminar un inventario si no hay disponibilad 0*/
CREATE OR REPLACE TRIGGER Eliminacion_Inventario
BEFORE DELETE ON inventario
FOR EACH ROW
BEGIN
	IF :OLD.disponibilidad > 0 THEN
		RAISE_APPLICATION_ERROR(-20007,'No se puede eliminar un inventario si no hay disponibilad 0');
	END IF;
END;
/

/*DisparadorOk*/
INSERT INTO bodega VALUES('Bodega Chichimene', 'Chichimene', 'Meta');
INSERT INTO inventario VALUES('Bodega Chichimene', 'CHI356', 0);
DELETE FROM inventario WHERE inventario.id_inventarios = 'CHI356';

/*DisparadorNoOK*/
INSERT INTO bodega VALUES('Bodega Centra', 'Bogotá', 'Cundinamarca');
INSERT INTO inventario VALUES('Bodega Central', 'CEN420', 25);
DELETE FROM inventario WHERE inventario.id_inventarios = 'CEN420';

/*XDisparador*/
DROP TRIGGER Eliminacion_Inventario;




/*======================REGISTRAR PIEZA===========================*/

/*El codigo de los proveedores se genera automaticamente*/
CREATE OR REPLACE TRIGGER Codigo_Proveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
DECLARE x NUMBER; 
BEGIN
	SELECT MAX(TO_NUMBER(SUBSTR(codigo,4)))INTO x     /*Dejarselo a Forero el de registrar piezas*/
	FROM proveedor;
	IF x is NULL THEN
		:NEW.codigo := 'PROV';                                 
	ELSE
		:NEW.codigo := 'PROV'|| TO_CHAR(x+1);
    END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/
/*XDisparador*/
DROP TRIGGER Codigo_Proveedor;



/*No se puede eliminar una empresa que provee a una bodega*/
CREATE OR REPLACE TRIGGER E_P_Bodega
BEFORE DELETE ON empresa
FOR EACH ROW
DECLARE 
numBodegas NUMBER;
BEGIN
	SELECT COUNT(codigo_proveedor) INTO numBodegas FROM provee
	WHERE :OLD.codigo = Provee.codigo_proveedor;
	IF numBodegas > 0 THEN 
		RAISE_APPLICATION_ERROR(-25617,'No se puede eliminar una empresa que provee a una bodega');
	END IF;
END;
/
/*DisparadorOk*/


/*DisparadorNoOK*/      
       
	   
/*XDisparador*/
DROP TRIGGER E_P_Bodega;