#
# GNU Autoconf stuff for libprop.
#
AC_PREREQ(2.52)

m4_define([proplib_major_version], [0])
m4_define([proplib_minor_version], [1])
m4_define([proplib_micro_version], [0])
m4_define([proplib_version],
	  [proplib_major_version.proplib_minor_version.proplib_micro_version])

AC_INIT([proplib], [proplib_version])
## must come before we use the $USE_MAINTAINER_MODE variable later
AM_MAINTAINER_MODE

# libtool versioning
#
# See http://sources.redhat.com/autobook/autobook/autobook_91.html#SEC91 for details
#

## increment if the interface has additions, changes, removals.
LT_CURRENT=0

## increment any time the source changes; set to
##  0 if you increment CURRENT
LT_REVISION=7

## increment if any interfaces have been added; set to 0
## if any interfaces have been changed or removed. removal has
## precedence over adding, so set to 0 if both happened.
LT_AGE=0

AC_SUBST(LT_CURRENT)
AC_SUBST(LT_REVISION)
AC_SUBST(LT_AGE)

AM_INIT_AUTOMAKE
AC_PROG_CC
AC_PROG_LIBTOOL
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile include/Makefile man/Makefile src/Makefile])
AC_CONFIG_MACRO_DIR([m4])

AC_CHECK_FUNCS(memmove memset munmap strchr strtoul stroull)
AC_CHECK_HEADERS(limits.h stddef.h fcntl.h pthread.h)

AC_C_CONST
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_HEADER_STDBOOL
AC_HEADER_STDC
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INT8_T
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T

AC_OUTPUT
