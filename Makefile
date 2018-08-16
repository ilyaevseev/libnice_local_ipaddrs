#!/usr/bin/gmake -f

PROGS = print_local_ipaddrs print_explicit_ipaddrs
SHLIBS = libnice_local_ipaddrs.so

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
	cc -I /usr/include/glib-2.0 -I /usr/lib64/glib-2.0/include -lglib-2.0 -shared -fPIC -Wl,-z,defs -Wl,--as-needed -o $@ $<

%: %.c
	cc -I /usr/include/glib-2.0 -I /usr/lib64/glib-2.0/include -o $@ -lnice -lglib-2.0 $<

## END ##
