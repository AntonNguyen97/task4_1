#!/bin/bash
dir="$(pwd)"
exec 1> $dir/task4_1.out

echo "---Hardware---"
cpu=`lscpu | grep "Model name" | awk '{print $3,$4,$5}' || echo "Unknown"`
        echo "CPU: $cpu"

mem=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
        echo "RAM: $mem"

#manufacMB=`dmidecode -t baseboard | grep Manufacturer`
prodVers=`dmidecode -t baseboard | grep Version | awk '{print $2,$3}'`

echo "Matherboard:" ${prodVers:-Unknown}

sernum=`dmidecode -t system | grep "Serial Number" | awk '{print $3}' || echo "Unknown"`
        echo "System Serial Number:" ${sernum:-Unknown}

echo "---System---"

osDes=`cat /etc/issue.net`
         echo "OS Distribution: $osDes"
Kername=`uname -r`
         echo "Kernel version: $Kername"
instdate=`sudo tune2fs -l /dev/sda1 | grep create | awk '{print $3,$4,$5,$6,$7,$8}'`
         echo "Installation date: $instdate"
hostName=`uname -n`
         echo "Hostname: $hostName"
upTime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
         echo "Uptime: $upTime"

procRun=`ps -aux | wc -l`
         echo "Processes running: $procRun "
uLogIn=`who | wc -l`
         echo "User logged in: $uLogIn "
echo "---Network---"
for intFace in $(ifconfig | cut -d ' ' -f1| tr "\n" ' ') 
do
addr=$(ip -o -4 addr list $intFace | awk '{print $4}')
echo "$intFace:" ${addr:--}
done

