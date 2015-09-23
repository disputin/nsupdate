#!/bin/sh
# $Id$

# This section should be changed to support your server
KEY=/path/to/your/private.key
SERVER=localhost
ZONE=yourdomain.org
# Don't change below here

if [ $# -eq 2 ]; then
x=$2
oc1=${x%%.*}
x=${x#*.*}
oc2=${x%%.*}
x=${x#*.*}
oc3=${x%%.*}
x=${x#*.*}
oc4=${x%%.*}

REV=$oc4.$oc3.$oc2.$oc1
nsupdate -k $KEY -v << _ACEOF
server $SERVER
zone $ZONE
update delete $1.$ZONE. A

update add $1.$ZONE. 86400 A $2 

show
zone $oc3.$oc2.$oc1.in-addr.arpa.
update delete $REV.in-addr.arpa. PTR

update add $REV.in-addr.arpa. 86400 PTR $1.$ZONE.

show
send
_ACEOF

else
echo usage: nsupdate.pl hostname I.P.Add.ress
fi
