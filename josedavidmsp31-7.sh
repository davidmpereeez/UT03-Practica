#!/bin/bash

# Fichero donde guardaremos el registro
LOG_FILE="/var/log/ocupacion_discos.log"
UMBRAL=80

# Usamos df -h para ver discos, tail -n +2 quita la cabecera,
# awk extrae la partición ($1) y el uso ($5).
df -h | tail -n +2 | awk '{ print $1 " " $5 }' | while read particion uso; do
    
    uso_numero=$(echo "$uso" | tr -d '%')
    
    if [[ "$uso_numero" =~ ^[0-9]+$ ]]; then
        if [ "$uso_numero" -gt "$UMBRAL" ]; then
            fecha=$(date '+%Y-%m-%d')
            hora=$(date '+%H:%M:%S')
            echo "[$fecha $hora] ALERTA: La partición $particion está al $uso de capacidad." >> "$LOG_FILE"
        fi
    fi
done