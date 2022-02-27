
set search_path to zapateria;

/* 4.- LA SIGUIENTE FUNCION CALCULA LA SUMA ACUMULADA DEL MONTO
       VENDIDO POR MES DE LAS VENTAS DE UN MES ESPECIFICO, DADO EL MES
       EN LETRAS*/


create function calcula_monto_x_mes(varchar (20)) returns numeric as
$$
declare
    mes alias for $1;
    fecha1 date;
    fecha2 date;
    monto numeric:=0;
    

begin
    if mes='enero' then
    fecha1='2017-01-01';
    fecha2='2017-01-31';
    end if;
    if mes='febrero' then
    fecha1='2017-02-01';
    fecha2='2017-02-28';
    end if;
    if mes='marzo' then
    fecha1='2017-03-01';
    fecha2='2017-03-31';
    end if;
    if mes='abril' then
    fecha1='2017-04-01';
    fecha2='2017-04-30';
    end if;
    if mes='mayo' then
    fecha1='2017-05-01';
    fecha2='2017-05-31';
    end if;
    if mes='junio' then
    fecha1='2017-06-01';
    fecha2='2017-06-30';
    end if;
    if mes='julio' then
    fecha1='2017-07-01';
    fecha2='2017-07-31';
    end if;
    if mes='agosto' then
    fecha1='2017-08-01';
    fecha2='2017-08-31';
    end if;
                       
               monto=monto + (select sum(z.precio_v*dv.cantidad) from venta as v inner join detalle_venta as dv 
                                                                      on v.folio_v=dv.folio_v
                                                                   inner join zapato as z on dv.codigo=z.codigo
                                                                   where fecha between fecha1 and fecha2);                   
    return monto;
end
$$
language 'plpgsql' ;

select * from calcula_monto_x_mes ('febrero');

drop function calcula_monto_x_mes (varchar(20));