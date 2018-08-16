#!/usr/bin/gmake -f

PROGS = print_local_ipaddrs print_explicit_ipaddrs
SHLIBS = libnice_local_ipaddrs.so

GLIB_CFLAGS  = $(shell pkg-config --cflags glib-2.0)
GLIB_LDFLAGS = $(shell pkg-config --libs   glib-2.0)

all: $(PROGS) $(SHLIBS)

clean:
	/bin/rm $(PROGS) $(SHLIBS)

runtest: all
	./print_local_ipaddrs
	LD_PRELOAD=$(PWD)/libnice_local_ipaddrs.so                                                   ./print_local_ipaddrs
	LD_PRELOAD=$(PWD)/libnice_local_ipaddrs.so LIBNICE_LOCAL_IPADDRS=1.2.3.4                     ./print_local_ipaddrs
	LD_PRELOAD=$(PWD)/libnice_local_ipaddrs.so LIBNICE_LOCAL_IPADDRS=1.2.3.4:5.6.7.8             ./print_local_ipaddrs
	LD_PRELOAD=$(PWD)/libnice_local_ipaddrs.so LIBNICE_LOCAL_IPADDRS=1.2.3.4:5.6.7.8:11.22.33.44 ./print_local_ipaddrs

%.so: %.c
	cc $(GLIB_CFLAGS) -shared -fPIC -Wl,-z,defs -Wl,--as-needed -o $@ $< $(GLIB_LDFLAGS)

%: %.c
	cc $(GLIB_CFLAGS) -o $@ $< $(GLIB_LDFLAGS) -lnice

## END ##
