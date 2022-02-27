set search_path to zapateria;
/*1.-*/
select fecha,sum(precio_v * cantidad) 
from zapateria.zapato 
natural join zapateria.venta
natural join zapateria.detalle_venta 
where fecha >='2017-02-01' AND fecha <= '2017-02-28' group by fecha;

/*2.-*/
select id_e,count(folio_v)
from zapateria.venta
group by id_e;

/*3.-*/
select id_e,((current_date - fecha_nacimiento)/ 365) as edad 
from zapateria.empleado;

/*4.-*/
select codigo,descripcion,precio_v,(precio_v-(precio_v * 25 / 100)) as nuevo_precio
from zapateria.zapato
where id_prov = 1004;

/*5.-*/
select empleado.id_e,nombre,turno
from empleado
left outer join venta
on empleado.id_e = venta.id_e
where venta.folio_v is NULL;