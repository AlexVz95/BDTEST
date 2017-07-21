--Empleados forma de Pago
select ECNumeroEmpleado, ISNULL(' '+EMApellidoPaterno,'') + ISNULL(' '+EMApellidoMaterno,'')+ isnull(' ' +EMNombre1,'') + ISNULL(' '+ EMNombre2,''), PONombre,
FechaSol=(SELECT MIN(SOFechaAprovacion) FROM ff_solicitud ss WHERE ss.soidvigencia= s.soidvigencia and s.sonumempleado=ss.SONumEmpleado and s.soidempresa=ss.soidempresa) 
from ff_edocuenta
inner join ff_Empleado on ID=ECidEmpleado
inner join ff_solicitud s on ECidSolicitud=SOIdSolicitud
Inner join ff_PlanOpcion o on POidPlanOpcion = ecidPlanOpcion 
where ecidestatus=1 and ecidempresa=419 and SONumEmpleado not like 'test%' --and ECidEstatus=1 and ECidConcepto =6 and ECTipoMovto=1
and ecidplanopcion in( Select POidPlanOpcion  from ff_planopcion where poidplan =1289)
--and ECidEmpleado in(select ecidempleado from ff_EdoCuenta where ECidEstatus=1 and ECidPlanOpcion  in (5244))
--and sofechaadd>='2015-12-01' 
-- Select ponombre from ff_planopcion where poidplan =1289
and SOEstatusSolicitud=1 
order by SONumEmpleado, FechaSol 

Select SONumEmpleado, ISNULL(' '+EMApellidoPaterno,'') + ISNULL(' '+EMApellidoMaterno,'')+ isnull(' ' +EMNombre1,'') + ISNULL(' '+ EMNombre2,''), plnombre,
SUM(POCostoRestante) as monto
,(Select ponombre from ff_planopcion where poidplan =1289 and poidplanopcion in(select poidplanopcion FROM FF_planopcionseleccion where poidsolicitud= soidsolicitud and POidplanopcion in( Select POidPlanOpcion  from ff_planopcion where poidplan =1289)))   
from ff_solicitud 
inner join ff_Empleado on ID=SOIdEmpleado
inner join ff_PlanOpcionSeleccion p on POidSolicitud = SOIdSolicitud  
Inner join ff_PlanOpcion o on p.POidPlanOpcion = o.POidPlanOpcion and o.POidPlanOpcion not in( Select POidPlanOpcion  from ff_planopcion where poidplan =1289)
inner join ff_Plan on o.POidPlan=PLidPlan 
where SOIdEstatus=1 AND SOEstatusSolicitud=1 and SOIdEmpresa=419 and SONumEmpleado not like 'test%' --and ECidEstatus=1 and ECidConcepto =6 and ECTipoMovto=1
--and ECidEmpleado in(select ecidempleado from ff_EdoCuenta where ECidEstatus=1 and ECidPlanOpcion  in (5244))
--and sofechaadd>='2015-12-01' 
-- Select ponombre from ff_planopcion where poidplan =1289
AND POCostoRestante >0
group by SOIdSolicitud, SONumEmpleado,EMApellidoPaterno,EMApellidoMaterno,EMNombre1,EMNombre2,plnombre 