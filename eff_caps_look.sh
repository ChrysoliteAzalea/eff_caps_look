#!/usr/bin/bash

function printcaps {
caps=`cat /proc/$1/status | grep CapEff | sed "s/CapEff[^0-9a-f]*//g;"`
name=`cat /proc/$1/comm`
echo -n "Effective capabilities of $1 ($name): "
echo `capsh --decode=$caps`
}

function rcall {
printcaps $1
childprocesses=`ps -o pid= --ppid $1`
for i in $childprocesses
do
rcall $i
done
}

[ $# -ge 1 ] && rcall $1
