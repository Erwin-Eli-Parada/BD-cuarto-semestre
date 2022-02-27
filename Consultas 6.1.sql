set search_path to zapateria;
/* Consulta 1*/
select * from zapato where talla = 23;

/* Consulta 2*/
select * from zapato where precio_v > 500;

/* Consulta 3*/
select * from empleado where turno = 'matutino';

/* Consulta 4*/
select id_e,nombre,fecha_nacimiento 
from empleado;

/* Consulta 5*/
select id_p,razon_social,e_mail 
from proveedor 
where ciudad = 'oaxaca';