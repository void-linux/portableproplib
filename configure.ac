#
# GNU Autoconf stuff for libprop.
#
AC_PREREQ(2.52)

m4_define([proplib_major_version], [0])
m4_define([proplib_minor_version], [6])
m4_define([proplib_micro_version], [4])
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
LT_REVISION=13

## increment if any interfaces have been added; set to 0
## if any interfaces have been changed or removed. removal has
## precedence over adding, so set to 0 if both happened.
LT_AGE=1

AC_SUBST(LT_CURRENT)
AC_SUBST(LT_REVISION)
AC_SUBST(LT_AGE)

AM_INIT_AUTOMAKE
AC_PROG_CC_C99
if test "$ac_cv_prog_cc_c99" = "no"; then
	AC_MSG_ERROR(*** A working C99 compiler is required, aborting ***)
fi
AC_PROG_LIBTOOL

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile
		 include/Makefile
		 include/prop/Makefile
		 man/Makefile
		 src/Makefile
		 proplib.pc])
AC_CONFIG_MACRO_DIR([m4])

AC_CHECK_HEADERS(limits.h stddef.h fcntl.h)
AC_CHECK_FUNCS(memmove memset munmap strchr strtoul stroull strlcat fdatasync)
AC_CHECK_DECLS(fdatasync, [], [], [#include <unistd.h>])
AC_CHECK_LIB(pthread, pthread_mutex_init, ,
	     AC_MSG_ERROR(*** A POSIX threads library is required, aborting ***))
AC_CHECK_LIB(z, inflate, ,
	     AC_MSG_ERROR(*** zlib is required, aborting ***))

AC_MSG_CHECKING(for GCC atomic builtins)
AC_COMPILE_IFELSE(
	[AC_LANG_SOURCE(
	[[#include <stdint.h>
		int main() {
			volatile unsigned long val = 1;
			__sync_fetch_and_add(&val, 1);
			__sync_fetch_and_sub(&val, 1);
			__sync_add_and_fetch(&val, 1);
			__sync_sub_and_fetch(&val, 1);
			return 0;
		}
	]])],
	[AC_MSG_RESULT(yes); AC_DEFINE([HAVE_ATOMICS], [1], [GCC atomics support])],
	[AC_MSG_RESULT(no)])

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

CC_CHECK_CFLAGS_APPEND([-pipe -Werror -Wall -Wextra -Wvla -Wno-overlength-strings -Wunsafe-loop-optimizations -Wundef -Wformat=2 -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wcast-align -Wstrict-aliasing -Wwrite-strings -Wno-unused-parameter -Wp,-D_FORTIFY_SOURCE=2 -fstack-protector-all])

AC_OUTPUT
