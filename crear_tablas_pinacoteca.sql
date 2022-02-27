set search_path to CONACULTA;
create table Pinacoteca(
id_p varchar(20) primary key,
nombre varchar(50),
ciudad varchar(40),
superficie int
);
create table Escuela(
fecha_a date,
id_e varchar(15) primary key,
nombre varchar (40),
pais varchar(30)
);
create table Mecena(
id_m varchar(15) primary key,
nombre varchar(50),
fehca_n date,
pais varchar(30),
fecha_m date,
ciudad varchar(40),
relación varchar(30)
);
create table Pintor(
id_pintor varchar(15) primary key,
nombre varchar(50),
fecha_n date,
fecha_d date,
ciudad varchar(30),
pais varchar(30),
id_e varchar(15) references Escuela(id_e)
);
create table Cuadro(
codigo varchar(15) primary key,
id_p varchar(20) references Pinacoteca(id_p),
nombre varchar(30),
tecnica varchar(30),
fecha date,
id_pintor varchar(15) references Pintor(id_pintor)
);
create table Mestro_pintor(
id_m varchar(15) references Mecena(id_m),
id_pintor varchar(15) references Pintor(id_pintor)
);
create table Mecena_pintor(
id_maestro varchar(15) references Pintor(id_pintor),
id_discipulo varchar(15) unique references Pintor(id_pintor)
);


