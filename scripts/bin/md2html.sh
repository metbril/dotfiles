#!/bin/bash
for file in *.md
do
  pandoc -f markdown -t html -o "$file.html" "$file"
done
