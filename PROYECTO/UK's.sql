/*UNIQUE KEYS*/

ALTER TABLE persona_natural ADD CONSTRAINT uk_seg_apellido UNIQUE ( segundo_apellido );

ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nombre UNIQUE ( nombre );                                         
																													
ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nit UNIQUE ( nit );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_telefono UNIQUE ( telefono );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_correo UNIQUE ( correo );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_direccion UNIQUE ( direccion );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_correo UNIQUE ( correo );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_telefono UNIQUE ( numero_telefonico );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_cedula UNIQUE ( cedula );
