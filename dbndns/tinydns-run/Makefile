install:
	install -d -m3755 '$(DESTDIR)'/etc/sv/tinydns
	install -d -m2755 '$(DESTDIR)'/etc/sv/tinydns/env
	install -d -m2755 '$(DESTDIR)'/etc/sv/tinydns/log
	install -d -m2755 '$(DESTDIR)'/etc/sv/tinydns/root
	install -m0755 run '$(DESTDIR)'/etc/sv/tinydns/
	install -m0644 env/* '$(DESTDIR)'/etc/sv/tinydns/env/
	touch '$(DESTDIR)'/etc/sv/tinydns/env/IP
	chmod 0644 '$(DESTDIR)'/etc/sv/tinydns/env/IP
	install -m0755 log/run '$(DESTDIR)'/etc/sv/tinydns/log/
	touch '$(DESTDIR)'/etc/sv/tinydns/log/status
	chmod 0644 '$(DESTDIR)'/etc/sv/tinydns/log/status
	install -m0755 root/add-* '$(DESTDIR)'/etc/sv/tinydns/root/
	install -m0644 root/Makefile '$(DESTDIR)'/etc/sv/tinydns/root/
	touch '$(DESTDIR)'/etc/sv/tinydns/root/data
	chmod 0644 '$(DESTDIR)'/etc/sv/tinydns/root/data
