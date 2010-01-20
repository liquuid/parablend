IPS='201 202 203 204 205 206 207 208 209 210'

for i in $IPS; do (ssh root@192.168.1.$i $1 &) ; done
