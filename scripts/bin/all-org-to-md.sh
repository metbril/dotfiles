#!/bin/bash
for file in *.org
do
	pandoc -f org -t markdown -o $file.md $file
done
