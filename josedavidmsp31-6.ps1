# Definimos la acción 
$accion = New-ScheduledTaskAction -Execute "gpupdate.exe" -Argument "/force"

# Definimos el desencadenador (Diariamente a las 6 de la mañana)
$desencadenador = New-ScheduledTaskTrigger -Daily -At 6am

# Registramos la tarea en el sistema
Register-ScheduledTask -TaskName "ActualizarGPO" -Action $accion -Trigger $desencadenador -User "System"