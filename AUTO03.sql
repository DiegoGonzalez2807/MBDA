CREATE TABLE Shift(Shift_date DATE, Shift_type VARCHAR(5),Manager VARCHAR(3), Operator VARCHAR(3), Engineer1 VARCHAR(3), Engineer2 VARCHAR(3));
CREATE TABLE Shift_type(Shift_type VARCHAR(5), Start_time TIME,End_time TIME);
CREATE TABLE Staff(Staff_code VARCHAR(3), First_name VARCHAR(10),Last_name VARCHAR(10), Level_code NUMBER(1)NOT NULL);
CREATE TABLE Level(Level_code NUMBER(1) NOT NULL , Manager VARCHAR(1),Operator VARCHAR(1), Engineer VARCHAR(1));
CREATE TABLE Issue(Call_date DATE, Call_ref NUMBER(4) NOT NULL,Caller_id NUMBER(5) NOT NULL, Detail VARCHAR(250), Taken_by VARCHAR(3), Assigned_to VARCHAR(3), Status VARCHAR(5));
CREATE TABLE Caller(Caller_id NUMBER(5) NOT NULL, Company_ref NUMBER(5) NOT NULL, First_name VARCHAR(10), Last_name VARCHAR(10));
CREATE TABLE Customer(Company_ref NUMBER(5) NOT NULL, Company_name VARCHAR(50),Contact_id NUMBER(5) NOT NULL, Address_1 VARCHAR(50), Address_2 VARCHAR(50), Town VARCHAR(20), Postcode VARCHAR(20), Telephone NUMBER(11));

/*ALTERACION PARA PONER LAS PRIMARY KEYS EN LAS TABLAS*/
ALTER TABLE Shift ADD CONSTRAINT PK_Shift_date PRIMARY KEY(Shift_date);

ALTER TABLE Shift_type ADD CONSTRAINT PK_Shift_date PRIMARY KEY(Shift_date);

ALTER TABLE Staff ADD CONSTRAINT PK_Staff_code PRIMARY KEY(Staff_code);

ALTER TABLE Level ADD CONSTRAINT PK_Level_code PRIMARY KEY(Level_code);

ALTER TABLE Issue ADD CONSTRAINT PK_Call_ref PRIMARY KEY(Call_ref);

ALTER TABLE Caller ADD CONSTRAINT PK_Caller_id PRIMARY KEY(Caller_id);

ALTER TABLE Customer ADD CONSTRAINT PK_Company_ref PRIMARY KEY(Company_ref);

/*ALTERACION PARA PONER LAS LLAVES UNICAS EN LAS TABLAS*/

ALTER TABLE Shift ADD CONSTRAINT UK_Operator UNIQUE(Operator);

ALTER TABLE Issue ADD CONSTRAINT UK_Detail UNIQUE (Detail);

ALTER TABLE Customer ADD CONSTRAINT UK_Company_name UNIQUE (Company_name);
ALTER TABLE Customer ADD CONSTRAINT UK_Telephone UNIQUE (Telephone);
ALTER TABLE Customer ADD CONSTRAINT UK_Postcode UNIQUE (Postcode);

/*ALTERACION PARA PONER LAS LLAVES FORANEAS EN LAS TABLAS*/;
ALTER TABLE Shift ADD CONSTRAINT FK_Shift_type FOREIGN KEY(Shift_type) REFERENCES Shift_type(Shift_type);
ALTER TABLE Shift ADD CONSTRAINT FK_Manager FOREIGN KEY(Manager) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Operator FOREIGN KEY(Operator) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Engineer1 FOREIGN KEY(Engineer1) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Engineer2 FOREIGN KEY(Engineer2) REFERENCES Staff(Staff_code);

ALTER TABLE Level ADD CONSTRAINT FK_Level_code FOREIGN KEY(Level_code) REFERENCES Staff(Level_code);

ALTER TABLE Staff ADD CONSTRAINT FK_Staff_code FOREIGN KEY(Staff_code) REFERENCES Issue(Assigned_to);

ALTER TABLE Issue ADD CONSTRAINT FK_Taken_by FOREIGN KEY(Taken_by) REFERENCES Shift(Operator);

ALTER TABLE Caller ADD CONSTRAINT FK_Caller_id FOREIGN KEY(Caller_id) REFERENCES Customer(Company_ref);
