#!/bin/bash

d=`dirname $0`
b=`basename $0 .command`
c=`echo $d/$b.sh`

`$c`

