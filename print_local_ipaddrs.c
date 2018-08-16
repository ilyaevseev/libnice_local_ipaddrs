/* print_local_ipaddrs.c */

#include <nice/interfaces.h>
#include <stdio.h>

int main(void)
{
	GList *ipaddrs = nice_interfaces_get_local_ips(FALSE);
	GList *p;

	for (p = ipaddrs; p; p = g_list_next(p)) {
		printf("%s\n", (const char *)p->data);
	}

	g_list_foreach(ipaddrs, (GFunc)g_free, NULL);
	g_list_free(ipaddrs);

	return 0;
}

/* END */
