/*FOREIGN KEYS*/

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE persona_natural
    ADD CONSTRAINT fk_persona_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE provee
    ADD CONSTRAINT fk_provee_proveedor FOREIGN KEY ( codigo_proveedor )                              
        REFERENCES proveedor ( codigo ); 															 

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
