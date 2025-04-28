#!/bin/sh
#-
#- Check does provided user password matches with one in /etc/shadow file
#-
#- Usage:
#-   check_passwd <user> <password>
#-
#


check_passwd() {
	LINE=$(grep "^$1:" /etc/shadow | cut -d: -f2)
	# shellcheck disable=SC2046
	set -- $(printf %s "$LINE" | tr '$' ' ' | cut -d' ' -f2,3) "$2"
	[ "$LINE" = "$(openssl passwd -"$1" -salt "$2" "$3")" ]
}


