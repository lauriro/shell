#!/bin/sh
# shellcheck disable=SC2308
#
#- Damm check digit algorithm to detect all single-digit errors and all adjacent transposition errors
#-
#- Usage: damm <number_string>
#- Outputs calculated single check digit to stdout
#
damm() {
	state=0
	T="0317598642709215486342068713591750983426612304597836742095815869720134894536201794386172052581436790"

	for i in $(printf %s "$1" | fold -b1); do
		state=$(expr substr $T $((state*10+i+1)) 1)
	done

	printf %s "$state"
}


