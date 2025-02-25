#!/bin/bash
while true; do
    ping -c 1 10.45.1.10
    ping -c 1 10.45.0.121
    sleep 60
done
