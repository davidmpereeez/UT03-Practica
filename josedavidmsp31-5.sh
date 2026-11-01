#!/bin/bash
#archivo de errores
INFORME="informe_errores.txt"
#Diseño del script
echo "=========================================" > $INFORME
echo " REPORTE DE ERRORES Y FALLOS EN /var/log " >> $INFORME
echo " Fecha: $(date)                          " >> $INFORME
echo "=========================================" >> $INFORME

#Nos aseguramos de que sea un archivo y no un direcotorio
for archivo in /var/log/*; do
    if [ -f "$archivo" ] && [ -r "$archivo" ]; then
        errores=$(grep -iIE "error|fail" "$archivo" 2>/dev/null)

# Separamos cada informe de errores para que sea mas visible
        
        if [ -n "$errores" ]; then
            echo -e "\n------------------------------------------------------------" >> $INFORME
            echo " ARCHIVO ORIGEN: $archivo" >> $INFORME
            echo "------------------------------------------------------------" >> $INFORME
            echo "$errores" >> $INFORME
        fi
    fi
done

echo "Mantenimiento completado. Aquí tienes el informe generado:"
echo ""
cat $INFORME