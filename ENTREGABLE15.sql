/*Eliminar datos*/
DELETE FROM proveedor;

DELETE FROM persona_natural;

DELETE FROM empresa;

DELETE FROM provee;

DELETE FROM bodega;

DELETE FROM inventario;

DELETE FROM contiene;

DELETE FROM empleado_directo;

DELETE FROM empleado;

DELETE FROM experto;

DELETE FROM estado;

DELETE FROM permiso;

DELETE FROM pedido_pieza;

DELETE FROM pieza_extraccion_petrolera;

DELETE FROM revisa;


/*ELIMINAR TABLAS*/

DROP TABLE contiene CASCADE CONSTRAINTS;

DROP TABLE empleado_directo CASCADE CONSTRAINTS;

DROP TABLE proveedor CASCADE CONSTRAINTS;

DROP TABLE persona_natural CASCADE CONSTRAINTS;

DROP TABLE empresa CASCADE CONSTRAINTS;

DROP TABLE provee CASCADE CONSTRAINTS;

DROP TABLE bodega CASCADE CONSTRAINTS;

DROP TABLE inventario CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE experto CASCADE CONSTRAINTS;

DROP TABLE estado CASCADE CONSTRAINTS;

DROP TABLE permiso CASCADE CONSTRAINTS;

DROP TABLE pedido_pieza CASCADE CONSTRAINTS;

DROP TABLE pieza_extraccion_petrolera CASCADE CONSTRAINTS;

DROP TABLE revisa CASCADE CONSTRAINTS;


/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo            VARCHAR(8) NOT NULL,
    telefono          VARCHAR(10) NOT NULL,
    correo            VARCHAR(250) NOT NULL,
    direccion         VARCHAR(100) NOT NULL,            /*Refactorizacion en creacion de tablas*/
    ciudad            VARCHAR(50) NOT NULL,				/*Se crean dos nuevas tablas (CONTIENE, EMPLEADO_DIRECTO)*/
    direccion_postal  VARCHAR(250),						/*7 atributos se crean de forma XMLTYPE*/
    años_experiencia  INTEGER NOT NULL
);

CREATE TABLE persona_natural (
    nombre            VARCHAR(50) NOT NULL,
    primer_apellido   VARCHAR(50) NOT NULL,
    segundo_apellido  VARCHAR(50) NOT NULL,
    cedula            VARCHAR(10) NOT NULL,
    codigo            VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre  VARCHAR(250) NOT NULL,
    nit     VARCHAR(10) NOT NULL,
    codigo  VARCHAR(8) NOT NULL
);

CREATE TABLE provee (
    codigo_proveedor   VARCHAR(8) NOT NULL,
    nombre_bodega      VARCHAR(100) NOT NULL
    
);
CREATE TABLE bodega (
    nombre_bodega        VARCHAR(100) NOT NULL,
    municipio            VARCHAR(100) NOT NULL,
    departamento         VARCHAR(100) NOT NULL
);

CREATE TABLE inventario (
    bodega_residencia       VARCHAR(100) NOT NULL,   
    id_inventarios          VARCHAR(6) NOT NULL,
    disponibilidad          NUMBER(7) NOT NULL
);

CREATE TABLE contiene (
	id_inventario    VARCHAR(100) NOT NULL,
	numero_pieza     NUMBER(6) NOT NULL
);

CREATE TABLE pieza_extraccion_petrolera (
    numero_serie   NUMBER(6) NOT NULL,
    tipo           VARCHAR(15) NOT NULL,
    dimensiones    XMLTYPE
);


CREATE TABLE revisa (
    id_empleado_directo  VARCHAR(7) NOT NULL,
    id_inventario        VARCHAR(6) NOT NULL
);

CREATE TABLE empleado_directo (
    id                        VARCHAR(7) NOT NULL,
    departamento_experiencia  VARCHAR(25) NOT NULL,
    planta_residencia         XMLTYPE
);

CREATE TABLE experto (
    id                         VARCHAR(7) NOT NULL,
    departamento_experiencia   XMLTYPE
);

