# Script para listar inicios de sesión (ID 4624) entre dos fechas
param (
    [Parameter(Mandatory=$true)]
    [datetime]$FechaInicio,
    
    [Parameter(Mandatory=$true)]
    [datetime]$FechaFin
)

# Con addays pedimos que cuente el dia entero
$FechaFin = $FechaFin.AddDays(1)
Write-Host "Eventos de Inicio de Sesión:" -ForegroundColor Cyan

# Obtenemos los eventos de inicio de sesion entre las fechas
$eventos = Get-WinEvent -FilterHashtable @{
    LogName='Security'; 
    Id=4624; 
    StartTime=$FechaInicio; 
    EndTime=$FechaFin
}

# Listamos los evenenots ominitendo los de SYSTEM
foreach ($evento in $eventos) {
    $usuario = $evento.Properties[5].Value
    if ([string]::IsNullOrWhiteSpace($usuario) -or $usuario -match "^S-1-5-") {
         $usuario = $evento.Properties[6].Value
    }
    if (-not [string]::IsNullOrWhiteSpace($usuario) -and $usuario -notmatch "\$$" -and $usuario -ne "SYSTEM") {
        $fechaHora = $evento.TimeCreated.ToString("MM/dd/yyyy HH:mm:ss")
        Write-Host "Fecha: $fechaHora - Usuario: $usuario"
    }
}