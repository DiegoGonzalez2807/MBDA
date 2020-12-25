/*CRUDE -- PC_EMPLEADOS*/
CREATE OR REPLACE PACKAGE PC_EMPLEADOS IS

	PROCEDURE Adicionar_empleado (xnombre IN VARCHAR, xapellido IN VARCHAR, xid IN VARCHAR, xcargo IN VARCHAR, xcorreo IN VARCHAR, xnumero_telefonico IN VARCHAR, xdepartamento_trabajo IN XMLTYPE; xcedula IN VARCHAR);
	PROCEDURE Modificar_Empleado(xcargo IN VARCHAR, xnumero_telefonico IN VARCHAR, xcorreo IN VARCHAR);
	PROCEDURE Eliminar_Empleado (xid IN VARCHAR);
	FUNCTION Revisar_Calidad RETURN SYS_REFCURSOR;
	FUNCTION Piezas_Defectuosas RETURN SYS_REFCURSOR;

END PC_EMPLEADOS;



/*CRUDE -- PC_´PROVEEDOR*/
CREATE OR REPLACE PACKAGE PC_PROVEEDOR IS

	PROCEDURE Adicionar_Proveedor (xcodigo IN VARCHAR, xtelefono IN VARCHAR, xcorreo IN VARCHAR, xdireccion IN VARCHAR, xciudad IN VARCHAR, xdireccion_postal IN VARCHAR, xaños_experiencia IN INTEGER);
	PROCEDURE Modificar_Proveedor (xcodigo IN VARCHAR, xtelefono IN VARCHAR, xcorreo IN VARCHAR, xdireccion IN VARCHAR);
	PROCEDURE Eliminar_Proveedor  (xcodigo IN VARCHAR);
	PROCEDURE Adicionar_Natural (xnombre IN VARCHAR, xprimer_apellido IN VARCHAR, xsegundo_apellido IN VARCHAR, xcedula IN VARCHAR, xcodigo IN VARCHAR);
	PROCEDURE Eliminar_Natural (xcodigo IN VARCHAR);
	PROCEDURE Adicionar_Empresa (xnombre IN VARCHAR, xnit IN VARCHAR, xcodigo IN VARCHAR);
	PROCEDURE Eliminar_Empresa (xcodigo IN VARCHAR);
	PROCEDURE Adicionar_Provee (xcodigo_proveedor IN VARCHAR, xnombre_bodega IN VARCHAR);
	PROCEDURE Modificar_Provee (xcodigo_proveedor IN VARCHAR);
	PROCEDURE Eliminar_Provee (xcodigo_proveedor IN VARCHAR, xnombre_bodega IN VARCHAR);	
	
END PC_PROVEEDOR;



/*CRUDE -- PC_INVENTARIOS*/
CREATE OR REPLACE PACKAGE PC_INVENTARIOS IS

	PROCEDURE Adicionar_inventario (xbodega_residencia IN VARCHAR, xid_inventarios IN VARCHAR, xdisponibilidad IN NUMBER); 
	PROCEDURE Modificar_inventario (xid_inventarios IN VARCHAR,xbodega_residencia IN VARCHAR, xdisponibilidad IN NUMBER); 
	PROCEDURE Eliminar_inventario (xid_inventarios IN VARCHAR); 
	PROCEDURE Adicionar_Bodega (xnombre_bodega IN VARCHAR, xmunicipio IN VARCHAR, xdepartamento IN NUMBER);
	PROCEDURE Eliminar_Bodega (xnombre_bodega IN VARCHAR); 
	PROCEDURE Adicionar_Revision (xempleado_directo IN VARCHAR, xid_inventarios IN VARCHAR); 
	PROCEDURE Adicionar_Contenciones (xid_inventarios IN VARCHAR, xnumero_pieza IN NUMBER); 
	PROCEDURE Eliminar_Contenciones (xid_inventarios IN VARCHAR, xnumero_pieza IN NUMBER);
	
END PC_INVENTARIOS;



/*CRUDE -- PC_ESTADO*/
CREATE OR REPLACE PACKAGE PC_ESTADO IS
	
	PROCEDURE Adicionar_estado (xnumero_revision IN NUMBER, xrevisado_por IN VARCHAR, xnumero_pieza IN NUMBER, xcalidad IN VARCHAR, xobservaciones IN VARCHAR);
	PROCEDURE Modificar_estado (xcalidad IN VARCHAR, xobservaciones IN VARCHAR);
	
END PC_ESTADO;



/*CRUDE -- PC_PERMISOS*/
CREATE OR REPLACE PACKAGE PC_PERMISOS IS

    PROCEDURE Adicionar_Permiso(xNumero_permiso IN NUMBER,xID_autor IN VARCHAR, xDetalle IN VARCHAR, xNumero_pieza IN NUMBER, xEstado IN VARCHAR,fecha_permiso IN DATE, xPedido IN NUMBER);
    PROCEDURE Modificar_Permiso(xnumero_permiso IN NUMBER,xEstado IN VARCHAR,xfecha_permiso IN DATE, xPedido IN NUMBER);
    PROCEDURE Eliminar_Pedido (xnumero_permiso IN NUMBER);
	FUNCTION Retiros_Mensuales RETURN SYS_REFCURSOR;
	
END PC_PERMISOS;



