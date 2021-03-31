#! /bin/bash
exiftool '-filename<CreateDate' -d %y%m%d-%H%M%S%%-c.%%le .
