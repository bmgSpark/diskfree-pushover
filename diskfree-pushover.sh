#! /usr/bin/env bash
let notify=75
let criticalnotify=90
let doAct=0
let percval=`df -h | grep -i /dev/md0 |  awk '{ print +$5 }'`
echo percval = $percval
echo notify = $notify
sSev="INFO"

if [ $percval -ge $criticalnotify ]; then
      echo "we should notify as CRITICAL as $percval is  gte than $criticalnotify"
      let doAct=99
      #critical notify
      sSev="CRIT"

elif [ $percval -ge $notify ]; then
       echo "we should notify as $percval is  gte than $notify"
       let doAct=1
       sSev="WARN"
else
       echo no notification needed $percval less than $notify
fi

echo doAct =  $doAct
echo "magic severity = $sSev ... DOACT = $doAct"
if [ $doAct -gt 0  ] ; then
	echo "Sending Pushover using curl with $sSev"
	curl -s \
        	-F "token=aa9261w246j1sfikk7gvm2mj8p9off" \
        	-F "user=uCW7BtLyXphmjNy8yMPWoZPPrdaWVV" \
        	-F "title=DiskFree Alert sev: $sSev" \
        	-F "message=DiskFree Perc: $percval %" \
        http://api.pushover.net/1/messages > /dev/null





fi
