#!/usr/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./logStreamCli.sh port destDir"
    echo "Example: ./logStreamCli.sh 31337 ../test/destDir"
    exit
fi

nc localhost $1 | ../client/demultiplexer.sh $2
