#! /usr/bin/python
# -*- encoding: utf-8 -*-

import mutagen
import mutagen.mp3
import mutagen.apev2

import sys

for fn in sys.argv[1:]:
	print('File: ' + fn)
	f = mutagen.File(fn)

	print('*** APEv2 ***')
	f.load(fn, ID3=mutagen.apev2.APEv2)
	f.pprint()
	f.delete()
	f.save()
