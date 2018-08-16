/* print_explicit_ipaddrs.c */

#include <nice/interfaces.h>
#include <stdio.h>
#include <stdlib.h>  /* getenv */
#include <string.h>  /* strchr */

#define AA() do { } while(0)
// do { printf("DEBUG: %s:%d\n", __FILE__, __LINE__); } while(0)

static GList *interfaces_get_local_ips(gboolean include_loopback)
{
	const char *s = getenv("LIBNICE_LOCAL_IPADDRS");
	const char *p = s;
	const char *q;
	GList *result = NULL;

	if (!s)
		return nice_interfaces_get_local_ips(include_loopback);

	AA();
	while((q = strchr(p, ':')) != NULL) {
		AA();
		result = g_list_append(result, g_strndup(p, q - p));
		AA();
		p = q + 1;
	}

	AA();
	result = g_list_append(result, g_strdup(p));
	AA();
	return result;
}

int main(void)
{
	GList *ipaddrs = interfaces_get_local_ips(FALSE);
	GList *p;

	AA();
	for (p = ipaddrs; p; p = g_list_next(p)) {
		AA();
		printf("%s\n", (const char *)p->data);
	}

	AA();
	g_list_foreach(ipaddrs, (GFunc)g_free, NULL);
	AA();
	g_list_free(ipaddrs);

	return 0;
}

/* END */
