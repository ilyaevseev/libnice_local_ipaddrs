#!/usr/bin/gmake -f

PROGS = print_local_ipaddrs print_explicit_ipaddrs
SHLIBS = libnice_local_ipaddrs.so

all: $(PROGS) $(SHLIBS)

clean:
	rm $(PROGS)

%.so: %.c
	cc -I /usr/include/glib-2.0 -I /usr/lib64/glib-2.0/include -shared -fPIC -o $@ -lglib-2.0 $<

%: %.c
	cc -I /usr/include/glib-2.0 -I /usr/lib64/glib-2.0/include -o $@ -lnice -lglib-2.0 $<

## END ##