CREATE TABLE empleado (
    nombre                 VARCHAR(100) NOT NULL,
    apellido               VARCHAR(100) NOT NULL,
    id                     VARCHAR(7) NOT NULL,
    cargo                  VARCHAR(100) NOT NULL,
    correo                 VARCHAR(250) NOT NULL,
    numero_telefonico      VARCHAR(20) NOT NULL,
    departamento_trabajo   XMLTYPE,
    cedula                 VARCHAR(10) NOT NULL
);

CREATE TABLE estado (
    numero_revision   NUMBER(7) NOT NULL,
    revisado_por      VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    calidad           VARCHAR(1) NOT NULL,
    observaciones     VARCHAR(500)
);

CREATE TABLE permiso (
    numero_permiso    NUMBER(7) NOT NULL,
    id_autor          VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    detalle           VARCHAR(250) NOT NULL,
    estado            VARCHAR(13) NOT NULL,
	fecha_permiso     DATE NOT NULL,
    pedido            NUMBER(7)
);

CREATE TABLE pedido_pieza (
    numero_pedido         NUMBER(7) NOT NULL,
    departamento_destino  VARCHAR(20) NOT NULL,
    cantidad_piezas       INTEGER NOT NULL,
    estado                VARCHAR(13) NOT NULL,
    bodega_reclamo        VARCHAR(100),
    fecha_pedido          DATE,
    fecha_llegada         DATE 
);



/*PRIMARY KEYS*/
ALTER TABLE empresa ADD CONSTRAINT pk_empresa_codigo PRIMARY KEY ( codigo );

ALTER TABLE persona_natural ADD CONSTRAINT pk_juridica_codigo PRIMARY KEY ( codigo );
 
ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_codigo PRIMARY KEY ( codigo );

ALTER TABLE provee ADD CONSTRAINT pk_provee_codigos PRIMARY KEY ( codigo_proveedor,
                                                                  nombre_bodega );

ALTER TABLE bodega ADD CONSTRAINT pk_bodega_nombre PRIMARY KEY ( nombre_bodega );                                     /*REFACTORIZACION PRIMARY KEYS*/
																													  /*Se generan las llaves primarias de las dos nuevas tablas creadas*/
ALTER TABLE inventario ADD CONSTRAINT pk_inventario_id PRIMARY KEY ( id_inventarios );

ALTER TABLE contiene ADD CONSTRAINT pk_contiene_ids PRIMARY KEY ( id_inventario,
                                                                  numero_pieza );

ALTER TABLE revisa ADD CONSTRAINT pk_revisa_inventario PRIMARY KEY ( id_inventario,
                                                                     id_empleado_directo );

ALTER TABLE pieza_extraccion_petrolera ADD CONSTRAINT pk_numero_extraccion PRIMARY KEY ( numero_serie );

ALTER TABLE pedido_pieza ADD CONSTRAINT pk_numero_pedido PRIMARY KEY ( numero_pedido );

ALTER TABLE permiso ADD CONSTRAINT pk_numero_permiso PRIMARY KEY ( numero_permiso );

ALTER TABLE empleado ADD CONSTRAINT pk_empleado_id PRIMARY KEY ( id );

ALTER TABLE experto ADD CONSTRAINT pk_experto_id PRIMARY KEY ( id );

ALTER TABLE empleado_directo ADD CONSTRAINT pk_empleado_directo_id PRIMARY KEY ( id );

ALTER TABLE estado ADD CONSTRAINT pk_estado_revision PRIMARY KEY ( numero_revision );


/*UNIQUE KEYS*/

ALTER TABLE persona_natural ADD CONSTRAINT uk_natural_cedula UNIQUE ( cedula );

ALTER TABLE persona_natural ADD CONSTRAINT uk_seg_apellido UNIQUE ( segundo_apellido );

ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nombre UNIQUE ( nombre );                                          /*REFACTORIZACION UNIQUE KEYS*/
																													  /*Se generan 2 llaves unicas nuevas*/
ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nit UNIQUE ( nit );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_telefono UNIQUE ( telefono );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_correo UNIQUE ( correo );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_direccion UNIQUE ( direccion );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_correo UNIQUE ( correo );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_telefono UNIQUE ( numero_telefonico );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_cedula UNIQUE ( cedula );



