/*====================================INDICES==================================*/
/*Crear index para asegurar que al insertar nombre y nit de una empresa, estos sean valores únicos*/
CREATE UNIQUE INDEX datosempresa ON
    empresa (
        nombre,
        nit
    );
/*XIndice*/
DROP INDEX datosempresa;



/*Crear index para asegurar que al insertar el código de proveedor de persona natural y la cédula de este, siempre sean únicos*/
CREATE UNIQUE INDEX identificador_natural ON
    persona_natural (
        cedula
    );
/*XIndice*/
DROP INDEX identificador_natural;



/*Crear index para tener mayor facilidad de acceso en las fechas del pedido de pieza*/
CREATE INDEX fechas_pedidos ON
    pedido_pieza (
        fecha_pedido,
        fecha_llegada
    );
/*XIndice*/
DROP INDEX fechas_pedidos;



/*Crear index para tener mayor facilidad de acceso a la locación de cada bodega*/
CREATE INDEX locacion_bodega ON
    bodega (
        municipio,
        departamento
    );
/*XIndice*/
DROP INDEX locacion_bodega;



/*Crear index para averiguar donde y cuantas existencias de cada pieza hay*/
CREATE INDEX existencias_piezas ON
    inventario (
        bodega_residencia,
        disponibilidad
    );
/*XIndice*/
DROP INDEX existencias_piezas;