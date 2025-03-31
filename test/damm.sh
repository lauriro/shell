#!/bin/sh


cd ${0%/*}
. ../assert.sh
. ../damm.sh


validate() {
	res=${1%?}$(damm "${1%?}")
	[ "$1" != "$res" ] && {
		printf %s "Fail $1 != $res" >&2
		return 1
	}
	printf "Pass: %s\n" "$1"
	return 0
}

Test "5724" validate 5724
Test "112946" validate 112946

Fail 1 "Empty number" validate ""
Fail 1 "Invalid number" validate 1a2
Fail 1 "1234567893" validate 1234567893
Fail 1 "112949" validate 112949

