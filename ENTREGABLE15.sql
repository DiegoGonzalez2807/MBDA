/*Eliminar datos*/
DELETE FROM proveedor;

DELETE FROM persona_natural;

DELETE FROM empresa;

DELETE FROM provee;

DELETE FROM bodega;

DELETE FROM inventario;

DELETE FROM contiene;

DELETE FROM empleado_directo;

DELETE FROM empleado;

DELETE FROM experto;

DELETE FROM estado;

DELETE FROM permiso;

DELETE FROM pedido_pieza;

DELETE FROM pieza_extraccion_petrolera;

DELETE FROM revisa;


/*ELIMINAR TABLAS*/

DROP TABLE contiene CASCADE CONSTRAINTS;

DROP TABLE empleado_directo CASCADE CONSTRAINTS;

DROP TABLE proveedor CASCADE CONSTRAINTS;

DROP TABLE persona_natural CASCADE CONSTRAINTS;

DROP TABLE empresa CASCADE CONSTRAINTS;

DROP TABLE provee CASCADE CONSTRAINTS;

DROP TABLE bodega CASCADE CONSTRAINTS;

DROP TABLE inventario CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE experto CASCADE CONSTRAINTS;

DROP TABLE estado CASCADE CONSTRAINTS;

DROP TABLE permiso CASCADE CONSTRAINTS;

DROP TABLE pedido_pieza CASCADE CONSTRAINTS;

DROP TABLE pieza_extraccion_petrolera CASCADE CONSTRAINTS;

DROP TABLE revisa CASCADE CONSTRAINTS;


/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo            VARCHAR(8) NOT NULL,
    telefono          VARCHAR(10) NOT NULL,
    correo            VARCHAR(250) NOT NULL,
    direccion         VARCHAR(100) NOT NULL,
    ciudad            VARCHAR(50) NOT NULL,
    direccion_postal  VARCHAR(250),
    años_experiencia  VARCHAR(30) NOT NULL
);

CREATE TABLE persona_natural (
    nombre            VARCHAR(50) NOT NULL,
    primer_apellido   VARCHAR(50) NOT NULL,
    segundo_apellido  VARCHAR(50) NOT NULL,
    cedula            VARCHAR(10) NOT NULL,
    codigo            VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre  VARCHAR(250) NOT NULL,
    nit     VARCHAR(10) NOT NULL,
    codigo  VARCHAR(8) NOT NULL
);

CREATE TABLE provee (
    codigo_proveedor   VARCHAR(8) NOT NULL,
    nombre_bodega      VARCHAR(100) NOT NULL
    
);
CREATE TABLE bodega (
    nombre_bodega        VARCHAR(100) NOT NULL,
    municipio            VARCHAR(100) NOT NULL,
    departamento         VARCHAR(100) NOT NULL
);

CREATE TABLE inventario (
    bodega_residencia       VARCHAR(100) NOT NULL,   
    id_inventarios          VARCHAR(6) NOT NULL,
    disponibilidad          VARCHAR(13) NOT NULL
);

CREATE TABLE contiene (
	id_inventario    VARCHAR(100) NOT NULL,
	numero_pieza     NUMBER(6) NOT NULL
);

CREATE TABLE pieza_extraccion_petrolera (
    numero_serie   NUMBER(6) NOT NULL,
    tipo           VARCHAR(15) NOT NULL,
    dimensiones    XMLTYPE
);


CREATE TABLE revisa (
    id_empleado_directo  VARCHAR(7) NOT NULL,
    id_inventario        VARCHAR(6) NOT NULL
);

CREATE TABLE empleado_directo (
    id                 VARCHAR(7) NOT NULL,
    planta_residencia  XMLTYPE
);

CREATE TABLE experto (
    id                         VARCHAR(7) NOT NULL,
    departamento_experiencia   XMLTYPE
);

CREATE TABLE empleado (
    nombre                 VARCHAR(100) NOT NULL,
    apellido               VARCHAR(100) NOT NULL,
    id                     VARCHAR(7) NOT NULL,
    cargo                  VARCHAR(100) NOT NULL,
    correo                 VARCHAR(250) NOT NULL,
    numero_telefonico      VARCHAR(20) NOT NULL,
    departamento_trabajo   XMLTYPE,
    cedula                 VARCHAR(10) NOT NULL
);

CREATE TABLE estado (
    numero_revision   NUMBER(7) NOT NULL,
    revisado_por      VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    calidad           XMLTYPE,
    observaciones     XMLTYPE
);

CREATE TABLE permiso (
    numero_permiso    NUMBER(7) NOT NULL,
    id_autor          VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    detalle           VARCHAR(250) NOT NULL,
    estado            XMLTYPE,
	fecha_permiso     DATE NOT NULL,
    pedido            NUMBER(7)
);

CREATE TABLE pedido_pieza (
    numero_pedido         NUMBER(7) NOT NULL,
    departamento_destino  VARCHAR(20) NOT NULL,
    cantidad_piezas       VARCHAR(5) NOT NULL,
    estado                VARCHAR(13) NOT NULL,
    bodega_reclamo        VARCHAR(20) NOT NULL,
    fecha_pedido          DATE NOT NULL,
    fecha_llegada         DATE NOT NULL
);
