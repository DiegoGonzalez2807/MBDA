/*CRUDI -- PC_EMPLEADOS*/
CREATE OR REPLACE PACKAGE BODY PC_EMPLEADOS IS
		PROCEDURE Adicionar_empleado (xnombre IN VARCHAR, xapellido IN VARCHAR, xid IN VARCHAR, xcargo IN VARCHAR, xcorreo IN VARCHAR, xnumero_telefonico IN VARCHAR, xdepartamento_trabajo IN XMLTYPE; xcedula IN VARCHAR) IS
		BEGIN 
		INSERT INTO empleado (nombre,apellido,id,cargo,correo,numero_telefonico,departamento_trabajo,cedula) VALUES(xnombre,xapellido,xid,xcargo,xcorreo,xnumero_telefonico,xdepartamento_trabajo,xcedula);
		COMMIT;
		EXCEPTION
			WHEN OTHERS THEN
				ROLLBACK;
				RAISE_APPLICATION_ERROR(-20011, 'No se puede insertar el empleado')
		END;
		

		PROCEDURE Modificar_Empleado(xid IN VARCHAR, xcargo IN VARCHAR, xnumero_telefonico IN VARCHAR, xcorreo IN VARCHAR) IS
		BEGIN
		UPDATE empleado SET cargo = xcargo, numero_telefonico = xnumero_telefonico, correo = xcorreo WHERE xid = id;
		COMMIT;
		EXCEPTION
			WHEN OTHERS THEN
				ROLLBACK;
				RAISE_APPLICATION_ERROR(-20012, 'No se puede modificar el empleado requerido');
		END;
		
		
		PROCEDURE Eliminar_Empleado (xid IN VARCHAR) IS 
		BEGIN
		DELETE FROM empleado WHERE id = xid;
		COMMIT;
		EXCEPTION
			WHEN OTHERS THEN
				ROLLBACK;
				RAISE_APPLICATION_ERROR(-20013, 'No se puede eliminar al empleado en cuestión');
		END;
		
				
		FUNCTION Revisar_Calidad RETURN SYS_REFCURSOR IS calidad_piezas SYS_REFCURSOR;
		BEGIN
			OPEN calidad_piezas FOR
				(SELECT pieza_extraccion_petrolera.numero_serie, pieza_extraccion_petrolera.tipo. estado.numero_revision, estado.calidad, estado.observaciones
				FROM estado,pieza_extraccion_petrolera);
            RETURN calidad_piezas;
		END;
				

		FUNCTION Piezas_Defectuosas RETURN SYS_REFCURSOR IS piezas_malas SYS_REFCURSOR;
		BEGIN
			OPEN piezas_malas FOR
				(SELECT * FROM estado
				WHERE calidad IN ('M'));
			RETURN piezas_malas;
		END;
						
						
END PC_EMPLEADOS;



/*CRUDI -- PC_´PROVEEDOR*/
CREATE OR REPLACE PACKAGE BODY PC_PROVEEDOR IS
	PROCEDURE Adicionar_Proveedor (xcodigo IN VARCHAR, xtelefono IN VARCHAR, xcorreo IN VARCHAR, xdireccion IN VARCHAR, xciudad IN VARCHAR, Xdireccion_postal IN VARCHAR, xaños_experiencia IN INTEGER) IS
	BEGIN
	INSERT INTO proveedor(codigo,telefono,correo,direccion,ciudad,direccion_postal,años_experiencia) VALUES(xcodigo,xtelefono,xcorreo,xdireccion,xciudad,xdireccion_postal,xaños_experiencia);
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20014, 'No se puede insertar el proveedor');
			
			
	PROCEDURE Modificar_Proveedor (xcodigo IN VARCHAR, xtelefono IN VARCHAR, xcorreo IN VARCHAR, xdireccion IN VARCHAR) IS
	BEGIN 
	UPDATE proveedor SET telefono = xtelefono, correo = xcorreo, direccion = xdireccion WHERE xcodigo = codigo;
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20015, 'No se puede modificar el proveedor en cuestion');
	END;


	PROCEDURE Eliminar_Proveedor  (xcodigo IN VARCHAR)IS 
	BEGIN
	DELETE FROM proveedor WHERE codigo = xcodigo;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20016, 'No se puede eliminar el proveedor en cuestion');
	END;


	PROCEDURE Adicionar_Natural (xnombre IN VARCHAR, xprimer_apellido IN VARCHAR, xsegundo_apellido IN VARCHAR, xcedula IN VARCHAR, xcodigo IN VARCHAR) IS
	BEGIN
	INSERT INTO persona_natural(nombre,primer_apellido,segundo_apellido,cedula,codigo) VALUES (xnombre,xprimer_apellido,xsegundo_apellido,xcedula,xcodigo);
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20017, 'No se puede insertar esta persona natural que es proveedor');
	END;


	PROCEDURE Eliminar_Natural (xcodigo IN VARCHAR) IS
	BEGIN
	DELETE FROM persona_natural WHERE codigo = xcodigo;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20018, 'No se puede eliminar al proveedor natural en cuestion');
	END;
	
	
	PROCEDURE Adicionar_Empresa (xnombre IN VARCHAR, xnit IN VARCHAR, xcodigo IN VARCHAR) IS
	BEGIN 
	INSERT INTO empresa(nombre,nit,codigo) VALUES(xnombre,xnit,xcodigo);
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN	
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20019, 'No se puede insertar a la empresa proveedora');
	END;
	
	
	PROCEDURE Eliminar_Empresa (xcodigo IN VARCHAR) IS
	BEGIN
	DELETE FROM empresa WHERE codigo = xcodigo;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN	
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20020, 'No se puede eliminar a la empresa en cuestion');
	END;
	
	PROCEDURE Adicionar_Provee (xcodigo_proveedor IN VARCHAR, xnombre_bodega IN VARCHAR) IS 
	BEGIN 
	INSERT INTO provee(codigo_proveedor, nombre_bodega) VALUES(xcodigo_proveedor,xnombre_bodega);
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20030, 'No se puede insertar la tabla derivada provee con estos datos');
	END;
	
	
	PROCEDURE Modificar_Provee (xcodigo_proveedor IN VARCHAR, xnombre_bodega IN VARCHAR) IS
	BEGIN
	UPDATE provee SET nombre_bodega = xnombre_bodega  WHERE xcodigo_proveedor = codigo_proveedor;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20031, 'No se pudo modificar esta tabla derivada');
	END;
	
	
	PROCEDURE Eliminar_Provee (xcodigo_proveedor IN VARCHAR, xnombre_bodega IN VARCHAR) IS
	BEGIN
	DELETE FROM provee WHERE codigo_proveedor = xcodigo_proveedor AND nombre_bodega = xnombre_bodega;
	COMMIT;
	EXCEPTION	
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20032, 'No se puede eliminar esta tabla derivada');
	END;
	
	
	
	
