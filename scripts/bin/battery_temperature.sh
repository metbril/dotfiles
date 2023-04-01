#!/bin/bash
# battery_temperature for mac osx 10.9.2
if [ `uname` == "Darwin" ]; then
 
  if [ "$1" == "-h" ]; then
    echo "Usage: $(basename $0 ".sh") [option]"
    echo "  -l also show Model Name and Processor Name"
    echo "  -h display this help message"
    exit
  fi
 
  # -l display Model Name and Processor Name
  if [ "$1" == "-l" ]; then
    system_profiler SPHardwareDataType | awk '/Model Name/ || /Chip/' | sed 's/[^:]*: //' | awk '{ printf $0 "  " }'
    echo
  fi
 
  # sensor data
  temperature=`ioreg -r -n AppleSmartBattery | grep \"Temperature\" | cut -c23-`
  temperature_celsius=`echo $temperature / 100.0 | bc`
  echo "AppleSmartBattery Temperature: "
  echo $temperature_celsius °C
  temperature_fahrenheit=`echo "($temperature_celsius * (9 / 5)) + 32.0" | bc`
  echo $temperature_fahrenheit °F
 
# error message if unsupported machine
else
  echo -e "\nThis appears not to be an OS X machine\n"
fi
