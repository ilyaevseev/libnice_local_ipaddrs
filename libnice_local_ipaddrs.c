/* print_local_ipaddrs.c */

#include <nice/interfaces.h>

GList *nice_interfaces_get_local_ips(gboolean include_loopback)
{
	const char *s = getenv("LIBNICE_LOCAL_IPADDRS");
	const char *p = s;
	const char *q;
	GList *result = NULL;

	if (!s)
		return g_list_append(NULL, g_strdup("127.0.0.1"));

	while((q = strchr(p, ':')) != NULL) {
		result = g_list_append(result, g_strndup(p, q - p));
		p = q + 1;
	}

	return g_list_append(result, g_strdup(p));
}

/* END */
