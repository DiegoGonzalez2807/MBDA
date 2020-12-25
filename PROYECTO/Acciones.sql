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