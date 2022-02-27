/*
Las reglas de integridad a aplicar seran:
1.-la regla de integridad primary keys, la cuál se esta aplicando en todas las llaves primarias de las tables fuertes
2.-la regla not null, la cual nos indica que el atributo marcado con la palabra reservada not null (en este caso la id_editorial) no tenga valores nulos,
   en este caso tambien contamos con que not null , lo aplica postgres por defecto 
3.-check constrains en este caso se representa en la tabla Libro al especificarle que u libro no tiene menos de 1 pagina usando la palabra reservada check
4.-la regla de foreing keys se aplica a todas las tablas que que tengan llaves foraneas usando la palabra reservada references haciendo que dependan de la
   llave primaria a la que se estan referenciando
5.-y por último exclusion constrains que nos indica una forma de "ordenar" los datos de acuerdo a una forma establecida y checar que no haya datos repetidos,
   en la tabla Editorial usamos la  palabra exclude y el dato por el que se a ordenar (di_editorial) y la forma que lo hara (en este caso usando el operador =)
*/
create extension btree_gist;
create schema Biblioteca authorization postgres;
set search_path to Biblioteca;
create table Editorial(
E_mail varchar(50),
telefono_c int,
id_editorial int primary key not null,
nombre varchar(50),
pais varchar(25),
domicilio varchar(40),
ciudad varchar(50),
Exclude USING gist(id_editorial with =)
);
create table Autor(
nombre_a varchar(50),
fecha_n date,
id_autor int primary key
);
create table Empleado(
id_empleado int primary key,
fecha_n date,
nombre varchar(50),
domicilio varchar(50),
telefono int
);
create table Usuario(
nombre varchar(50),
telefono int,
domicilio varchar(50),
no_usuario int primary key
);
create table Libro (
no_paginas int check (no_paginas>0),
ISBN int primary key,
titulo varchar(50),
anio_publicacion date,
pais_ubicacion varchar(50),
id_editorial int references Editorial(id_editorial)
);
create table Ejemplar(
no_ejemplar int primary key,
disponible boolean,
estado_conserv varchar(50),
ISBN int references Libro(ISBN)
);
create table Prestamo(
fecha_prestamo date,
fecha_devolucion date,
folio_prestamo int primary key,
no_usuario int references Usuario(no_usuario),
id_empleado int references Empleado(id_empleado)
);
create table Profesor(
no_tarjeta int,
area varchar(50),
titulo varchar(50),
no_usuario int unique references Usuario(no_usuario)
);
create table Estudiante(
carrera varchar(50),
no_control int,
no_usuario int unique references Usuario(no_usuario)
);
create table Autor_Libro(
ISBN int references Libro(ISBN),
id_autor int references Autor(id_autor)
);
create table Ejemplar_Prestamo (
no_ejemplar int references Ejemplar(no_ejemplar),
folio_prestamo int references Prestamo(folio_prestamo)
);
create table Devolucion(
fecha_devolucion date,
observacion varchar(100),
estado_dev varchar(50),
id_ejemplar int,
folio_prestamo int references Prestamo(folio_prestamo)
);
create table Empleado_Supervisor(
id_supervisor int references Empleado(id_empleado),
id_empleado int unique references Empleado(id_empleado)
);