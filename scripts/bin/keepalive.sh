#!/bin/sh

while [ true ]; do
    ping -q -c 5 www.google.com 
    sleep 60
done
