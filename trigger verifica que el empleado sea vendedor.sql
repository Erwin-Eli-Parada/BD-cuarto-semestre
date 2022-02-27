set search_path to zapateria;

-- SE REQUIERE VERIFICAR QUE EL QUE REALIZA LA VENTA SEA UN EMPLEADO DE TIPO "VENDEDOR"
-- PRIMERO SE CRREA LA FUNCION QUE HARA LA VERIFICACION

CREATE FUNCTION si_empleado() RETURNS trigger AS
$$
declare --se declaran las variables auxiliares
	id_aux int;
begin--después 
	id_aux:=new.id_e;--se almacena en una variable el valor del identiticador del empleado
	if(id_aux in (select v.id_e from empleado as v where puesto like 'vendedor' and id_e=id_aux)) then --si el id es de un vendedor puede relizar la venta
		return new;
        else
		raise exception 'No eres un vendedor, no puedes realizar una venta'; --se le dirá que no es un vendedor 

	end if;
end
$$
  LANGUAGE plpgsql;

-- DESPUES SE DEFINE EL DISPARADOR Y SE ASOCIA A LA TABLA

 create trigger verifica_empleado before insert on venta
 for each row execute procedure si_empleado();

-- SI POR ALGUNA RAZON SE REQUIERE VOLVER A CREAR AL TRIGGER HAY QUE HACERLO
-- EN EL SIGUIENTE ORDEN
-- 1° SE ELIMINA EL TRIGGER
-- 2° SE BORRA LA FUNCION

--drop trigger verifica_empleado on venta;

drop trigger veri_vendedor on venta;
drop function si_empleado();

select * from venta;


select * from empleado where puesto='vendedor';

insert into venta values (38056,current_date,530,8);
insert into venta values (38057,current_date,503,6);

delete from venta where folio_v=38056;