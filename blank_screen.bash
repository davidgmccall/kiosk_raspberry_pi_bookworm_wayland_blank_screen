#! /bin/bash

scriptDir="${0%/*}"
blankSecs=${1:-300}
blankImage=$(readlink -e ${scriptDir}/black-512x512.png)
blankPid=
keysLog=$(mktemp --tmpdir=/tmp keyd-XXXXXXXX.log)
keysTime=$(mktemp --tmpdir=/tmp keyd-XXXXXXXX.time)

trap cleanup EXIT SIGTERM SIGKILL SIGABRT
function cleanup () {
    sudo pkill -ef '^keyd -m'
    if [[ ${blankPid} ]] ; then
        kill ${blankPid}
    fi
    rm -fv ${keysLog}
    rm -fv ${keysTime}
    reset
}

sudo keyd -m &> ${keysLog} &
reset

isBlank=0
while sleep 1; do
    if tail -n 2 ${keysLog} | grep -q 'q down' &>/dev/null ; then
        exit
    fi

    if (( ! isBlank )) ; then
        touch --date="${blankSecs} secs ago" ${keysTime}
    fi

    if [[ $isBlank == 0 && ${keysLog} -ot ${keysTime} ]] ; then
        pqiv --fullscreen --hide-info-box --fade ${blankImage} &
        blankPid=$!
        isBlank=1
    elif [[ $isBlank == 1 && ${keysLog} -nt ${keysTime} ]] ; then
        if [[ ${blankPid} ]] ; then
            kill ${blankPid}
            blankPid=
        fi
        isBlank=0
    fi
done

