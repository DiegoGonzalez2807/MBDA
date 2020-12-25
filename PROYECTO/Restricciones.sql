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
        'Mangueras',
        'Tubos',                                                    
        'Bombas',
        'Engranajes',
        'Tornillos'
    ) ); /*Restriccion de tipos de pieza*/