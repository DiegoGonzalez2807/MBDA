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
