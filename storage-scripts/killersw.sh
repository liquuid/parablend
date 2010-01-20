#!/bin/bash



while true; do 
if [ -f /storage/.killrender ]; then
	su livre -c "/usr/local/bin/pall.sh /storage/bin/kill.sh"
	rm /storage/.killrender
	sleep 5
fi;
sleep 1; 
done
