#!/usr/bin/env bash

set visited_formulas 'brew-cask'

function check_formulas() {
  for formula in $@
  do
    echo $formula
    set dependees $(brew uses --installed $formula)
    if [ -z "$dependees" ] 
    then
    	if [[ $$visited_formulas =~ (^|[[:space:]])"$formula"($|[[:space:]]) ]]
    	then
    		echo YOLO
    	else
            read -p "echo \"$formula is not depended on by other formulas. Remove? [Y/n] \"" input
            set visited_formulas $visited_formulas $formula
            if [ "$input" = "Y" ]
            then
                   brew remove $formula
                   check_formulas $(brew deps --1 --installed $formula)
            fi
        fi
    fi
  done
}
 
echo "Searching for formulas not depended on by other formulas..."
 
check_formulas $(brew list)