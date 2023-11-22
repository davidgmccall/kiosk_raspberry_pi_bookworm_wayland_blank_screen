#! /bin/bash

scriptDir="${0%/*}"
trap cleanup EXIT SIGTERM SIGKILL SIGABRT
function cleanup () {
    pkill -9 -ef 'blank_screen.bash'
}

${scriptDir}/blank_screen.bash 300 &

chromium-browser --pull-to-refresh=1 --hide-scrollbars --enable-features=OverlayScrollb,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter --kiosk --noerrdialogs --start-maximized "YOUR-URL"
