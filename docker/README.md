# dbndns docker container

## Motivation
This folder provides Dockerfile and auxiliary files for creating docker container for running dbndns. The resulting setup has been inspired by [xcsrz/just-tinydns](https://github.com/xcsrz/just-tinydns) and thus includes some parts of it. This approach basically comes with these benefits over its origin:

* This Dockerfile uses a Debian fork of djbdns called dbndns. It provides the same functionality as original djbdns but adds some additional functionality such as supporting IPv6.
* The Dockerfile generates a lot smaller image due to combining most work in a single layer which gets cleaned after building stuff from source.
 
## Intention

This is a docker image to run a DNS server for publishing public DNS records on the internet.

djbdns and dbndns include another tool called `dnscache` which is designed to cache recursive DNS lookups e.g. to reduce network load on a local network frequently resolving domain names on behalf of client software. This task isn't integrated with the DNS server by intention and for security reaons. Thus it isn't supported by this container, either. As a matter of fact the container will ignore any request for domains it isn't authoritative for. So if you test querying this container but don't get a response it is most likely due to requesting information on a _foreign_ domain (so you might have to check your data file first).

## Integration

* The server reads its database of domains from a file compiled from a source which is expected in `/srv/dns/root/data`.
* The compilation is always triggered on starting the container.
* If you have changed the source you might trigger re-compilation in context of running container with command `docker exec [ CONTAINER NAME OR ID ] /ctl.sh update`.
* You need to mount your data file from your host or using some volume to persist.

## Building

When in root folder of this project build can be triggered with command:

```bash
docker build -t foo/dbndns docker
```

## Starting Service

### Regular Start

```docker run -v /path/on/host/data:/srv/dns/root/data -p 53:53 foo/dbndns```

Make sure to use absolute path names for either filename involved in mounting your data file.

### Testing

```docker run -p 53:53 foo/dbndns test```

The parameter `test` is passed to the control script of container resulting in a fixed data file being written to `/srv/dns/root/data` prior to compiling this file and starting the service. The test file looks like this:

```
.test.com:127.0.0.1:a
=test.com:1.2.3.4:600
=www.test.com:2.3.4.5:600
```

> **Note!** You need to run this command w/o mounting your own data file otherwise the container will fail due to rejecting to overwrite your data file.

Next find out ID of running container using `docker ps` and use it in the following commands to try the service:

```bash
docker exec <container-id> apk add bind-tools
docker exec <container-id> dig test.com @172.17.0.2
```

This will show an answer claiming `test.com` is available at IP 1.2.3.4 with authoritative nameserver being called `a.ns.test.com`:

```
; <<>> DiG 9.12.3 <<>> tast.com @172.17.0.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8808
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;tast.com.                      IN      A

;; ANSWER SECTION:
tast.com.               600     IN      A       1.2.3.4

;; AUTHORITY SECTION:
tast.com.               259200  IN      NS      a.ns.tast.com.

;; ADDITIONAL SECTION:
a.ns.tast.com.          259200  IN      A       127.0.0.1

;; Query time: 0 msec
;; SERVER: 172.17.0.2#53(172.17.0.2)
;; WHEN: Thu Dec 06 23:52:45 UTC 2018
;; MSG SIZE  rcvd: 77
```

Start the service:

```docker run -v `pwd`/test.dns:/srv/dns/root/data -p 53:53 cepharum/dbndns```


### Docker Compose:

```
version: "3"
services:
  dns:
    image: cepharum/dbndns
    volumes:
      - ./dns.data:/srv/dns/root/data
    ports:
      - 53:53/tcp
      - 53:53/udp
```

### References

[Data File Format](http://cr.yp.to/djbdns/tinydns-data.html)

[All About djbdns](http://cr.yp.to/djbdns.html)
