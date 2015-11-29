#!/usr/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./logStreamSvr.sh filePattern port"
    echo "Example: ./logStreamSvr.sh ../test/file*.log 31337"
    exit
fi

tail -F $1 | nc -lk -p $2
