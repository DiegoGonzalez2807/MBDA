CREATE ROLE Empleado
GRANT ALL
ON PedidoPieza
TO Empleado;

GRANT ALL
ON Permiso
TO Empleado;

GRANT SELECT
ON PiezaExtraccionPetrolera
TO Empleado;

GRANT SELECT
ON Inventario
TO Empleado;

GRANT SELECT
ON Bodega
TO Empleado;


/*Seguridad OK*/
ADD_PEDIDO(2135468,'Pozos Petroleros',10,'Aceptado','el carajito','14/ENE/2020 14:23','15/ENE/2020 14:23')
MOD_PERMISO(4646524,'E000100',200000,'Grande','Aceptado','14/ENE/2020 14:23',2135478)
RET_MES()

/*Seguridad NO OK*/
INSERT INTO Bodega (NombreBodega,municipio,departamento,proveedor) VALUES ('Bodega el carajito','floridablanca','cesar','pr1000')
INSERT INTO PiezaExtraccionPetrolera (Numero_serie,dimensiones,tipo) VALUES (25014,'<Dimensiones>
																						<TuboPVC>
																							<Diametro> 150mm </Diametro>
																							<Largo> 2000mm </Largo>
																						</TuboPVC>
																					</Dimensiones>', 'Tubo')
/*==========================================================*/

CREATE ROLE Experto
GRANT ALL
ON Estado
TO Experto

GRANT ALL
ON pedido_pieza
TO Experto

GRANT ALL
ON Permiso
TO Experto

GRANT ALL
ON PiezaExtraccionPetrolera
TO Experto

GRANT SELECT
ON Inventario
TO Experto

GRANT SELECT
ON Bodega
TO Experto

GRANT SELECT,INSERT
ON Revisa
TO Experto
/*Seguridad OK*/
DEL_PEDIDO(2054565)
MOD_ESTADO(3216548,'E001521',123123,'E',NULL)
ADD_PIEZA(25014,'Tubo','<Dimensiones>
							<TuboPVC>
								<Diametro> 150mm </Diametro>
								<Largo> 2000mm </Largo>
							</TuboPVC>
						</Dimensiones>')
ADD_PERMISO(2054565,'E001521',123123,'Grande','Aceptado','14/ENE/2020 14:23',5555555)

/*Seguridad NO OK*/
INSERT INTO Bodega (NombreBodega,municipio,departamento,proveedor) VALUES ('Bodega el carajito','floridablanca','cesar','PROV1000')
UPDATE Revisa SET IDInvetario = 15200 WHERE IDEmpleado = 500
INSERT INTO Proveedor(PK Codigo,UK Telefono,UK Correo) VALUES ('PROV200',3054522113,'123@gmail.com')

/*==========================================================*/

CREATE ROLE JefePersonal
GRANT ALL
ON Emplados
TO JefePersonal

GRANT ALL
ON Experto
TO JefePersonal

GRANT ALL
ON empleado_directo
TO JefePersonal

/*Seguridad OK*/
ADD_EMPLEADO('Santiago','Fetecua','E000100','Becario',NULL,3123233657,'<Tdepartamento>
    <Nombre>Pozos petroleros</Nombre>
    <Jefe_dpto>E0009856</Jefe_dpto>
    <Jefe_ingeniero>E0003255</Jefe_ingeniero>
    <Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>',1001464772)
MOD_EXPERTO('E001521','<Tdepartamento>
    <Nombre>Pozos petroleros</Nombre>
    <Jefe_dpto>E0009856</Jefe_dpto>
    <Jefe_ingeniero>E0003255</Jefe_ingeniero>
    <Jefe_tecnicos>E0009154</Jefe_tecnicos>
</Tdepartamento>')
DEL_DIRECTO('E000100')

/*Seguridad NO OK*/
INSERT INTO Bodega (NombreBodega,municipio,departamento,proveedor) VALUES ('Bodega el carajito','floridablanca','cesar','pr1000')

/*=========================================================*/

CREATE ROLE JefeInventarios
GRANT ALL
ON Bodega
TO JefeInventarios

GRANT ALL
ON Inventario
TO JefeInventarios

GRANT SELECT,UPDATE,INSERT
ON Revisa
TO JefeInventarios

GRANT SELECT 
ON Proveedores
TO JefeInventarios

GRANT SELECT
ON Empresa
TO JefeInventarios

GRANT SELECT
ON Persona_natural
TO JefeInventarios

GRANT SELECT,UPDATE
ON Provee
TO JefeInventarios

GRANT ALL
ON Contiene
TO JefeInventarios

/*Seguridad OK*/
ADD_BODEGA('Bodega el carajito','floridablanca','cesar','pr1000')
MOD_INVENTARIO('Bodega el carajito',123123,120)
ADD_REVISA('E000100',123123)
DEL_CONTIENE(123124)

/*Seguridad NO OK*/
INSERT INTO Provee (codigo_proveedor,nombre_bodega) VALUES ('PROV2','Bodega Central')

/*=========================================================*/

CREATE ROLE personaNatural
GRANT ALL
ON Proveedor
TO personaNatural

GRANT ALL
ON Persona_natural
TO personaNatural

GRANT SELECT,UPDATE
ON Provee
TO personaNatural

/*Seguridad OK*/
ADD_PROVEEDOR('PROV200',3057107112,'jajas@gmail.com','Cll 100 # 55-08','Bogota',NULL,2)
DEL_PERSONA_NATURAL('PROV200')

/*Seguridad NO OK*/
INSERT INTO Empresa(PK Codigo, UK NIT, UK Nombre, Direccion, Ciudad,Direccion_postal!,Telefono2!) VALUES ('PROV500',9010660059,'mcdonnalds','cll27Sur #1A-68','Cartagena',NULL,NULL)

/*=========================================================*/

CREATE ROLE empresa
GRANT ALL
ON Proveedor
TO empresa

GRANT ALL
ON Empresa
TO empresa

GRANT SELECT,UPDATE
ON Provee
TO empresa

/*Seguridad OK*/
ADD_PROVEEDOR('PROV201',3157107112,'jijijiPCHP@gmail.com','Cll 110 # 75-08','Bogota',NULL,22)
DEL_PERSONA_NATURAL('PROV201')

/*Seguridad NO OK*/
INSERT INTO Persona_juridica(PK Codigo, UK  Cedula, Nombre, Apellido, UK nit) VALUES ('PROV520',1001215177,'Miguel','perez',9010660058) 