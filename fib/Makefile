.PHONY: all clean restore ip

BASH ?= /bin/bash
VIVADO_HLS ?= $(BASH) ../scripts/vivado_hls.sh
PROJECT_NAME := fib

all: $(HARDWARE_DEF) boot.bin

clean:
	-@rm -rf $(PROJECT_NAME)

restore: $(PROJECT_NAME)/vivado_hls.app
ip: $(PROJECT_NAME)/solution1/impl/ip/component.xml

$(PROJECT_NAME)/vivado_hls.app: restore_project.tcl
	$(VIVADO_HLS) ./restore_project.tcl $(PROJECT_NAME) fibonacci

$(PROJECT_NAME)/solution1/impl/ip/component.xml: fib.cpp fib.hpp $(PROJECT_NAME)/vivado_hls.app implement.tcl
	$(VIVADO_HLS) ./implement.tcl $(PROJECT_NAME)
