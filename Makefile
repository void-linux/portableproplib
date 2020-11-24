PREFIX ?= /usr/local
MANDIR ?= share/man

CC ?= cc
AR ?= ar
RANLIB ?= ranlib
CCFLAGS += -I./include -I./src -Wno-unused-function
CCFLAGS += -DHAVE_FDATASYNC -DHAVE_ATOMICS -DHAVE_VISIBILITY
CCFLAGS += -D_XOPEN_SOURCE=700 -D_DEFAULT_SOURCE
CCFLAGS += -O2 -Wall -Werror -g -pipe -pthread -fPIC
CLDFLAGS += -L$(PREFIX)/lib
LIBS = -lz -lpthread
SRCS = $(shell find src -type f -name '*.c')
OBJS = $(SRCS:.c=.o)
MANS = $(shell find man -type f -name '*.3')

MAJORVER = 0
MINORVER = 6
MICROVER = 10
VERSION = $(MAJORVER).$(MINORVER).$(MICROVER)
SHLIB = libprop.so.$(VERSION)
LDFLAGS += -shared -Wl,-soname,libprop.so.$(MAJORVER)

all: libprop.so libprop.a

$(OBJS): %.o: %.c
	$(CC) $(CCFLAGS) $(CFLAGS) -c $< -o $@

libprop.so: $(OBJS)
	$(CC) $(CCFLAGS) $(CFLAGS) $(CLDFLAGS) $(LDFLAGS) $^ $(LIBS) -o $(SHLIB)
	ln -sf $(SHLIB) libprop.so.$(MAJORVER)
	ln -sf $(SHLIB) libprop.so

libprop.a: $(OBJS)
	$(AR) rcs $@ $^
	$(RANLIB) $@

install: all
	install -d $(DESTDIR)/$(PREFIX)/include/prop
	install -m644 include/prop/*.h $(DESTDIR)/$(PREFIX)/include/prop
	install -d $(DESTDIR)/$(PREFIX)/lib/pkgconfig
	install -m644 libprop.a $(DESTDIR)/$(PREFIX)/lib
	install -m644 $(SHLIB) $(DESTDIR)/$(PREFIX)/lib
	ln -sf $(SHLIB) $(DESTDIR)/$(PREFIX)/lib/libprop.so.$(MAJORVER)
	ln -sf $(SHLIB) $(DESTDIR)/$(PREFIX)/lib/libprop.so
	install -d $(DESTDIR)/$(PREFIX)/$(MANDIR)/man3
	install -m644 $(MANS) $(DESTDIR)/$(PREFIX)/$(MANDIR)/man3
	sed -e 's,@prefix@,$(PREFIX),g' \
		-e 's,@exec_prefix@,$(PREFIX),g' \
		-e 's,@libdir@,$(PREFIX)/lib,g' \
		-e 's,@includedir@,$(PREFIX)/include,g' \
		-e 's,@PACKAGE_VERSION@,$(VERSION),g' \
		data/proplib.pc.in > $(DESTDIR)/$(PREFIX)/lib/pkgconfig/proplib.pc
	chmod 644 $(DESTDIR)/$(PREFIX)/lib/pkgconfig/proplib.pc

clean:
	-rm -f $(OBJS) libprop*

.PHONY: all install clean
