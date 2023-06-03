# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import os
import random
from pathlib import Path
import pytest
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.runner import get_runner
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb.handle  import Force
from cocotb.handle  import Release
import cocotb.binary
pytestmark = pytest.mark.simulator_required


@cocotb.coroutine
async def showRFctrl(dut):
    """This coroutine ...."""
    dut._log.info("Register File Controls:")
    dut._log.info("Source0: %x", dut.SYNTHESIZED_WIRE_14.value)
    dut._log.info("Out0: %x", dut.SYNTHESIZED_WIRE_3.value)
    dut._log.info("Source1: %x", dut.SYNTHESIZED_WIRE_15.value)
    dut._log.info("Out1: %x", dut.SYNTHESIZED_WIRE_2.value)
    dut._log.info("Destination: %x", dut.SYNTHESIZED_WIRE_13.value)
    dut._log.info("DATA: %x", dut.SYNTHESIZED_WIRE_12.value)
  
@cocotb.coroutine
async def showFlags(dut):
    """This coroutine ...."""
    dut._log.info("Flags NZCV: %x", dut.b2v_inst23.flags.value)
    
@cocotb.coroutine
async def readMemory(dut,address):
    """This coroutine ...."""
    dut.ALUOutM.value = Force(address)
    await Timer(1)
    dut._log.info("M[%d]: %x", address, dut.readDataM.value) 
    dut.ALUOutM.value = Release()

@cocotb.coroutine
async def showRegister(dut,register):
    """This coroutine ...."""
    dut.SYNTHESIZED_WIRE_14.value = Force(register)
    await Timer(1,units="us")
    result =  dut.SYNTHESIZED_WIRE_3.value
    dut._log.info("R%d: %x", register,result)
    #dut._log.info("%x", result) 
    dut.SYNTHESIZED_WIRE_14.value = Release()
    return result

@cocotb.coroutine
async def readRegisterFile(dut):
    """This coroutine ...."""
    await showRegister(dut,0)
    await showRegister(dut,1)
    await showRegister(dut,2)
    await showRegister(dut,3)
    await showRegister(dut,4)
    await showRegister(dut,5)
    await showRegister(dut,6)
    await showRegister(dut,7)
    await showRegister(dut,8)
    await showRegister(dut,9)
    await showRegister(dut,10)
    await showRegister(dut,11)
    await showRegister(dut,12)
    await showRegister(dut,13)
    await showRegister(dut,14)
    await showRegister(dut,15)

@cocotb.coroutine
async def breakPoint(dut,PC):
    """This coroutine ...."""
    watchdog = 0
    while dut.PCF.value != PC and watchdog<1000 :
        await RisingEdge(dut.clk)  
        await Timer(1,units="ns")
        watchdog+=1 


@cocotb.coroutine
async def showFetchStage(dut):
    """This coroutine ...."""
    dut._log.info("****Fetch Stage Signals****")
    dut._log.info("PCF: %x", dut.PCF.value)
    dut._log.info("PCplus4F: %x", dut.PCplus4F.value)
    dut._log.info("instructionF: %x", dut.instructionF.value)

@cocotb.coroutine
async def showDecodeStage(dut):
    """This coroutine ...."""
    dut._log.info("****Decode Stage Signals****")
    dut._log.info("instructionD: %x", dut.instructionD.value)
    dut._log.info("PC4D: %x", dut.PC4D.value)
    dut._log.info("regDataSrcD: %x", dut.regDataSrcD.value)
    dut._log.info("PCSrcD: %x", dut.PCSrcD.value)
    dut._log.info("branchD: %x", dut.branchD.value)
    dut._log.info("regWriteD: %x", dut.regWriteD.value)
    dut._log.info("memWriteD: %x", dut.memWriteD.value)
    dut._log.info("resultSrcD: %x", dut.resultSrcD.value)
    dut._log.info("ALUControlD: %x", dut.ALUControlD.value)
    dut._log.info("ALUSrcD: %x", dut.ALUSrcD.value)
    dut._log.info("immSrcD: %x", dut.immSrcD.value)
    dut._log.info("destinationSrcD: %x", dut.SYNTHESIZED_WIRE_9.value)
    dut._log.info("regSrcD: %x", dut.regSrcD.value)

@cocotb.coroutine
async def showExecuteStage(dut):
    """This coroutine ...."""
    dut._log.info("****Execute Stage Signals****")
    dut._log.info("srcAE: %x", dut.srcAE.value)
    dut._log.info("srcBE: %x", dut.srcBE.value)
    dut._log.info("ALUControlE: %x", dut.ALUControlE.value)
    dut._log.info("ALUSrcE: %x", dut.ALUSrcE.value)
    dut._log.info("writeDataE: %x", dut.writeDataE.value)
    dut._log.info("shamtE: %x", dut.shamtE.value)
    dut._log.info("shE: %x", dut.shE.value)
    dut._log.info("WA3E: %x", dut.WA3E.value)
    dut._log.info("condEx: %x", dut.condEx.value)
    dut._log.info("destinationSrcE: %x", dut.destinationSrcE.value)
    dut._log.info("regDataSrcE: %x", dut.regDataSrcE.value)


@cocotb.coroutine
async def showMemoryStage(dut):
    """This coroutine ...."""
    dut._log.info("****Memory Stage Signals****")
    dut._log.info("memWriteM: %x", dut.memWriteM.value)
    dut._log.info("ALUOutM: %x", dut.ALUOutM.value)
    dut._log.info("writeDataM: %x", dut.writeDataM.value)
    dut._log.info("PC4M: %x", dut.PC4M.value)
    dut._log.info("WA3M: %x", dut.WA3M.value)
    dut._log.info("destinationSrcM: %x", dut.destinationSrcM.value)
    dut._log.info("regDataSrcM: %x", dut.regDataSrcM.value)

@cocotb.coroutine
async def showWriteBackStage(dut):
    """This coroutine ...."""
    dut._log.info("****WriteBack Stage Signals****")
    dut._log.info("regDataSrcW: %x", dut.regDataSrcW.value)
    dut._log.info("PCSrcW: %x", dut.PCSrcW.value)
    dut._log.info("regWriteW: %x", dut.regWriteW.value)
    dut._log.info("resultSrcW: %x", dut.resultSrcW.value)
    dut._log.info("destinationSrcW: %x", dut.destinationSrcW.value)
    dut._log.info("resultW: %x", dut.resultW.value)
    dut._log.info("PC4W: %x", dut.PC4W.value)
    dut._log.info("WA3W: %x", dut.WA3W.value)



@cocotb.test()
async def test2sComp(dut):

    dut.reset.value = 0
    clock = Clock(dut.clk, 100, units="ms")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    await Timer(1,units="ns")

    await breakPoint(dut,0x1dc)



    await showFetchStage(dut)
    await readRegisterFile(dut)
    await showFlags(dut)


















   
"""
    await breakPoint(dut,0xb0) 
    await showFetchStage(dut)

    await RisingEdge(dut.clk)
    await Timer(1,units="ns")
    await showDecodeStage(dut)

    await RisingEdge(dut.clk)
    await Timer(1,units="ns")
    await showExecuteStage(dut)

    await RisingEdge(dut.clk)
    await Timer(1,units="ns")
    await showMemoryStage(dut)


    await RisingEdge(dut.clk)
    await Timer(1,units="ns")
    await showWriteBackStage(dut)
    
    
    #await FallingEdge(dut.clk)
    #await Timer(1,units="ns")
    #await readRegisterFile(dut)
"""


    
 
  
 
 


   