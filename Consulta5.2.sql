/* Consulta de la 1*/
select nombre 
from zapateria.empleado
natural join zapateria.venta
where fecha >= '2017-05-01' AND fecha <= '2017-05-31';

/*select * from zapateria.empleado natural join zapateria.venta;*/

/* Consulta de la 2*/
select razon_social from zapateria.proveedor 
natural join zapateria.compra  
where fecha >= '2017-03-01' AND fecha <= '2017-03-31'
UNION
select nombre from zapateria.empleado  
natural join zapateria.compra  
where fecha >= '2017-03-01' AND fecha <= '2017-03-31';

/* Consulta de la 3*/
(select codigo,descripcion
from zapateria.zapato
natural join zapateria.det_compra
natural join zapateria.compra
where fecha >= '2017-05-01' AND fecha <= '2017-05-31')
EXCEPT(
select codigo,descripcion
from zapateria.zapato
natural join zapateria.det_compra
natural join zapateria.compra
where fecha >= '2017-04-01' AND fecha <= '2017-04-30');


/* Consulta de la 4*/
select codigo, descripcion
from zapateria.zapato 
natural join zapateria.venta
natural join zapateria.detalle_venta
where fecha < '2017-06-01' OR fecha > '2017-06-30';

/* Consulta del ejercicio 5*/
select id_e, nombre from zapateria.empleado
  EXCEPT(
	select id_e, nombre from zapateria.empleado
	natural join zapateria.venta
	where fecha >= '2017-04-01' AND fecha <= '2017-04-30'
	);

