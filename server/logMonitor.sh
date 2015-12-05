#!/usr/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Invalid number of parameters"
    echo "Usage: ./logMonitor.sh fileWildcard monitorPeriodSec port"
    echo "Example: ./logMonitor.sh \"file*\" 1 31377"
    exit
fi

knownFiles=""
declare -A filesToWatch

trap 'kill $(jobs -p)' EXIT

while true
  do
    matcingFiles="$(find . -name "$1")"
    #echo $matcingFiles
    fileSet=(${matcingFiles// / })
    for i in "${!fileSet[@]}"
    do
        logFile=${fileSet[i]}
        logFile=$(echo "$logFile" | rev | cut -d"/" -f1 | rev)
        present=${filesToWatch[$logFile]}
        if [ "$present" != "1" ]
        then
          filesToWatch[$logFile]=1

          echo "Starting tailing and publishing logs from: $logFile"
          tail -n +1 -f $logFile | stdbuf -o0 sed -e "s/^/[$logFile] /" | nc localhost $3 &
        fi
    done
    sleep $2
  done