END PC_PROVEEDOR;



/*CRUDI -- PC_INVENTARIOS*/
CREATE OR REPLACE PACKAGE BODY PC_INVENTARIOS IS
	PROCEDURE Adicionar_inventario (xbodega_residencia IN VARCHAR, xid_inventarios IN VARCHAR, xdisponibilidad IN NUMBER) IS
	BEGIN
	INSERT INTO inventario(bodega_residencia,id_inventarios,disponibilidad) VALUES(xbodega_residencia,xid_inventarios,xdisponibilidad);
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20021, 'No se pudo agregar la pieza al inventario');
	END;


	PROCEDURE Modificar_inventario (xid_inventarios IN VARCHAR, xbodega_residencia IN VARCHAR, xdisponibilidad IN NUMBER) IS
	BEGIN
	UPDATE inventario SET bodega_residencia = xbodega_residencia, disponibilidad = xdisponibilidad WHERE xid_inventarios = id_inventarios;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20022, 'No se pudo modificar el inventario requerido');
	END;


	PROCEDURE Eliminar_inventario (xid_inventarios IN VARCHAR) IS
	BEGIN
	DELETE FROM inventario WHERE id_inventarios = xid_inventarios;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN 
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20023, 'No se pudo eliminar el inventario en cuestion');
	END;
	
	
	PROCEDURE Adicionar_Bodega (xnombre_bodega IN VARCHAR, xmunicipio IN VARCHAR, xdepartamento IN NUMBER) IS
	BEGIN
	INSERT INTO bodega(nombre_bodega,municipio,departamento) VALUES(xnombre_bodega,xmunicipio,xdepartamento);
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20033, 'No se pudo agregar la bodega deseada');
	END;
	
	
	PROCEDURE Eliminar_Bodega (xnombre_bodega IN VARCHAR) IS
	BEGIN
	DELETE FROM bodega WHERE nombre_bodega = xnombre_bodega;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN 
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20034, 'No se pudo eliminar la bodega en cuestion');
	END;
	
	
	PROCEDURE Adicionar_Revision (xempleado_directo IN VARCHAR, xid_inventarios IN VARCHAR) IS
	BEGIN
	INSERT INTO revisa(empleado_directo,id_inventarios) VALUES(xempleado_directo,xid_inventarios);
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20035, 'No se pudo agregar la revision deseada');
	END;
	
	
	PROCEDURE Adicionar_Contenciones (xid_inventarios IN VARCHAR, xnumero_pieza IN NUMBER) IS
	BEGIN
	INSERT INTO contiene(id_inventarios,numero_pieza) VALUES(xid_inventarios,xnumero_pieza);
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20036, 'No se pudo agregar la contecion deseada');
	END;
	
	
	PROCEDURE Eliminar_Contenciones (xid_inventarios IN VARCHAR, xnumero_pieza IN NUMBER) IS
	BEGIN
	DELETE FROM contiene WHERE id_inventarios = xid_inventarios AND numero_pieza = xnumero_pieza;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN 
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20034, 'No se pudo eliminar la bodega en cuestion');
	END;
	
	
	
END PC_INVENTARIOS;



/*CRUDI -- PC_ESTADO*/
CREATE OR REPLACE PACKAGE BODY PC_ESTADO IS 
	PROCEDURE Adicionar_estado (xnumero_revision IN NUMBER, xrevisado_por IN VARCHAR, xnumero_pieza IN NUMBER, xcalidad IN VARCHAR, xobservaciones IN VARCHAR) IS
	BEGIN
	INSERT INTO estado(numero_revision,revisado_por,numero_pieza,calidad,observaciones) VALUES(xnumero_revision, xrevisado_por, xnumero_pieza, xcalidad, xobservaciones);
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN	
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20024, 'No se puede ingresar el estado de la pieza de extraccion');
	END;
	
	
	PROCEDURE Modificar_estado (xnumero_revision IN NUMBER, xcalidad IN VARCHAR, xobservaciones IN VARCHAR) IS
	BEGIN
	UPDATE estado SET  calidad = xcalidad, observaciones = xobservaciones WHERE xnumero = numero;
	COMMIT;
	EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20025, 'No se puede modificar el estado en cuestion');
	END;
	
	
END PC_ESTADO;