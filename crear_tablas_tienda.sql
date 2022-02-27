set search_path to tienda;
create table Proveedor(
RFC varchar(13) primary key,
nombre varchar(50),
tel_c int,
email varchar(30)
);
create table Producto(
codigo varchar(8) primary key,
descuento int,
marca varchar(30),
clasif varchar(30),
exist int
);
create table Empleado(
RFC_E varchar(13) primary key,
nombre varchar(50),
domic varchar(50),
fecha_n date,
puesto varchar(30),
turno varchar(10)
);
create table Cliente(
RFC varchar(13),
id_c varchar(20) primary key,
nombre varchar(40),
tel_c int
);
create table Compra(
RFC varchar(13) references Proveedor(RFC),
folio_c varchar(20) primary key,
fecha date,
hora time
);
create table Detallecompra(
folio_c varchar(20) references Compra(folio_c),
codigo varchar(8) references Producto(codigo),
precio_c int
);
create table Venta(
RFC_E varchar(13) references Empleado(RFC_E),
id_c varchar(20) references Cliente(id_c),
folio_v varchar(20) primary key,
hora time,
fecha date
);
create table Detalleventa(
codigo varchar(8) references Producto(codigo),
folio_v varchar(20) references Venta(folio_v),
cantidad int,
precio int
);