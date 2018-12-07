#!/bin/sh

case "${1}" in
	"test")
		[ -s /srv/dns/root/data ] && {
			echo "Can't write test data file w/o overwriting existing one. Please run tests w/o mounting any external data file!" >&2
			exit 1
		}

		cat <<EOT >/srv/dns/root/data
.test.com:127.0.0.1:a
=test.com:1.2.3.4:600
=www.test.com:2.3.4.5:600
EOT
		cd /srv/dns/root && make && cd /srv/dns && ./run
		;;

	"run")
		cd /srv/dns/root && make && cd /srv/dns && ./run
		;;

	"update")
		cd /srv/dns/root && make
		;;
esac
