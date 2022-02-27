set search_path to zapateria;

/*EJERCICIO: Se requiere que dado el id del cliente, se obtengan los
registros de ventas en las que ha participado.*/

create or replace function cuantas_ventas (cliente int) returns table (nombre varchar(60),no_ventas bigint) as
$cuerpo$
	select c.nombre, count (v.folio_v) as no_ventas
	from cliente as c inner join venta as v on c.id_c=v.id_c
	where c.id_c=$1
	group by c.nombre;
$cuerpo$
language sql;

select * from cliente;

select * from cuantas_ventas(500);


/*Ejercicio: Se desea conocer los codigos y descripción de zapatos que me surte un proveedor, dado el 
           id del provedoor.*/

create function model_prov(identificador int) returns table (codigo_zap int, descripcion varchar(80), rz_proveedor varchar(40)) as
$$
select z.codigo, z.descripcion, p.razon_social
from proveedor as p inner join zapato as z on p.id_p=z.prov
where p.id_p=$1
order by z.descripcion asc
$$
language sql;

select * from model_prov(1005);

/*Se pide elaborar una función que dado un año, nos de los montos vendidos
  por mes, usando el numero para representar el mes*/

 mes    monto
 2      xx
 3      yy
 4      zz
 5      ww

 select extract (month from v.fecha) as mes, sum (z.precio_v*dv.cantidad) as monto
 from venta as v natural join detalle_venta as dv natural join zapato as z
 group by mes
 order by mes;

create or replace function monto_a(x double precision) returns table (mes double precision, monto numeric) as
$$
 select extract (month from v.fecha) as mes, sum (z.precio_v*dv.cantidad) as monto
 from venta as v natural join detalle_venta as dv natural join zapato as z
 where extract (year from v.fecha)=$1
 group by mes
 order by mes
$$
language sql;

select * from monto_a (2017);

 select extract (year from venta.fecha) as anio /*para saber que tipo de dato arroja la funcion extract*/
 from venta;

/*Se requiere una funcion SQL que proporcione el nombre, el monto vendido
  del empleado del mes y el bono de 15 %, para ello, se debe ingresar 
  el numero que corresponde al mes*/

  Nombre_empleado   monto_vendido        bono
  XXXXX                 $0000.00	$000.00


/* Lo primero es calcular la consulta en SQL, en este caso se utilizara
   subconsultas, para poder manipular la fecha cuando se convierta en función*/
   
select s1.nombre_empleado,s3.mx, (s3.mx*0.15) as bono
from (
  select e.nombre as nombre_empleado, sum (z.precio_v*cantidad) as monto
  from empleado as e natural join venta as v natural join detalle_venta as dv
       natural join zapato as z
  where extract (month from v.fecha) =6
  group by e.nombre
  order by nombre) as s1

  inner join 
		(select max (monto)as mx 
		from (select e.nombre as nombre_empleado, sum (z.precio_v*cantidad) as monto
			from empleado as e natural join venta as v natural join detalle_venta as dv
			natural join zapato as z
			where extract (month from v.fecha) =6
			group by e.nombre
			order by nombre) as s2) as s3 on s1.monto=s3.mx
  ;

/* Una vez que se ha hecho la subconsulta, se convierte a funcion SQL */
create or replace function emp_del_mes (m double precision) returns table (nom_empleado varchar, monto_vend numeric, bono numeric) as
$$
select s1.nombre_empleado,s3.mx, (s3.mx*0.15) as bono
from (
  select e.nombre as nombre_empleado, sum (z.precio_v*cantidad) as monto
  from empleado as e natural join venta as v natural join detalle_venta as dv
       natural join zapato as z
  where extract (month from v.fecha) =$1
  group by e.nombre
  order by nombre) as s1

  inner join 
		(select max (monto)as mx 
		from (select e.nombre as nombre_empleado, sum (z.precio_v*cantidad) as monto
			from empleado as e natural join venta as v natural join detalle_venta as dv
			natural join zapato as z
			where extract (month from v.fecha) =$1
			group by e.nombre
			order by nombre) as s2) as s3 on s1.monto=s3.mx
  ;
  $$ language sql;

  select * from emp_del_mes(3);
  
  