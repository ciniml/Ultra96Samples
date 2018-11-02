.PHONY: all clean restore device-tree open

PROJECT_NAME := ultra96hw
BD_NAME := design_top
BITSTREAM := $(PROJECT_NAME).runs/impl_1/$(BD_NAME)_wrapper.bit
BITSTREAM_BIN := $(BD_NAME)_wrapper.bit.bin
SDK_DIR := $(PROJECT_NAME).sdk
HARDWARE_DEF := $(SDK_DIR)/$(BD_NAME)_wrapper.hdf
SRCS := blink.v Ultra96_constraints_180318.xdc
XILINX_DEVICE_TREE ?= $(abspath ../device-tree-xlnx)

BASH := /bin/bash
VIVADO ?= $(BASH) $(realpath ../scripts/vivado.sh)
HSI ?= $(BASH) $(realpath ../scripts/hsi.sh)
BOOTGEN ?= $(BASH) $(realpath ../scripts/bootgen.sh)
GEN_BITSTREAM_TO_BIN ?= $(BASH) $(realpath ../scripts/gen_bitstream_to_bin.sh)

all: $(HARDWARE_DEF) boot.bin overlay.dtb

restore: $(PROJECT_NAME).xpr

clean:
	-@rm -rf $(PROJECT_NAME).* .Xil
	-@rm *.jou *.str *.btree *.log

open: $(PROJECT_NAME).xpr
	$(VIVADO) $<&

../fib/fib/solution1/impl/component.xml:
	cd ../fib; make ip

$(PROJECT_NAME).xpr: ../fib/fib/solution1/impl/component.xml $(SRCS)
	$(VIVADO) -mode batch -source restore_project.tcl -tclargs $(PROJECT_NAME)

$(BITSTREAM) $(HARDWARE_DEF): $(PROJECT_NAME).xpr $(SRCS) $(PROJECT_NAME).srcs/sources_1/bd/$(BD_NAME)/$(BD_NAME).bd
	$(VIVADO) -mode batch -source implement.tcl -tclargs $(PROJECT_NAME)

$(BITSTREAM_BIN): $(BITSTREAM)
	$(GEN_BITSTREAM_TO_BIN) $(BITSTREAM) bitstream_to_bin.bif
	$(BOOTGEN) -image ./bitstream_to_bin.bif -arch zynqmp -w -o $@

Ultra96_constraints_180318.zip:
	wget http://zedboard.org/sites/default/files/documentations/Ultra96_constraints_180318.zip

Ultra96_constraints_180318.xdc: Ultra96_constraints_180318.zip
	unzip Ultra96_constraints_180318.zip
	touch $@

boot.bin: ZynqMP-FPGA-Linux $(BITSTREAM)
	cp $(BITSTREAM) .
	cp ZynqMP-FPGA-Linux/target/Ultra96/build-v2018.2/*.elf .
	$(BOOTGEN) -image ./bootbin.bif -arch zynqmp -w -o $@

$(SDK_DIR)/devicetree/pl.dtsi: $(HARDWARE_DEF)
	cd $(SDK_DIR); $(HSI) -mode batch -source ../generate_devicetree.tcl -tclargs $(BD_NAME)_wrapper $(XILINX_DEVICE_TREE) devicetree

overlay.dtb: $(SDK_DIR)/devicetree/pl.dtsi overlay.dts
	dtc -I dts -O dtb -@ overlay.dts -o $@

device-tree: overlay.dtb

ZynqMP-FPGA-Linux:
	git clone https://github.com/ikwzm/ZynqMP-FPGA-Linux -b v2018.2.1-rc2
	cd ZynqMP-FPGA-Linux; git lfs pull

