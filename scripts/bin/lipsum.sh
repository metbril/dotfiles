#!/bin/bash
number=1000
i=1
while [ "$i" -le "$number" ]; do

  slug=$(date +%s)-$(printf "%03d" $i)

#   slug=$(date +%s)

  # be nice, don't hammer the api ;-)
  sleep .1

  loripsum=`curl -s https://loripsum.net/api/5/medium/plaintext/headers`
  title=`echo "${loripsum}" | head -1`

  text=""
  text+="---\n"
  text+="title: $title\n"
  text+="slug: $slug\n"
  text+="date: '$(date +%Y-%m-%dT%H:%M:%S%z)'\n"
  text+="---\n"
  text+=$loripsum

  mkdir -p $slug
  echo -e "$text" > $slug/item.md
  
#   curl https://loripsum.net/api/5/medium/plaintext/headers

  echo $i van $number

  
  i=$(($i + 1))
done
