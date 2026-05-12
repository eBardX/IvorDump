PREFIX?=/usr/local

IVORDUMP_BUILD_DIR?=.build/release
IVORDUMP_INSTALL_DIR?=$(PREFIX)/bin
IVORDUMP_INSTALL_NAME=ivordump

.PHONY: build clean complete format install lint reset uninstall

build:
	@ swift build -c release

clean:
	@ swift package clean

complete: reset clean format lint build install

format:
	@ swiftformat .

install: build
	@ install -d $(IVORDUMP_INSTALL_DIR)
	@ install -Cv $(IVORDUMP_BUILD_DIR)/$(IVORDUMP_INSTALL_NAME) $(IVORDUMP_INSTALL_DIR)/$(IVORDUMP_INSTALL_NAME)

lint:
	@ swiftlint lint

reset:
	@ swift package reset
	@ rm -f Package.resolved

uninstall:
	@ rm -fv $(IVORDUMP_INSTALL_DIR)/$(IVORDUMP_INSTALL_NAME)
