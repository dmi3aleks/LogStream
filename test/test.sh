#!/usr/bin/bash

echo "This test starts three processes producing logs so that log stream could tail and stream them out"

bindPort=31337

cwd=$(pwd)

rm "$cwd/sourceDir/*"
rm "$cwd/destDir/*"

# When this exits, exit all back ground process also.
trap 'kill $(jobs -p)' EXIT

# Start log producers
./logProducer.sh "Some data 01" 1 > "$cwd/sourceDir/file01.log" &
./logProducer.sh "Another data 02" 2 > "$cwd/sourceDir/file02.log" &
./logProducer.sh "Yet another data 03" 3 > "$cwd/sourceDir/file03.log" &

# Start the log stream server
$cwd/../server/logStreamSvr.sh "$cwd/sourceDir/*.log" $bindPort &

# Start the log stream client
../client/logStreamCli.sh $bindPort ../test/destDir/

# Multitail logs in the destination directory to show that replication is working
tail -F "$cwd/destDir/*"

# wait .. until CTRL+C
wait
