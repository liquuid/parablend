#!/bin/bash

export LC_ALL=C

# Diretorio base de trabalho

PARADIR="/storage/.parablend/"

# Pega interface de rede

IFACE=`LC_ALL=C route -n | tail -n 1 | awk '{ print $8}'`;

# Pega IP

IP=`LC_ALL=C ifconfig $IFACE  | grep "inet addr:" | cut -d':' -f 2 | cut -d' ' -f 1`;


MYD=$PARADIR/$IP

# verifica se a base existe

if  [ -x $MYD ];then 
	echo "$MYD existe"; 
else 
	echo "$MYD não existe" ;
	echo "criando ... \c" ;
	mkdir -p "$MYD" ;
        echo " feito" ;
fi

# verifica se o temp existe

if  [ -x $PARADIR/temp ];then 
	echo "$PARADIR/temp existe";
 
else 
	echo "$PARADIR/temp não existe";
	echo "criando ... \c"
	mkdir -p "$PARADIR/temp"  ;
        echo "feito"
fi

chown -R livre $PARADIR

# loop principal

while true; do
	echo "ON" > $MYD/power
	echo "IDLE" > $MYD/status
	if [[ "`cat $PARADIR/queue`" != '' ]] ;then
		BLEND=`cat $PARADIR/queue | cut -d' ' -f 1`;
		RESUL=`cat $PARADIR/queue | cut -d' ' -f 2`
		echo "BUSY $BLEND" > $MYD/status;
		blender -b $BLEND -a -t 0;
		if [ $? -eq 0 ] ; then 
			echo "IDLE" > $MYD/status ;
		        rm $PARADIR/queue
			RES=resultado-`date +%Y%m%H%M%`
			mkdir /storage/resultado-$RESUL
			mv $PARADIR/temp/* /storage/resultado-$RESUL
			chown -R livre /storage/resultado-$RESUL
		else 
			echo "ERROR" > $MYD/status >> $MYD;
		fi;

	else
		echo "não tem trabalho";
		echo "IDLE" > $MYD/status;
	fi;
#	echo $IP;
#	echo $IFACE;
	sleep 1;
done
