#! /bin/bash -e

inotifywait /etc/haproxy --event CLOSE_WRITE  --recursive --monitor --quiet --format '%w %e %T' --timefmt '%H%M%S'| while read -r file event tm 
do 
    current=$(date +'%H%M%S')
    delta=`expr $current - $tm`

    echo $file $event $tm
    if [ $delta -lt 2 -a $delta -gt -2  ] ; then
        sleep 1  # sleep 1 set to let file operations end
        echo "$CHANGED"
        systemctl restart haproxy.service
    fi
done
