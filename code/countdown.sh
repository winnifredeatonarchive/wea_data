#!/bin/bash
MIN_DEFAULT=15
SECS_DEFAULT=$(( $MIN_DEFAULT * 60 ))
secs=${1:-$SECS_DEFAULT}
while [ $secs -gt 0 ]; do
	printf "\rsleep: $((secs%3600/60))m:$((secs%60))s\033[0K"
    sleep 1
    : $((secs--))
done
printf "\n"