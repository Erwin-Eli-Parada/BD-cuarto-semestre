create schema CONGRESO authorization postgres;
set search_path to CONGRESO;
create table Participante(
lugar_o varchar(50),
institucion varchar(50),
fecha_n date,
apellidos varchar(40),
tipo varchar(25),
nombre varchar(40)not null,
id_participante int primary key,
Exclude (id_participante with &&)
);
create table Sala(
horario time,
id_sala int primary key
);
create table Pago(
costo_t int check (costo_t>0),
folio_p int primary key,
id_participante int unique references Participante(id_participante)
);
create table Actividad(
costo int,
fecha date,
id_actividad varchar(10) primary key,
folio_d int references Pago(folio_p)
);
create table Diploma(
folio_d int primary key,
id_actividad varchar(10) unique references Actividad(id_actividad),
id_participante int references Participante(id_participante)
);
create table Asistente(
area_interes varchar(30),
id_participante int unique references Participante(id_participante)
);
create table Asistente_actividad(
id_participante int references Asistente(id_participante),
id_actividad varchar(10) references Actividad(id_actividad)
);
create table Ponente(
nombre_ponencia varchar(50),
id_participante int unique references Participante(id_participante)
);
create table Ponencia(
fecha date,
id_sala int unique references Sala(id_sala),
id_ponente int references Ponente(id_participante) 
);
create table Conferencista_magistral(
nombre_conferencia varchar(50),
id_participante int unique references Participante(id_participante)
);
create table conferencia(
fecha date,
id_conferencista int unique references Conferencista_magistral(id_participante),
id_sala int unique references Sala(id_sala)
);