/*FOREIGN KEYS*/

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE persona_natural
    ADD CONSTRAINT fk_persona_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE provee
    ADD CONSTRAINT fk_provee_proveedor FOREIGN KEY ( codigo_proveedor )                              /*REFACTORIZACION FOREIGN KEYS*/ 
        REFERENCES proveedor ( codigo ); 															 /*Se generan las respectivas nuevas llaves para las dos nuevas tablas*/

ALTER TABLE inventario
    ADD CONSTRAINT fk_inventario_bodega FOREIGN KEY ( bodega_residencia )
        REFERENCES bodega ( nombre_bodega );

ALTER TABLE provee
    ADD CONSTRAINT fk_provee_bodega FOREIGN KEY ( nombre_bodega )
        REFERENCES bodega ( nombre_bodega );

ALTER TABLE empleado_directo
    ADD CONSTRAINT fk_directo_identificador FOREIGN KEY ( id )
        REFERENCES empleado ( id );

ALTER TABLE experto
    ADD CONSTRAINT fk_experto_identificador FOREIGN KEY ( id )
        REFERENCES empleado ( id );

ALTER TABLE revisa
    ADD CONSTRAINT fk_revisa_inventario FOREIGN KEY ( id_inventario )
        REFERENCES inventario ( id_inventarios );

ALTER TABLE revisa
    ADD CONSTRAINT fk_revisa_directo FOREIGN KEY ( id_empleado_directo )
        REFERENCES empleado_directo ( id );

ALTER TABLE estado
    ADD CONSTRAINT fk_estado_revisado FOREIGN KEY ( revisado_por )
        REFERENCES experto ( id );

ALTER TABLE estado
    ADD CONSTRAINT fk_estado_pieza FOREIGN KEY ( numero_pieza )
        REFERENCES pieza_extraccion_petrolera ( numero_serie );

ALTER TABLE permiso
    ADD CONSTRAINT fk_permiso_id_autor FOREIGN KEY ( id_autor )
        REFERENCES empleado ( id );

ALTER TABLE permiso
    ADD CONSTRAINT fk_permiso_pedido FOREIGN KEY ( pedido )
        REFERENCES pedido_pieza ( numero_pedido );

ALTER TABLE pedido_pieza
    ADD CONSTRAINT fk_pedido_bodega FOREIGN KEY ( bodega_reclamo )
        REFERENCES bodega ( nombre_bodega );
		
		
		
		
/*RESTRICCIONES ATRIBUTOS*/
ALTER TABLE proveedor
    ADD CONSTRAINT ck_correo_proveer CHECK ( correo LIKE '%@%'
                                             AND correo LIKE '%.com.co' ); /*Restriccion para correo de proveedor*/

ALTER TABLE proveedor
    ADD CONSTRAINT ck_telefono_proveedor CHECK ( substr(telefono, 1, 1) = '3'
                                       AND length(telefono) = 10 ); /*Restriccion para telefono de proveedor*/

ALTER TABLE persona_natural
    ADD CONSTRAINT ck_juridica_cedula CHECK ( length(cedula) = 10 ); /*Restriccion para cedula de persona natural */


ALTER TABLE persona_natural ADD CONSTRAINT ck_juridica_codigo CHECK ( codigo LIKE 'PROV%' ); /*Restriccion para codigo de persona natural*/

ALTER TABLE empresa
    ADD CONSTRAINT ck_empresa_nit CHECK ( length(nit) = 10 ); /*Restriccion para nit de la empresa*/

ALTER TABLE empresa ADD CONSTRAINT ck_empresa_codigo CHECK ( codigo LIKE 'PROV%' ); /*Restriccion para codigo de la empresa*/

