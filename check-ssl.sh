#!/bin/sh
#-
#- Check ssl certificate
#-
#- Usage:
#-   check_ssl <host> [port] [valid_days]
#-
#


check_ssl() {
	CERT=$(openssl s_client -connect "$1:${2-443}" -servername "$1" -verify_hostname "$1" -verify_return_error </dev/null 2>/dev/null) || {
		printf "%s - %s\n" "$1" "$(printf %s "$CERT" | grep 'error:')"
		return 1
	}
	# openssl x509 -noout -checkend $((90*24*3600))
	DAYS=$(( ( $(date -d "$(printf %s "$CERT" | openssl x509 -noout -enddate | cut -d= -f2)" +%s) - $(date +%s) ) / 86400 ))
	[ "$DAYS" -lt "${3-20}" ] && {
		printf "%s - Expires in %s days\n" "$1" "$DAYS"
		return 1
	}

	printf "%s - Valid %s more days\n" "$1" "$DAYS"
}


check_ssl "p1.agatark.com"
check_ssl "c66.ee.agatark.com"
check_ssl "example.com"


