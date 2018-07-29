.PHONY: all clean restore

PROJECT_NAME := ultra96hw
BD_NAME := design_top
BITSTREAM := $(PROJECT_NAME).runs/impl_1/$(BD_NAME).bit
HARDWARE_DEF := $(PROJECT_NAME).sdk/$(BD_NAME)_wrapper.hdf
SRCS := blink.v Ultra96_constraints_180318.xdc

all: $(HARDWARE_DEF)

restore: $(PROJECT_NAME).xpr

clean:
	-@rm -rf $(PROJECT_NAME).* .Xil
	-@rm *.jou *.str *.btree *.log

$(PROJECT_NAME).xpr: $(SRCS)
	./vivado.sh -mode batch -source restore_project.tcl -tclargs $(PROJECT_NAME)

$(BITSTREAM) $(HARDWARE_DEF): $(PROJECT_NAME).xpr $(SRCS) $(PROJECT_NAME).srcs/sources_1/bd/$(BD_NAME)/$(BD_NAME).bd
	./vivado.sh -mode batch -source implement.tcl -tclargs $(PROJECT_NAME)


Ultra96_constraints_180318.zip:
	wget http://zedboard.org/sites/default/files/documentations/Ultra96_constraints_180318.zip

Ultra96_constraints_180318.xdc: Ultra96_constraints_180318.zip
	unzip Ultra96_constraints_180318.zip
