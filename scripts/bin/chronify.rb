#!/usr/bin/ruby
 
# chronify.rb
# Robert van Bregt
# Dit werk is gelicenseerd onder een Creative Commons Naamsvermelding-NietCommercieel 3.0 Nederland. Bezoek http://creativecommons.org/licenses/by-nc/3.0/nl/ om een kopie te zien van de licentie of stuur een brief naar Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
# 
# 
# It parses an input string of natural language dates
# into a real date
# 
# Requirements:
# Chronic ruby gem
#
# Example usage:
# logtodayone.rb "! This is a starred entry."
# logtodayone.rb "[yesterday 3pm] Something I did yesterday at 3:00PM"
# logtodayone.rb "! [-2 1:30am] A starred entry about something I did two days ago"

require 'rubygems'
require 'chronic' # (`gem install chronic`)
 
