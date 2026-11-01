#!/bin/bash

# Comprobamos que el archivo programas.txt existe en el mismo directorio
if [ ! -f "programas.txt" ]; then
    echo "Error: No se encuentra el archivo 'programas.txt'."
    exit 1
fi

# Leemos el archivo línea por línea
while IFS= read -r programa; do
    if [ -n "$programa" ]; then
        echo "============================================="
        echo "Comprobando el programa: $programa"

        # Verificamos si el programa está instalado
        if dpkg -l | grep -q -w "^ii  $programa"; then
            echo "El programa '$programa' está instalado. Procediendo a desinstalar..."
            sudo apt-get purge -y "$programa"
            echo "Desinstalación de '$programa' completada."
        else
            echo "Aviso: El programa '$programa' no está instalado. Pasando al siguiente..."
        fi
    fi
done < "programas.txt"

echo "============================================="
echo "Proceso finalizado."
