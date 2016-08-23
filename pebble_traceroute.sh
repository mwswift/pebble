#!/bin/bash

#####################
# pebble_traceroute.sh
# Michael Swift, Daniel Ish
# Summer 2016
#####################

usage="$(basename "$0") [-h] [-w num] [-s num] [-i address] 
-- program to continuously run a traceroute command in order to 
   test our internet connection and collect data on drops

options:
    -h  show this help text
    -w  traceroute wait time in seconds (must be an integer) (default: 1)
    -s  sleep time between traceroute calls in seconds (default: 1)
    -i  address to ping (default: 8.8.8.8, Google public DNS a)"

# Parse input
# from http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
wait_time=1
sleep_time=1
ip_address="8.8.8.8"
start=`date`

while getopts "hw:s:i:" opt; do
    case "$opt" in
    h)  echo "$usage"
		exit
		;;
    w)  wait_time=$OPTARG
        ;;
    s)  sleep_time=$OPTARG
        ;;
    i)  ip_address=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "+++++++++++++++++"
echo "pebble Traceroute"
echo "+++++++++++++++++"
echo
echo "Timeout wait time: $wait_time second(s)."
echo "Loop delay: $sleep_time second(s)."
echo "Pinging address: " $ip_address
echo "Start time: " $start
echo

# actual loop
while :; 
do 
	# print Unix time with nanoseconds.  
	# Note %N option doesn't work on Mac
	date +%s%N
	# run the traceroute command
	traceroute -q 1 -w $wait_time $ip_address 2>/dev/null
	# delay before next loop iteration
	sleep $sleep_time
done
