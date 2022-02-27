set search_path to zapateria;
/* Cuantas veces ha participado un cliente en una venta, dado 
el nombre del cliente*/
create or replace function participa_cliente (nom varchar(60), mes int) returns table(nomb varchar(60), fecha date, monto numeric(10,2), folio_v int) as
$$
declare
	mes1 int; --Definicion de variables
begin

mes1:= mes;
if(mes1>=1 and mes1<=12) then 	--Validacion de un mes valido
return query 

--Consulta para regresar cuantas veces ha participado el cliente en una venta
select nombre, venta.fecha, sum(precio_v*cantidad) as monto, venta.folio_v
from venta natural join detalle_venta natural join cliente natural join zapato
where upper(nombre) like upper(nom) and date_part('month',venta.fecha) = mes1
group by nombre,venta.folio_v;

    if not found then		/*Si no encuentra mandar una excepcion*/
        raise exception 'No hay Registros';
    end if;
	
else raise exception 'No es un mes valido';	--
end if;

end
$$language plpgsql;
select * from cliente;

select * from participa_cliente('Juan Pérez',8);

