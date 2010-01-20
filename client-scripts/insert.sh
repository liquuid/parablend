#!/bin/bash


rm -f /storage/.parablend/*/{power,status};
cp "$1" /storage/temp/;
DATA=`date +%Y%m%H%M%S`
echo "/storage/temp/$2 $DATA" > /storage/.parablend/queue;
xterm -rv -e "watch -n 1 /storage/bin/status.sh" &
sleep 1;
(  while [ `cat /storage/.parablend/*/status | grep BUSY | wc -l` -ne 0 ]; do echo 1; sleep 1; done | zenity --progress --pulsate --auto-close)  || (zenity --question --text="CANCELAR renderização" --ok-label="ENCERRAR RENDERIZAÇÃO" --cancel-label="Fechar essa janela" && ( zenity --info --title "Cancelado" --text "Renderização cancelada"; echo "KILL" > /storage/.killrender ; rm -fr /storage/temp/* /storage/.parablend/queue ) ) 
zenity --info --title "Feito" --text "Jobs encerrados";
if [ -x /storage/resultado-$DATA ]; then
nautilus /storage/resultado-$DATA;
fi;