ALTER TABLE bodega ADD CONSTRAINT ck_bodega_nombre CHECK ( nombre_bodega LIKE 'Bodega %' ); /*Restriccion para nombre de la bodega*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_cargo CHECK ( cargo IN (
        'TECNICO ERA 1',
        'TECNICO ERA 2',
        'OPERADOR POZO',
        'RECORREDOR POZO',
        'INGENIERO PETROLERO POZO'
    ) ); /*Restriccion de cargos en empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_correo CHECK ( correo LIKE ( '%@petrolinventories.com.co' ) ); /*Restriccion de correo en empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_cedula CHECK ( length(cedula) = 10 ); /*Restriccion de cedula de empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_telefono CHECK ( length(numero_telefonico) = 10 ); /*Restriccion de numero de empleado*/
  
ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_pedido_cantidad CHECK ( length(cantidad_piezas) <= 3 ); /*Restriccion de cantidad de piezas*/

ALTER TABLE pieza_extraccion_petrolera
    ADD CONSTRAINT ck_pieza_tipo CHECK ( tipo IN (
        'Engranajes',
        'Tornillos',                                                    /* REVISAR ESTE QUE NO SON LOS DATOS CORRECTOS, CAMBIARLOS POR LOS NUEVOS*/
        'Soldadoras',
        'Tubos',
        'Perforadoras'
    ) ); /*Restriccion de tipos de pieza*/



/*ACCIONES*/


/*Si se elimina de la base de datos una empresa, se tiene que eliminar los datos de ese proveedor*/
ALTER TABLE empresa DROP CONSTRAINT fk_empresa_codigo;

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo )
            ON DELETE CASCADE;

/*Si se elimina de la base de datos una persona natural, se tiene que eliminar los datos de ese proveedor*/
ALTER TABLE persona_natural DROP CONSTRAINT fk_persona_codigo;

ALTER TABLE persona_natural
    ADD CONSTRAINT fk_persona_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo )
            ON DELETE CASCADE;

/*Si se elimina el permiso del pedido, se elimina tambien el pedido*/
ALTER TABLE permiso DROP CONSTRAINT fk_permiso_pedido;

ALTER TABLE permiso
    ADD CONSTRAINT fk_permiso_pedido FOREIGN KEY ( pedido )
        REFERENCES pedido_pieza ( numero_pedido )
            ON DELETE CASCADE;

/*Si se elimina un empleado directo, se debe eliminar los datos de este empleado*/
ALTER TABLE empleado_directo DROP CONSTRAINT fk_directo_identificador;

ALTER TABLE empleado_directo
    ADD CONSTRAINT fk_directo_identificador FOREIGN KEY ( id )
        REFERENCES empleado ( id )
            ON DELETE CASCADE;

/*Si se elimina un experto, se debe eliminar los datos de este empleado*/
ALTER TABLE experto DROP CONSTRAINT fk_experto_identificador;

ALTER TABLE experto
    ADD CONSTRAINT fk_experto_identificador FOREIGN KEY ( id )
        REFERENCES empleado ( id )
            ON DELETE CASCADE;
			
			
			


			
/*TUPLAS*/
/*El departamento de destino de los pedidos siempre debe ser los pozos petroleros, y la cantidad de piezas permitidas para pedir son menos de 100*/
ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_pedido_minimo_lugar CHECK ( departamento_destino = 'Pozos Petroleros'
                                                  AND length(cantidad_piezas) < 3 );		
												  
