set search_path to zapateria;
-- 5. Dado un folio de devolución que indique a que folio de venta corresponde, el
--    nombre del cliente y que zapatos y cantidades devolvi0.

create or replace function datos_dev (int) returns table(folio int, nomb varchar(60), zap varchar(80), cant int, fech date) as
$$

begin

return query 

--Consulta para determinar el folio de venta que corresponde a un folio de devolucion
select folio_v, nombre, descripcion, cantidad, fecha_devolucion
from 

(select folio_dev, folio_v, fecha_devolucion from devolucion) as c natural join (select folio_dev, codigo, cantidad from detalle_devolucion) as c1
natural join zapato as z
natural join venta as n
natural join cliente

where folio_dev = $1 
;

 if not found then --Si no hay registros lanzar una excepcion
 raise exception 'No hay Registros';
 end if;
	

end
$$language plpgsql;



select * from datos_dev(11003);

select * from detalle_devolucion where folio_dev=11003;

select * from zapato where codigo = 8068;