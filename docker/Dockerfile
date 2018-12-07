FROM alpine

COPY ctl.sh /

RUN apk update && \
	apk add make gcc g++ ucspi-tcp6 ca-certificates git && \
	update-ca-certificates && \
	mkdir /src && \
	wget -O - https://cr.yp.to/daemontools/daemontools-0.76.tar.gz | tar xpzf - -C /src && \
	cd /src/admin/daemontools-0.76 && \
	sed -i -e 's/-O2 /-O2 -include \/usr\/include\/errno.h /' src/conf-cc && \
	package/install && while read name; do mv command/$name /command/$name; done <package/commands && \
	git clone https://github.com/cepharum/dbndns.git /src/dbndns && cd /src/dbndns/src && \
    make && make setup check && \
    rm -Rf /src && apk del gcc g++ git && \
	tinydns-conf nobody nobody /srv/dns 0.0.0.0 && \
	chmod +x /ctl.sh

EXPOSE 53

ENTRYPOINT ["/bin/sh", "/ctl.sh"]
CMD ["run"]
