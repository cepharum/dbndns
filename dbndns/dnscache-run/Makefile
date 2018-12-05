install:
	install -d -m3755 '$(DESTDIR)'/etc/sv/dnscache
	install -d -m2755 '$(DESTDIR)'/etc/sv/dnscache/env
	install -d -m2755 '$(DESTDIR)'/etc/sv/dnscache/log
	install -d -m2755 '$(DESTDIR)'/etc/sv/dnscache/root
	install -m0755 run '$(DESTDIR)'/etc/sv/dnscache/
	install -m0644 env/* '$(DESTDIR)'/etc/sv/dnscache/env/
	install -m0755 log/run '$(DESTDIR)'/etc/sv/dnscache/log/
	touch '$(DESTDIR)'/etc/sv/dnscache/log/status
	chmod 0644 '$(DESTDIR)'/etc/sv/dnscache/log/status
	install -d -m2755 '$(DESTDIR)'/etc/sv/dnscache/root/ip
	install -d -m2755 '$(DESTDIR)'/etc/sv/dnscache/root/servers
	touch '$(DESTDIR)'/etc/sv/dnscache/root/ip/127.0.0.1
	chmod 0600 '$(DESTDIR)'/etc/sv/dnscache/root/ip/127.0.0.1
	install -m0644 root/servers/@ '$(DESTDIR)'/etc/sv/dnscache/root/servers/
