/* CONSULTAS DEL EJERCICIO 6.1 -> 5.1*/

/* Consulta 1*/
select * from zapateria.zapato where talla = 23;

/* Consulta 2*/
select * from zapateria.zapato where precio_v > 500;

/* Consulta 3*/
select * from zapateria.empleado where turno = 'matutino';

/* Consulta 4*/
select id_e,nombre,fecha_nacimiento from zapateria.empleado;

/* Consulta 5*/
select id_p,razon_social,e_mail 
from zapateria.proveedor 
where ciudad = 'oaxaca';