/*PRIMARY KEYS*/
ALTER TABLE empresa ADD CONSTRAINT pk_empresa_codigo PRIMARY KEY ( codigo );

ALTER TABLE persona_natural ADD CONSTRAINT pk_juridica_codigo PRIMARY KEY ( codigo );
 
ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_codigo PRIMARY KEY ( codigo );

ALTER TABLE provee ADD CONSTRAINT pk_provee_codigos PRIMARY KEY ( codigo_proveedor,
                                                                  nombre_bodega );

ALTER TABLE bodega ADD CONSTRAINT pk_bodega_nombre PRIMARY KEY ( nombre_bodega );                                     
																													  
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
