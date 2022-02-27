set search_path to zapateria;

select * from zapato;
1. TRIGGER QUE MODIFICA LA EXISTENCIA DE LA TABLA ZAPATO, EN LA MEDIDA
EN QUE SE REALIZAN VENTAS DE ESOS MODELOS DE ZAPATO.


/* PRIMERO SE CREA LA FUNCION Y LA DIFERENCIA AQUI ES QUE EN EL RETURNS DEBE LLEVAR LA PALABRA "trigger"*/

create function actual_ex() returns trigger as 
$$
declare
	aux1 int;
	aux2 int;

begin
	aux1:=new.cantidad;
	aux2:= (select existencia from zapato where codigo=new.codigo);
	
	if (aux1<aux2) then
	begin
		update zapato set existencia=existencia-aux1 where codigo=new.codigo;
		raise notice 'la actualización se llevo a cabo exitosamente';
		return new;
	end;
	else
	begin
		raise notice 'la cantidad que se quiere vender, no se tiene en existencia
		              solamente se tienen % pares',aux2;
		return null;
	end;
	end if; --se cierra el if que compara
end;
$$
language plpgsql;

/*  A CONTINUACION SE DEFINE EL DISPARADOR, QUE TABLA LO DISPARA Y QUE HARÁ CUANDO SE DISPARE*/

create trigger actualiza_existencia before insert on detalle_venta
for each row execute procedure actual_ex();


/* PREPARAMOS LAS TABLAS PARA EMPEZAR A USAR EL DISPARADOR*/

update zapato set existencia= 100;
select * from zapato;
delete from detalle_venta;
select * from detalle_venta;


EL DISPARADOR SE EJECUTARA CUANDO ENCUENTRE LA SIGUIENTE INSTRUCCION

insert into detalle_venta values (38001,8088,6);

select * from zapato;
se genera una variable new
 new

 folio_v      codigo    cantidad
 38001         8070	3

 new.folio_v=38001
 new.codigo=8070
 new.cantidad=3
select * from detalle_venta;

-- SI POR ALGUNA RAZON SE REQUIERE VOLVER A CREAR AL TRIGGER HAY QUE HACERLO
-- EN EL SIGUIENTE ORDEN
-- 1° SE ELIMINA EL TRIGGER
-- 2° SE BORRA LA FUNCION
drop trigger actualiza_existencia on detalle_venta;
drop function actual_ex();


