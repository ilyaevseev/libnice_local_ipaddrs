/* libnice_local_ipaddrs.c */

#include <nice/interfaces.h>
#include <string.h>  /* strchr, strlen */
#include <stdlib.h>  /* getenv */
#include <unistd.h>  /* write */

static void dbgprint(const char *s)
{
	if (getenv("LIBNICE_LOCAL_IPADDRS_DEBUG"))
		write(1, s, strlen(s));
}

GList *nice_interfaces_get_local_ips(gboolean include_loopback)
{
	const char *s = getenv("LIBNICE_LOCAL_IPADDRS");
	const char *p = s;
	const char *q;
	GList *result = NULL;

	if (!s) {
		dbgprint("DEBUG: libnice_local_ipaddrs: return empty list\n");
		return g_list_append(NULL, g_strdup("127.0.0.1"));
	}

	dbgprint("DEBUG: libnice_local_ipaddrs: parse envvar\n");

	while((q = strchr(p, ':')) != NULL) {
		result = g_list_append(result, g_strndup(p, q - p));
		p = q + 1;
	}

	return g_list_append(result, g_strdup(p));
}

/* END */
