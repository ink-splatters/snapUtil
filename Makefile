#
# Copyright 2017 Adam H. Leventhal. All Rights Reserved.
#

NAME := snapUtil
SRC := snapUtil.c

CC ?= clang
CFLAGS ?= -Wall -Os
LDFLAGS ?= -framework CoreFoundation -framework IOKit

ENTITLEMENTS := entitlements.plist

# ad-hoc sign by default
CODESIGNING_IDENTITY ?= -

.PHONY: all clean codesign

$(NAME): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

codesign: snapUtil $(ENTITLEMENTS)
	/usr/bin/codesign --entitlements entitlements.plist -f -s $(CODESIGNING_IDENTITY) snapUtil

clean:
	rm -f snapUtil

all: codesign
