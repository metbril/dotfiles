#! /bin/bash
exiftool "-FileCreateDate<DateTimeOriginal" "-FileModifyDate<DateTimeOriginal" '-filename<CreateDate' -d %Y%m%d-%H%M%S%%-c.%%le .
