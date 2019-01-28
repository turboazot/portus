#!/bin/sh

cp /secrets/portus.crt /usr/local/share/ca-certificates
update-ca-certificates

pidfile=/var/run/registry.pid

start () {
    /entrypoint.sh /etc/docker/registry/config.yml $@ &
    echo $! > $pidfile
    echo "Process has been runned with PID = `cat $pidfile`"
}

stop () {
    kill $(cat $pidfile)
    echo "Process has been stopped"
}

garbage_collect () {
    stop
    registry garbage-collect /etc/docker/registry/config.yml
    echo "Garbage collected!"
    start
}

crond
start
trap garbage_collect 1

while sleep 10; do
    ps aux | grep 'registry serve' | grep -q -v grep
    PROCESS_STATUS=$?

    if [[ $PROCESS_STATUS -ne 0 ]]; then
        echo "Health check failed!"
        exit 1
    fi
done
