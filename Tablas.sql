/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo     VARCHAR(8) NOT NULL,
    telefono   NUMBER(10) NOT NULL,
    correo     VARCHAR(15) NOT NULL
);

CREATE TABLE persona_juridica (
    nombre     VARCHAR(20) NOT NULL,
    apellido   VARCHAR(20) NOT NULL,
    cedula     NUMBER(10) NOT NULL,
    nit        NUMBER(10) NOT NULL,
    codigo     VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre             VARCHAR(25) NOT NULL,
    nit                NUMBER(10) NOT NULL,
    codigo             VARCHAR(8) NOT NULL,
    direccion          VARCHAR(50) NOT NULL,
    ciudad             VARCHAR(25) NOT NULL,
    direccion_postal   VARCHAR(6),
    telefono2          NUMBER(10)
);

CREATE TABLE bodega (
    nombre_bodega        VARCHAR(20) NOT NULL,
    municipio            VARCHAR(20) NOT NULL,
    departamento         VARCHAR(20) NOT NULL,
    proveedor            VARCHAR(8) NOT NULL
);

CREATE TABLE inventario (
    numero_inventario       NUMBER(3) NOT NULL,
    bodegas_automatizadas   NUMBER(3) NOT NULL,
    numero_serie_pieza      NUMBER(6) NOT NULL,
    disponibilidad          VARCHAR(13) NOT NULL,
    nombre_bodega           VARCHAR(20) NOT NULL
);

CREATE TABLE empleado (
    nombre                 VARCHAR(20) NOT NULL,
    apellido               VARCHAR(20) NOT NULL,
    id                     NUMBER(7) NOT NULL,
    correo                 VARCHAR(15),
    numero_telefonico      NUMBER(10),
    departamento_trabajo   VARCHAR(20) NOT NULL
);

CREATE TABLE experto (
    id                         NUMBER(7) NOT NULL,
    departamento_experiencia   VARCHAR(20) NOT NULL,
    cedula                     NUMBER(10) NOT NULL
);

CREATE TABLE permiso (
    numero_permiso    NUMBER(7) NOT NULL,
    id_autor          NUMBER(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    cantidad_piezas   NUMBER(5) NOT NULL,
    detalle           VARCHAR(250) NOT NULL,
    observaciones     VARCHAR(100) NOT NULL,
    estado            VARCHAR(8) NOT NULL,
    pedido            NUMBER(7)
);

CREATE TABLE pedido_pieza (
    numero_pedido          NUMBER(7) NOT NULL,
    id_autor               NUMBER(7) NOT NULL,
    departamento_trabajo   VARCHAR(20) NOT NULL,
    cantidad_piezas        NUMBER(5) NOT NULL,
    codigo_proveedor       VARCHAR(8) NOT NULL
);

CREATE TABLE pieza_extraccion_petrolera (
    numero_serie   NUMBER(6) NOT NULL,
    tipo           VARCHAR(15) NOT NULL,
    estado         VARCHAR(8) NOT NULL
);

CREATE TABLE dimensiones (
    numero_pieza   NUMBER(6) NOT NULL,
    alto           NUMBER(3) NOT NULL,
    largo          NUMBER(3) NOT NULL,
    ancho          NUMBER(3) NOT NULL
);

CREATE TABLE estado (
    numero_revision   NUMBER(7) NOT NULL,
    revisado_por      NUMBER(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    estado            VARCHAR(250) NOT NULL,
    calidad           VARCHAR(1) NOT NULL,
    observaciones     VARCHAR(250)
);

/*PRIMARY KEYS*/
ALTER TABLE empresa ADD CONSTRAINT pk_empresa_codigo PRIMARY KEY ( codigo );

ALTER TABLE persona_juridica ADD CONSTRAINT pk_juridica_codigo PRIMARY KEY ( codigo );

ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_codigo PRIMARY KEY ( codigo );

ALTER TABLE bodega ADD CONSTRAINT pk_bodega_nombre PRIMARY KEY ( nombre_bodega );

ALTER TABLE inventario ADD CONSTRAINT pk_inventario_numero PRIMARY KEY ( numero_inventario );

ALTER TABLE dimensiones ADD CONSTRAINT pk_dimension_numero PRIMARY KEY ( numero_pieza );

ALTER TABLE pieza_extraccion_petrolera ADD CONSTRAINT pk_numero_extraccion PRIMARY KEY ( numero_serie );

ALTER TABLE pedido_pieza ADD CONSTRAINT pk_numero_pedido PRIMARY KEY ( numero_pedido );

ALTER TABLE permiso ADD CONSTRAINT pk_numero_permiso PRIMARY KEY ( numero_permiso );

ALTER TABLE empleado ADD CONSTRAINT pk_empleado_id PRIMARY KEY ( id );

ALTER TABLE experto ADD CONSTRAINT pk_experto_id PRIMARY KEY ( id );

ALTER TABLE estado ADD CONSTRAINT pk_estado_revision PRIMARY KEY ( numero_revision );
