set search_path to zapateria;
/* 1.-*/
select nombre 
from empleado
natural join venta
where fecha >= '2017-05-01' AND fecha <= '2017-05-31';

/*2.-*/
select razon_social 
from proveedor 
natural join compra  
where fecha >= '2017-03-01' AND fecha <= '2017-03-31'
UNION
select nombre 
from empleado  
natural join compra  
where fecha >= '2017-03-01' AND fecha <= '2017-03-31';

/* 3.-*/
(select codigo,descripcion
from zapato
natural join det_compra
natural join compra
where fecha >= '2017-05-01' AND fecha <= '2017-05-31')
EXCEPT(
select codigo,descripcion
from zapato
natural join det_compra
natural join compra
where fecha >= '2017-04-01' AND fecha <= '2017-04-30');

/*4.-*/
select codigo, descripcion
from zapato 
natural join venta
natural join detalle_venta
where fecha < '2017-06-01' OR fecha > '2017-06-30';

/*5.-*/
select id_e,nombre 
from empleado
EXCEPT(
select id_e,nombre
from empleado
natural join venta
where fecha >= '2017-04-01' AND fecha <= '2017-04-30'
);

