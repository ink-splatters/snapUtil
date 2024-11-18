#
# Copyright 2017 Adam H. Leventhal. All Rights Reserved.
#

CC ?= clang
CFLAGS ?= -Wall -Os
LDFLAGS ?= -framework CoreFoundation -framework IOKit
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin
TARGET := snapUtil
SRC := snapUtil.c

ENTITLEMENTS := entitlements.plist

# ad-hoc sign by default
CODESIGNING_IDENTITY ?= -


INSTALL := install
INSTALL_DIR := $(INSTALL) -d
INSTALL_PROGRAM := $(INSTALL)


$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

codesign: $(TARGET) $(ENTITLEMENTS)
	/usr/bin/codesign --entitlements entitlements.plist -f -s $(CODESIGNING_IDENTITY) $(TARGET)

# Install rule
install: codesign
	$(INSTALL_DIR) $(BINDIR)
	$(INSTALL_PROGRAM) $(TARGET) $(BINDIR)

clean:
	rm -f $(TARGET)

all: codesign


.PHONY: all clean codesign install
