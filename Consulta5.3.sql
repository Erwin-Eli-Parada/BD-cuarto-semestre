/* Cosultas de la 6.3 -> 5.3*/

/* Consulta 1*/
select fecha,sum(precio_v * cantidad) 
from zapateria.zapato 
natural join zapateria.venta
natural join zapateria.detalle_venta 
where fecha >='2017-02-01' AND fecha <= '2017-02-28' group by fecha;

/* Consulta 2*/
select id_e,count(folio_v)
from zapateria.venta
group by id_e;

/* Consulta 3 */
select id_e,((current_date - fecha_nacimiento)/ 365) as edad from zapateria.empleado;

/* Consulta 4 */
select codigo,descripcion,precio_v,(precio_v-(precio_v * 25 / 100)) as nuevo_precio from zapateria.zapato;

/* Consulta 5*/
select A.id_e,nombre,turno
from zapateria.empleado as A
left outer join zapateria.venta  as B
on A.id_e = B.id_e
where B.folio_v is NULL;