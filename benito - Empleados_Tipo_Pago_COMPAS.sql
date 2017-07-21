select ECNumeroEmpleado, ISNULL(' '+EMApellidoPaterno,'') + ISNULL(' '+EMApellidoMaterno,'')+ isnull(' ' +EMNombre1,'') + ISNULL(' '+ EMNombre2,''),ECCantidad /11, * 
from ff_edocuenta
inner join ff_Empleado on ID=ECidEmpleado
inner join ff_solicitud on ECidSolicitud=SOIdSolicitud
where ecidestatus=1 and ecidempresa=419 and ecnumeroempleado not like 'test%' and ECidEstatus=1 and ECidConcepto =6 and ECTipoMovto=1
and ECidEmpleado in(select ecidempleado from ff_EdoCuenta where ECidEstatus=1 and ECidPlanOpcion  in (5247))
and sofechaadd>='2016-12-01' and SOEstatusSolicitud=1

/*
select * from ff_planOpcion where poIdPlan=1289

5244	1289	PAGO MENSUAL
5245	1289	PAGO TRIMESTRAL
5246	1289	PAGO SEMESTRAL
5247	1289	PAGO ANUAL
*/