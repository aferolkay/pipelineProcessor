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

    dut._log.info("Register File Controls:")
    dut._log.info("Source0: %x", dut.SYNTHESIZED_WIRE_14.value)
    dut._log.info("Out0: %x", dut.SYNTHESIZED_WIRE_3.value)
    dut._log.info("Source1: %x", dut.SYNTHESIZED_WIRE_15.value)
    dut._log.info("Out1: %x", dut.SYNTHESIZED_WIRE_2.value)
    dut._log.info("Destination: %x", dut.SYNTHESIZED_WIRE_13.value)
    dut._log.info("DATA: %x", dut.SYNTHESIZED_WIRE_12.value)
  
@cocotb.coroutine
async def showFlags(dut):
   
    dut._log.info("Flags NZCV: %x", dut.b2v_inst23.flags.value)
    
@cocotb.coroutine
async def readMemory(dut,address):
    
    dut.ALUOutM.value = Force(address)
    await Timer(1)
    dut._log.info("M[%d]: %x", address, dut.readDataM.value) 
    dut.ALUOutM.value = Release()

@cocotb.coroutine
async def showRegister(dut,register):
    dut.SYNTHESIZED_WIRE_30.value = Force(register)
    await Timer(1,units="us")
    result =  dut.SYNTHESIZED_WIRE_19.value
    dut._log.info("R%d: %x", register,result)
    dut.SYNTHESIZED_WIRE_30.value = Release()
    await Timer(1,units="us")
    return result

@cocotb.coroutine
async def readRegisterFile(dut):
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
    watchdog = 0
    while dut.PCF.value != PC and watchdog<1000 :
        await RisingEdge(dut.clk)  
        await Timer(1,units="ns")
        watchdog+=1 


@cocotb.coroutine
async def showFetchStage(dut):
    dut._log.info("****Fetch Stage Signals****")
    dut._log.info("PCF: %x", dut.PCF.value)
    dut._log.info("PCplus4F: %x", dut.PCplus4F.value)
    dut._log.info("instructionF: %x", dut.instructionF.value)

@cocotb.coroutine
async def showDecodeStage(dut):
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
    dut._log.info("destinationSrcD: %x", dut.SYNTHESIZED_WIRE_15.value)
    dut._log.info("regSrcD: %x", dut.regSrcD.value)
    dut._log.info("movImm: %x", dut.movImm.value)
    dut._log.info("shD: %x", dut.shD.value)

@cocotb.coroutine
async def showExecuteStage(dut):
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
    dut._log.info("regWriteE: %x", dut.regWriteE.value)
    dut._log.info("memWriteE: %x", dut.memWriteE.value)

@cocotb.coroutine
async def showMemoryStage(dut):
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
    dut._log.info("****WriteBack Stage Signals****")
    dut._log.info("regDataSrcW: %x", dut.regDataSrcW.value)
    dut._log.info("PCSrcW: %x", dut.PCSrcW.value)
    dut._log.info("regWriteW: %x", dut.regWriteW.value)
    dut._log.info("resultSrcW: %x", dut.resultSrcW.value)
    dut._log.info("destinationSrcW: %x", dut.destinationSrcW.value)
    dut._log.info("resultW: %x", dut.resultW.value)
    dut._log.info("PC4W: %x", dut.PC4W.value)
    dut._log.info("WA3W: %x", dut.WA3W.value)

@cocotb.coroutine
async def showHazardUnit(dut):
    dut._log.info("Hazard Unit Controls:")
    dut._log.info("RA1D: %x", dut.RA1D.value)
    dut._log.info("RA2D: %x", dut.RA2D.value)
    dut._log.info("RA1E: %x", dut.RA1E.value)
    dut._log.info("RA2E: %x", dut.RA2E.value)
    dut._log.info("WA3E: %x", dut.WA3E.value)
    dut._log.info("WA3M: %x", dut.WA3M.value)
    dut._log.info("WA3W: %x", dut.WA3W.value)
    dut._log.info("branchTakenE: %x", dut.branchTakenE.value)
    dut._log.info("regWriteM: %x", dut.regWriteM.value)
    dut._log.info("regWriteW: %x", dut.regWriteW.value)
    dut._log.info("resultSrcE: %x", dut.resultSrcE.value)
    dut._log.info("forwardAE: %x", dut.forwardAE.value)
    dut._log.info("forwardBE: %x", dut.forwardBE.value)
    dut._log.info("stallFetch: %x", dut.stallFetch.value)
    dut._log.info("stallDecode: %x", dut.stallDecode.value)
    dut._log.info("flushDecode: %x", dut.flushDecode.value)
    dut._log.info("flushExecute: %x", dut.flushExecute.value)
    dut._log.info("match_12D_E: %x", dut.b2v_inst103.match_12D_E.value)
    dut._log.info("LDRStall: %x", dut.b2v_inst103.LDRStall.value)

@cocotb.coroutine
async def nextCLK(dut):
    await RisingEdge(dut.clk)
    print(" ******* RISING EDGE ********")
    await Timer(1,units="ns")

@cocotb.coroutine
async def showBranchTargetBuffer(dut):
    dut._log.info("PCIn: %x | BTAIn: %x ",dut.PCIn.value , dut.branchTargetIn.value)
    dut._log.info("PC[0]: %x | BTA[0]: %x", dut.PC[0].value, dut.BTA[0].value) 
    dut._log.info("PC[1]: %x | BTA[1]: %x", dut.PC[1].value, dut.BTA[1].value)
    dut._log.info("PC[2]: %x | BTA[2]: %x", dut.PC[2].value, dut.BTA[2].value)
    dut._log.info("Output: %x ",dut.branchTargetOut.value)  
    dut._log.info("Hitflag: %x ",dut.hitFlag.value)  
    dut._log.info("match0: %x | match1: %x | match2: %x ",dut.match[0].value ,dut.match[1].value,dut.match[2].value)
@cocotb.test()
async def testBranchTargetBuffer(dut):
    dut.reset.value = 0
    dut.PCIn.value = 0xDDDDDDDD
    dut.branchTargetIn.value = 0xDDDDDDDD
    clock = Clock(dut.clk, 100, units="ms")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    


    dut.PCIn.value = 0
    dut.branchTargetIn.value = 0
    # hit = 1, 
    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    
    dut.PCIn.value = 0x14
    dut.branchTargetIn.value = 0xDE 
    await Timer(1,units="ns")
    await showBranchTargetBuffer(dut);

    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0xf8
    dut.branchTargetIn.value = 0x38
    await Timer(1,units="ns")
    await showBranchTargetBuffer(dut);


    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0x24
    dut.branchTargetIn.value = 0x34
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);

    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0x14
    dut.branchTargetIn.value = 0xff
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);

    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0xe7
    dut.branchTargetIn.value = 0x44
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);

    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0xe7
    dut.branchTargetIn.value = 0x44
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);

    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0xdc
    dut.branchTargetIn.value = 0x18
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);
    
    await RisingEdge(dut.clk); #--------------------
    print("posedge ---------------")
    dut.PCIn.value = 0xe7
    dut.branchTargetIn.value = 0x44
    await Timer(1,units="ns")

    await showBranchTargetBuffer(dut);

