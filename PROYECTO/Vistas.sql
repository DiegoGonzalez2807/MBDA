/*===================================VISTAS==================================*/
/*Se quiere revisar todos los retiros mensuales de piezas de extraccion, bajo que permiso fueron solicitados y bajo que pedido fueron enviados*/
/*ACLARACION = Se toma como caso base el mes de noviembre del 2020*/
CREATE VIEW retiros_mensuales AS
    ( SELECT
        pedido_pieza.numero_pedido,
        permiso.numero_pieza,
        permiso.numero_permiso,
        inventario.bodega_residencia,
        inventario.id_inventarios
    FROM
             pedido_pieza
        JOIN permiso ON pedido_pieza.numero_pedido = permiso.pedido
        JOIN bodega ON pedido_pieza.bodega_reclamo = bodega.nombre_bodega
        JOIN inventario ON bodega.nombre_bodega = inventario.bodega_residencia
    WHERE
        pedido_pieza.fecha_llegada BETWEEN TO_DATE('2020/11/01', 'yyyy/mm/dd') AND TO_DATE('2020/11/30', 'yyyy/mm/dd')
    );
	
	
/*XVistas*/
DROP VIEW retiros_mensuales;



/*Se quiere tener la información de todas las piezas defectuosas y quien dió ese criterio*/

CREATE VIEW consulta_piezas_defectuosas AS
    ( SELECT
        estado.numero_revision,
        estado.revisado_por,
        estado.numero_pieza,
        estado.observaciones
    FROM
        estado
    WHERE
        estado.calidad IN ( 'M', 'P' )
    );

/*XVistas*/
DROP VIEW consulta_piezas_defectuosas;