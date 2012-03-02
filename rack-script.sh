#!/bin/sh

#value=`nslookup $1 | grep name | awk '{print \$4}'`
echo $@ >> /tmp/rack.out
for ARG in "$@"
do
    if [[ "$ARG" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        name=`nslookup $ARG | grep name | awk '{print \$4}'`
        site=`expr "$name" : '.*\.\([a-zA-Z0-9]*\.[a-zA-Z0-9]*\).$'`
    else
        site=`expr "$ARG" : '.*\.\([a-zA-Z0-9]*\.[a-zA-Z0-9]*\)$'`
    fi
    echo /${site//\./\/}
done
