create schema FERRETERIA authorization postgres;
set search_path to FERRETERIA;
create table Fabricante(
id_fabricante varchar(20) primary key,
nombre varchar(50) notnull,
ciudad varchar(40),
contacto varchar(50),
tel_contacto int
);
create table Cliente(
id_cliente varchar(20) primary key,
nombre varchar(50),
domicilio varchar(40),
telefono int
);
create table Empleado(
id_empleado varchar(20) primary key,
nombre varchar(50),
turno varchar(10),
salario int check (salario>0)
);
create table Compra(
folio_c varchar(32) primary key,
fecha date,
observaciones varchar(50)
);
create table Supervisor(
id_supervisor varchar(20) references Empleado(id_empleado),
id_empleado varchar(20) unique references Empleado(id_empleado)
);
create table Producto(
codigo varchar(20) primary key,
precio_c int,
precio_v int,
descripcion varchar(50),
marca varchar(40),
longitud int,
peso int,
id_fabricante varchar(20) references Fabricante(id_fabricante)
);
create table Venta(
folio_v varchar(32) primary key,
fecha date,
id_cliente varchar(20) references Cliente(id_cliente),
id_empleado varchar(20) references Empleado(id_empleado)
);
create table Detalle_venta(
folio_v varchar(32) references Venta(folio_v),
cantidad int,
observaciones varchar(50),
codigo varchar(20) references Producto(codigo)
);
create table Detalle_Compra(
folio_c varchar(32) references Compra(folio_c),
codigo varchar(20) references Producto(codigo),
cantidad int,
observaciones varchar(50)
);
create table Contado(
folio_c varchar(32) unique references Compra(folio_c),
forma_pago varchar(30),
monto int
);
create table Credito(
folio_c varchar(32) unique references Compra(folio_c),
forma_pago varchar(30),
monto int,
no_pagos int
);