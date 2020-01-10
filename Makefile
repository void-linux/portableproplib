PREFIX ?= /usr/local
MANDIR ?= $(PREFIX)/share/man

CC ?= cc
AR ?= ar
RANLIB ?= ranlib
CFLAGS += -I./include -D_POSIX_SOURCE
CFLAGS += -O2 -Wall -Werror -g -pipe -std=c99
LDFLAGS += -L$(PREFIX)/lib
LIBS = -lz
SRCS = $(shell find src -type f -name '*.c')
OBJS = $(SRCS:.c=.o)
MANS = $(shell find man -type f -name '*.3')

MAJORVER = 0
MINORVER = 6
MICROVER = 8
SHLIB = libprop.so.$(MAJORVER).$(MINORVER).$(MICROVER)
LDFLAGS += -shared -Wl,-soname,libprop.so.$(MAJORVER)

all: libprop.so libprop.a

$(OBJS): %.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

libprop.so: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LIBS) -o $(SHLIB)

libprop.a: $(OBJS)
	$(AR) rcs $@ $^
	$(RANLIB) $@

install:
	install -d $(DESTDIR)/$(PREFIX)/lib/pkgconfig
	install -m644 libprop.a $(DESTDIR)/$(PREFIX)/lib
	install -m644 libprop.so.$(MAJORVER) $(DESTDIR)/$(PREFIX)/lib
	@-ln -sf $(SHLIB) $(DESTDIR)/$(PREFIX)/lib/libprop.so.$(MAJORVER)
	@-ln -sf $(SHLIB) $(DESTDIR)/$(PREFIX)/lib/libprop.so
	install -d $(DESTDIR)/$(PREFIX)/$(MANDIR)/man3
	install -m644 $(MANS) $(DESTDIR)/$(PREFIX)/$(MANDIR)/man3

clean:
	-rm -f $(OBJS) libprop*

.PHONY: all install clean
