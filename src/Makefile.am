#
# Makefile.am for proplib.
#
AM_CPPFLAGS = -I$(top_srcdir)/include

lib_LTLIBRARIES = libprop.la
libprop_la_SOURCES = prop_array.c prop_array_util.c prop_bool.c prop_data.c \
		     prop_dictionary.c prop_dictionary_util.c \
		     prop_ingest.c prop_number.c prop_object.c prop_rb.c \
		     prop_stack.c prop_string.c
libprop_la_LDFLAGS = -version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)
