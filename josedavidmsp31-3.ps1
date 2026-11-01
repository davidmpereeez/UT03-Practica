# Script de menú interactivo para leer registros de eventos
do {
    Clear-Host
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "      MENÚ DE REGISTROS DE EVENTOS       " -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan

    $registros = Get-EventLog -List
    $i = 1
    
    foreach ($registro in $registros) {
        Write-Host "$i. $($registro.Log)"
        $i++
    }

    Write-Host "0. Salir"
    Write-Host "=========================================" -ForegroundColor Cyan

#Ofrecemos opciones 
    $opcion = Read-Host "Elige un número (0-$($registros.Count))"
#Ponemos opcion de salir del script en 0
    if ($opcion -eq '0') {
        Write-Host "`nSaliendo del programa..." -ForegroundColor Yellow
        break
    }
# Nos aseguramos que el valor ingresado es correcto
    if ($opcion -match "^\d+$" -and [int]$opcion -ge 1 -and [int]$opcion -le $registros.Count) {
        $indice = [int]$opcion - 1
        $registroElegido = $registros[$indice]
        $nombreRegistro = $registroElegido.Log
        
        Write-Host "`n Registro elegido: $nombreRegistro" -ForegroundColor Green
#Listamos los registros que hay y se imprira el que el usuario elige

        try {
            $totalEventos = $registroElegido.Entries.Count
            Write-Host "Total de eventos: $totalEventos" -ForegroundColor Yellow
            
            if ($totalEventos -gt 0) {
                Write-Host "Últimos 12 eventos:`n" -ForegroundColor Yellow
                Get-EventLog -LogName $nombreRegistro -Newest 12 | Select-Object TimeGenerated, EntryType, Source | Format-Table -AutoSize
            } else {
                Write-Host "Este registro está vacío." -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "Error de lectura. Ejecuta PowerShell como Administrador." -ForegroundColor Red
        }
    }
# Nos aseguramos de que no se eligan opciones no validas
    else {
        Write-Host "`n OPCIÓN NO VÁLIDA. Introduce un número de la lista." -ForegroundColor Red
    }
# Para poder elegir de nuevo, es necesario presionar ENTER
    Read-Host "`nPulsa INTRO para volver al menú..."
    
} while ($true)