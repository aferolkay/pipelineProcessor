# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

SIM ?= icarus
TOPLEVEL_LANG ?= verilog


VERILOG_SOURCES += $(shell pwd)/../hardware/ALU.v
VERILOG_SOURCES += $(shell pwd)/../hardware/combinationalShifter.v
VERILOG_SOURCES += $(shell pwd)/../hardware/conditionCheck.v
VERILOG_SOURCES += $(shell pwd)/../hardware/constantValueGenerator.v
VERILOG_SOURCES += $(shell pwd)/../hardware/controlUnit.v
VERILOG_SOURCES += $(shell pwd)/../hardware/decoder2to4.v
VERILOG_SOURCES += $(shell pwd)/../hardware/decoder4to16.v
VERILOG_SOURCES += $(shell pwd)/../hardware/extender12or24.v
VERILOG_SOURCES += $(shell pwd)/../hardware/fourAdder.v
VERILOG_SOURCES += $(shell pwd)/../hardware/hexto7segment.v
VERILOG_SOURCES += $(shell pwd)/../hardware/memory.v
VERILOG_SOURCES += $(shell pwd)/../hardware/mux16to1.v
VERILOG_SOURCES += $(shell pwd)/../hardware/mux2to1.v
VERILOG_SOURCES += $(shell pwd)/../hardware/mux4to1.v
VERILOG_SOURCES += $(shell pwd)/../hardware/pipelineProcessor.v
VERILOG_SOURCES += $(shell pwd)/../hardware/Register_file.v
VERILOG_SOURCES += $(shell pwd)/../hardware/registerFile.v
VERILOG_SOURCES += $(shell pwd)/../hardware/simpleRegister.v
VERILOG_SOURCES += $(shell pwd)/../hardware/writeENregister.v
VERILOG_SOURCES += $(shell pwd)/../hardware/writeENregisterReverse.v


VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Decoder_2to4.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Decoder_4to16.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Extender.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Mux_2to1.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Mux_4to1.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Mux_16to1.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Register_simple.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/Register_sync_rw.v
VERILOG_SOURCES += $(shell pwd)/../odtuclassCodes/shifter.v



# MODULE'E test scriptinin olduğu dosyayı göster
MODULE = testPipeline

# TOPMODULE'ün ismi neyse onu gireceksin ; dosyayı değil!
TOPLEVEL = pipelineProcessor


include $(shell cocotb-config --makefiles)/Makefile.sim