/*TuplasOK*/
INSERT INTO bodega VALUES('Bodega Chichimene', 'Chichimene', 'Meta');
INSERT INTO pedido_pieza VALUES(9184521, 'Pozos Petroleros', '50', 'Aceptado', 'Bodega Chichimene', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/20', 'yyyy/mm/dd'));

/*TuplasNoOk*/
INSERT INTO bodega VALUES('Bodega San Martin', 'Acacias', 'Meta');
INSERT INTO pedido_pieza VALUES(8501147, 'Corporativos', '150', 'Aceptado', 'Bodega San Martin', TO_DATE('2020/11/25', 'yyyy/mm/dd'),TO_DATE('2020/11/29', 'yyyy/mm/dd'));
INSERT INTO pedido_pieza VALUES(6252222, 'Pozos Petroleros', '2500', 'Aceptado', 'Bodega San Martin', TO_DATE('2020/11/25', 'yyyy/mm/dd'),TO_DATE('2020/11/29', 'yyyy/mm/dd'));



/*La fecha de pedido debe ser menor a la fecha de entrega del pedido*/
ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_tiempo_espera_pedido CHECK ( EXTRACT(DAY FROM fecha_pedido) < EXTRACT(DAY FROM fecha_llegada) );
	
/*TuplasOK*/
INSERT INTO pedido_pieza VALUES(8895621, 'Pozos Petroleros', '50', 'Aceptado', 'Bodega San Martin', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/19', 'yyyy/mm/dd'));

/*TuplasNoOk*/
INSERT INTO pedido_pieza VALUES(2562228, 'Pozos Petroleros', '50', 'Aceptado', 'Bodega Chichimene', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/17', 'yyyy/mm/dd'));



/*Si el estado del permiso es NO ACEPTADO entonces el pedido debe ser NULO*/
ALTER TABLE permiso
    ADD CONSTRAINT ck_permiso_nulo CHECK ( estado = 'No Aceptado'
                                           AND pedido = NULL ); 
										   
/*TuplasOK*/
INSERT INTO empleado VALUES('Diego', 'Gonzalez', 'E000955', 'TECNICO ERA 1', 'diego.gonzalez@petrolinventories.com.co', '3228569595', '<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E000985</Jefe_dpto>
	<Jefe_ingeniero>E000325</Jefe_ingeniero>
	<Jefe_tecnicos>E000914</Jefe_tecnicos>
</Tdepartamento>', '1896525412');
INSERT INTO pieza_extraccion_petrolera VALUES(152256,'Tubos','<Ttubos>
	<Tubos>
		<Diametro_exterior>508 mm</Diametro_exterior>
		<Espesor_pared>15.9 mm</Espesor_pared>
		<Longitud>22.23 m</Longitud>
	</Tubos>
</Ttubos>');
INSERT INTO permiso VALUES(8585854,'E000955',152256,'Se requiere para extraccion del martes','No Aceptado',TO_DATE('2020/11/17', 'yyyy/mm/dd'),NULL);

/*TuplasNoOk*/
INSERT INTO empleado VALUES('Luis', 'Parra', 'E000558', 'TECNICO ERA 2', 'luis.parra@petrolinventories.com.co', '3526222541', '<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E000554</Jefe_dpto>
	<Jefe_ingeniero>E000322</Jefe_ingeniero>
	<Jefe_tecnicos>E000915</Jefe_tecnicos>
</Tdepartamento>', '9585452225');
INSERT INTO pieza_extraccion_petrolera VALUES(858562,'Tubos','<Ttubos>
	<Tubos>
		<Diametro_exterior>510 mm</Diametro_exterior>
		<Espesor_pared>13.9 mm</Espesor_pared>
		<Longitud>22.28 m</Longitud>
	</Tubos>
</Ttubos>');
INSERT INTO pedido_pieza VALUES(8585415, 'Pozos Petroleros', '23', 'Aceptado', 'Bodega San Martin', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/19', 'yyyy/mm/dd'));
INSERT INTO permiso VALUES(9652632,'E000558',858562,'Se requiere para extraccion del miercoles','No Aceptado',TO_DATE('2020/11/17', 'yyyy/mm/dd'),8585415);



/*Si el estado del permiso es ACEPTADO entonces el pedido no debe ser NULO*/
ALTER TABLE permiso
    ADD CONSTRAINT ck_permiso_nulidad CHECK ( estado = 'Aceptado'
                                           AND pedido != NULL ); 

/*TuplasOk*/
INSERT INTO empleado VALUES('Ana', 'Gonzalez', 'E000960', 'TECNICO ERA 2', 'ana.gonzalez@petrolinventories.com.co', '3123222584', '<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E000554</Jefe_dpto>
	<Jefe_ingeniero>E000322</Jefe_ingeniero>
	<Jefe_tecnicos>E000915</Jefe_tecnicos>
</Tdepartamento>', '8595652145');
INSERT INTO pieza_extraccion_petrolera VALUES(6251475,'Tubos','<Ttubos>
	<Tubos>
		<Diametro_exterior>525 mm</Diametro_exterior>
		<Espesor_pared>14.9 mm</Espesor_pared>
		<Longitud>22.68 m</Longitud>
	</Tubos>
</Ttubos>');
INSERT INTO pedido_pieza VALUES(9523014, 'Pozos Petroleros', '40', 'Aceptado', 'Bodega San Martin', TO_DATE('2020/11/17', 'yyyy/mm/dd'),TO_DATE('2020/11/19', 'yyyy/mm/dd'));
INSERT INTO permiso VALUES(2652547,'E000960',6251475,'Se requiere para extraccion del jueves','Aceptado',TO_DATE('2020/11/17', 'yyyy/mm/dd'),9523014);
										   
/*TuplasNoOk*/
INSERT INTO empleado VALUES('Jose', 'Gualteros', 'E000669', 'TECNICO ERA 1', 'jose.gualteros@petrolinventories.com.co', '3159565252', '<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E000554</Jefe_dpto>
	<Jefe_ingeniero>E000322</Jefe_ingeniero>
	<Jefe_tecnicos>E000915</Jefe_tecnicos>
</Tdepartamento>', '5252632144');
INSERT INTO pieza_extraccion_petrolera VALUES(6621458,'Tubos','<Ttubos>
	<Tubos>
		<Diametro_exterior>540 mm</Diametro_exterior>
		<Espesor_pared>20.2 mm</Espesor_pared>
		<Longitud>35 m</Longitud>
	</Tubos>
</Ttubos>');
INSERT INTO permiso VALUES(5265444,'E000669',6621458,'Se requiere para extraccion del viernes','Aceptado',TO_DATE('2020/11/17', 'yyyy/mm/dd'),NULL);



/*El ID del empleado directo debe empezar con E000 y su departamento de trabajo es pozos petroleros*/
ALTER TABLE empleado_directo
    ADD CONSTRAINT ck_requisitos_directo CHECK ( id LIKE 'E000%'
                                                 AND departamento_experiencia = 'Pozos Petroleros' );
												 
/*TuplasOK*/
INSERT INTO empleado_directo VALUES('E000321','Pozos Petroleros','<Planta_residencia>
	<Municipio>Chichimene</Municipio>
	<Departamento>Meta</Departamento>
	<Planta Nombre = 'Chichimene 2'>
		<Estacion>VIT 35</Estacion>
		<Oficina>601</Oficina>
	</Planta>
</Planta_residencia>');

/*TuplasNoOk*/
INSERT INTO empleado_directo VALUES('E001215','Corporativos','<Planta_residencia>
	<Municipio>Chichimene</Municipio>
	<Departamento>Meta</Departamento>
	<Planta Nombre = 'Chichimene 1'>
		<Estacion>VIT 40</Estacion>
		<Oficina>610</Oficina>
	</Planta>
</Planta_residencia>');



/*El ID del experto debe empezar con E001 y su departamento de trabajo es pozos petroleros*/
ALTER TABLE experto
    ADD CONSTRAINT ck_requisitos_experto CHECK ( id LIKE 'E001%'
                                                 AND  EXTRACTVALUE(experto.departamento_experiencia,'/Tdepartamento/Nombre/text()') = 'Pozos Petroleros');
/*TuplasOK*/
INSERT INTO experto VALUES('E001559','<Tdepartamento>
	<Nombre>Pozos petroleros</Nombre>
	<Jefe_dpto>E0009856</Jefe_dpto>
	<Jefe_ingeniero>E0003255</Jefe_ingeniero>
	<Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>');

/*TuplasNoOk*/
INSERT INTO experto VALUES('E004559','<Tdepartamento>
	<Nombre>Corporativos</Nombre>
	<Jefe_dpto>E0009856</Jefe_dpto>
	<Jefe_ingeniero>E0003255</Jefe_ingeniero>
	<Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>');



/*El codigo de los proveedores debe ser PROV y sus años de experiencia deben ser mayores a 5*/
ALTER TABLE proveedor
    ADD CONSTRAINT ck_experiencia_proveer CHECK ( codigo LIKE 'PROV%'
                                                  AND años_experiencia > 5 );
/*TuplasOK*/
INSERT INTO proveedor VALUES('PROV5959','3158654069','blackdeck@gmail.com.co','Calle 5 sur numero 28-15','Bogotá','100025', 6);

/*TuplasNoOk*/
INSERT INTO proveedor VALUES('PREV5959','3215698585','black2@gmail.com','Calle 6 sur numero 15-20','Funza',NULL,2);														
												  
												  
												  
												  
												  
/*=========================================PROCEDIMENTALES=====================================*/

/*YA TODOS LOS TRIGGER EXCEPTO UNO CORREN FULL*/

/*Mantener Pieza*/

/*El numero maximo de piezas que se pueden solicitar es 50*/
CREATE OR REPLACE TRIGGER Max_tubos
BEFORE INSERT ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :NEW.cantidad_piezas > 50 THEN
		RAISE_APPLICATION_ERROR(-15200,'El numero maximo de piezas que se pueden solicitar es 50');
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
DROP TRIGGER Max_tubos;



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
	IF :OLD.estado = 'Aceptados' THEN
		RAISE_APPLICATION_ERROR(654,'Solo se pueden actualizar pedidos si no estan aceptados');
	END IF;
END;
/
/*DisparadorOk*/	
INSERT INTO pedido_pieza VALUES(858562, 'Pozos Petroleros',48, 'No Aceptado', NULL, NULL, NULL);
UPDATE pedido_pieza SET estado = 'Aceptado' AND bodega_reclamo = 'Bodega Central' AND fecha_pedido = TO_DATE('2020/11/25', 'yyyy/mm/dd') AND fecha_llegada =  TO_DATE('2020/11/29', 'yyyy/mm/dd') WHERE pedido_pieza.numero_pedido = 858562;
/*DisparadorNoOK*/
INSERT INTO pedido_pieza VALUES(9565241, 'Pozos Petroleros', 30, 'Aceptado', 'Bodega Central', TO_DATE('2020/11/25', 'yyyy/mm/dd'),TO_DATE('2020/11/29', 'yyyy/mm/dd') );
UPDATE pedido_pieza SET estado = 'No Aceptado' AND bodega_reclamo = NULL AND fecha_pedido = NULL AND fecha_llegada = NULL WHERE pedido_pieza.numero_pedido = 9565241;
/*XDisparador*/
DROP TRIGGER Actualizacion_pedidos;



/*No se pueden eliminar pedidos Aceptados*/
CREATE OR REPLACE TRIGGER Eliminacion_Pedidos
BEFORE DELETE ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :OLD.estado = 'Aceptado' THEN
		RAISE_APPLICATION_ERROR(654,'No se pueden eliminar pedidos Aceptados');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO pedido_pieza VALUES(8585963, 'Pozos Petroleros', 38, 'No Aceptado', NULL, NULL, NULL);
DELETE FROM pedido_pieza WHERE pedido_pieza.numero_pedido = 8585963;
/*DisparadorNoOK*/
INSERT INTO pedido_pieza VALUES(3252410, 'Pozos Petroleros', 42, 'Aceptado', 'Bodega Central', TO_DATE('2020/11/25', 'yyyy/mm/dd'), TO_DATE('2020/11/27', 'yyyy/mm/dd'));
DELETE FROM pedido_pieza WHERE pedido_pieza.numero_pedido = 3252410;
/*XDisparador*/
DROP TRIGGER Eliminacion_Pedidos;



/*TODOS LOS TRIGGERS ANTERIORES YA FUERON REVISADOS Y SU SINTAXIS ES CORRECTA PARA LO QUE SE QUIERE HACER*/








/*================================================================================================================================*/
/*Mantener Personal*/

/*El id de los empleados se genera automaticamente y es incremental*/
CREATE OR REPLACE TRIGGER Id_Empleados
BEFORE INSERT ON empleado
FOR EACH ROW
DECLARE x NUMBER;	
BEGIN
	SELECT MAX(ID) INTO x                               /*REVISAR ESTE TRIGGER por incremental*/
	FROM empleado;
	IF x IS NULL THEN
		:NEW.ID := 1;
	ELSE
		:NEW.ID := x+1;
	END IF;
END;
/
/*DisparadorOk*/
/*No va a tener disparadorNoOk debido a que es un trigger autoincremental*/
/*XDisparador*/
DROP TRIGGER Id_Empleados;



/*No se puede actualizar el departamento de experiencia*/
CREATE OR REPLACE TRIGGER TriggerExperto
BEFORE UPDATE ON experto
FOR EACH ROW
BEGIN
	IF :OLD.departamento_experiencia != :NEW.departamento_experiencia THEN
		RAISE_APPLICATION_ERROR(-1001,'No se puede actualizar el departamento de experiencia');            /*ARREGLAR ESTE TRIGGER*/
	END IF;                                                                                                /*LA IDEA DE ESTE TRIGGER ES CORRECTA*/
END;
/
/*XDisparador*/
DROP TRIGGER TriggerExperto;


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
		RAISE_APPLICATION_ERROR(-854,'No pueden haber mas de 5 bodegas por departamento');
	END IF;
END;
/

/*DisparadorOk*/
insert into bodega  values ('Bodega San Martin', 'Acacias', 'Meta');
insert into bodega  values ('Bodega La Esperanza', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega Chichimene 1', 'Acacias', 'Meta');
insert into bodega  values ('Bodega San Juan 3', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega Central', 'Funza', 'Cundinamarca');

/*DisparadorNoOK*/
insert into bodega  values ('Bodega San Isidro', 'Acacias', 'Meta');
insert into bodega  values ('Bodega San Esperancita', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega San Pedro', 'Acacias', 'Meta');
insert into bodega  values ('Bodega San Juan 6', 'Villavicencio', 'Meta');
insert into bodega  values ('Bodega Central 3', 'Mesetas', 'Meta');
insert into bodega  values ('Bodega San Fernando', 'Guamal', 'Meta');

/*XDisparador*/
DROP TRIGGER Nro_Bodegas;



/*No se puede actualizar la ubicacion de la bodega*/
CREATE OR REPLACE TRIGGER Ubicacion_bodega
BEFORE UPDATE ON bodega
FOR EACH ROW
BEGIN
	IF :NEW.departamento != :OLD.departamento OR :NEW.municipio != :OLD.municipio THEN
		RAISE_APPLICATION_ERROR(-855,'No se puede actualizar la ubicacion de la bodega');
	END IF;
END;
/

/*DisparadorOk*/
INSERT INTO bodega VALUES('Bodega la 13', 'Cajicá', 'Cundinamarca');
UPDATE bodega SET nombre_bodega = 'Bodega la 14' WHERE bodega.nombre_bodega = 'Bodega la 13';

/*DisparadorNoOK*/
INSERT INTO bodega VALUES('Bodega la 25', 'Funza', 'Cundinamarca');
UPDATE bodega SET departamento = 'Casanare' AND municipio = 'Yopal' WHERE bodega.nombre_bodega = 'Bodega la 25';

/*XDisparador*/
DROP TRIGGER Ubicacion_bodega;



/*No se puede eliminar un inventario si no hay disponibilad 0*/
CREATE OR REPLACE TRIGGER Eliminacion_Inventario
BEFORE DELETE ON inventario
FOR EACH ROW
BEGIN
	IF :OLD.disponibilidad > 0 THEN
		RAISE_APPLICATION_ERROR(-754,'No se puede eliminar un inventario si no hay disponibilad 0');
	END IF;
END;
/

/*DisparadorOk*/
INSERT INTO inventario VALUES('Bodega Chichimene', 'CHI356', 0);
DELETE FROM inventario WHERE inventario.id_inventarios = 'CHI356';

/*DisparadorNoOK*/
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
	SELECT MAX(TO_NUMBER(SUBSTR(codigo,4)))INTO x
	FROM proveedor;
	IF x is NULL THEN
		:NEW.codigo := 'PROV';                                   /*revisar este trigger, aun sin poblacion*/
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
