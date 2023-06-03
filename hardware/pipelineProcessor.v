// Copyright (C) 2021  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"
// CREATED		"Sat Jun  3 23:23:11 2023"

module pipelineProcessor(
	clk,
	reset
);


input wire	clk;
input wire	reset;

wire	[3:0] ALUControlD;
wire	[3:0] ALUControlE;
wire	[3:0] ALUFlags;
wire	[31:0] ALUOut;
wire	[31:0] ALUOutM;
wire	[31:0] ALUOutW;
wire	ALUSrcD;
wire	ALUSrcE;
wire	branchD;
wire	branchE;
wire	condEx;
wire	[3:0] condition;
wire	[3:0] conditionE;
wire	[63:0] decodeRegisterD;
wire	[63:0] decodeRegisterF;
wire	destinationSrcE;
wire	destinationSrcM;
wire	destinationSrcW;
wire	[157:0] executeRegisterD;
wire	[157:0] executeRegisterE;
wire	[31:0] extentedImm;
wire	[31:0] extentedImmD;
wire	[1:0] flagWriteD;
wire	[1:0] flagWriteE;
wire	[5:0] func;
wire	[23:0] imm24;
wire	[1:0] immSrcD;
wire	[31:0] instructionD;
wire	[31:0] instructionF;
wire	[106:0] memoryStageRegisterE;
wire	[106:0] memoryStageRegisterM;
wire	memWriteD;
wire	memWriteE;
wire	memWriteM;
wire	movImm;
wire	[1:0] op;
wire	[31:0] PC4D;
wire	[31:0] PC4E;
wire	[31:0] PC4M;
wire	[31:0] PC4W;
wire	[31:0] PCF;
wire	[31:0] PCplus4F;
wire	[31:0] PCplus8D;
wire	[31:0] PCprime;
wire	PCSrcD;
wire	PCSrcE;
wire	PCSrcM;
wire	PCSrcW;
wire	[3:0] Rd;
wire	[31:0] readDataM;
wire	[31:0] readDataW;
wire	regDataSrcD;
wire	regDataSrcE;
wire	regDataSrcM;
wire	regDataSrcW;
wire	[1:0] regSrcD;
wire	regWriteD;
wire	regWriteE;
wire	regWriteM;
wire	regWriteW;
wire	[1:0] resultSrcD;
wire	[1:0] resultSrcE;
wire	[1:0] resultSrcM;
wire	[1:0] resultSrcW;
wire	[31:0] resultW;
wire	[3:0] Rm;
wire	[3:0] Rn;
wire	[4:0] shamtD;
wire	[4:0] shamtE;
wire	[1:0] shD;
wire	[1:0] shE;
wire	[31:0] shiftedE;
wire	[31:0] srcAE;
wire	[31:0] srcBE;
wire	[3:0] WA3D;
wire	[3:0] WA3E;
wire	[3:0] WA3M;
wire	[3:0] WA3W;
wire	[136:0] writebackRegisterM;
wire	[136:0] writebackRegisterW;
wire	[31:0] writeDataE;
wire	[31:0] writeDataM;
wire	[31:0] writeDataW;
wire	SYNTHESIZED_WIRE_0;
wire	[3:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[3:0] SYNTHESIZED_WIRE_13;
wire	[3:0] SYNTHESIZED_WIRE_14;
wire	[3:0] SYNTHESIZED_WIRE_15;
wire	[1:0] SYNTHESIZED_WIRE_16;
wire	[1:0] SYNTHESIZED_WIRE_17;
wire	[3:0] SYNTHESIZED_WIRE_18;

assign	SYNTHESIZED_WIRE_0 = 0;
assign	SYNTHESIZED_WIRE_10 = 0;




ALU	b2v_ALU(
	.clk(clk),
	.carry(SYNTHESIZED_WIRE_0),
	.A(srcAE),
	.B(srcBE),
	.CTRL(ALUControlE),
	.C(ALUFlags[1]),
	.V(ALUFlags[0]),
	.N(ALUFlags[3]),
	.Z(ALUFlags[2]),
	.OUT(ALUOut));
	defparam	b2v_ALU.W = 32;


combinationalShifter	b2v_combinationalShifter(
	.ctrl(shE),
	.in_data(writeDataE),
	.shamt(shamtE),
	.out(shiftedE));
	defparam	b2v_combinationalShifter.W = 32;


controlUnit	b2v_controlUnit(
	.funct(func),
	.op(op),
	.regDataSrc(regDataSrcD),
	.PCSrc(PCSrcD),
	.branch(branchD),
	.regWrite(regWriteD),
	.memWrite(memWriteD),
	.ALUSrc(ALUSrcD),
	.destinationSrc(SYNTHESIZED_WIRE_9),
	.movImm(movImm),
	.ALUControl(ALUControlD),
	.flagWrite(flagWriteD),
	.immSrc(immSrcD),
	.regSrc(regSrcD),
	.resultSrc(resultSrcD));


memory	b2v_dataMemory(
	.clk(clk),
	.WE(memWriteM),
	.ADDR(ALUOutM),
	.WD(writeDataM),
	.RD(readDataM));
	defparam	b2v_dataMemory.ADDR_WIDTH = 32;
	defparam	b2v_dataMemory.BYTE_SIZE = 4;


mux2to1	b2v_dataMux(
	.sel(regDataSrcW),
	.in0(resultW),
	.in1(PC4W),
	.out(SYNTHESIZED_WIRE_12));
	defparam	b2v_dataMux.W = 32;


simpleRegister	b2v_decodeRegister(
	.reset(reset),
	.clk(clk),
	.data(decodeRegisterF),
	.out(decodeRegisterD));
	defparam	b2v_decodeRegister.W = 64;


mux2to1	b2v_destinationMux(
	.sel(destinationSrcW),
	.in0(WA3W),
	.in1(SYNTHESIZED_WIRE_1),
	.out(SYNTHESIZED_WIRE_13));
	defparam	b2v_destinationMux.W = 4;


simpleRegister	b2v_executeRegister(
	.reset(reset),
	.clk(clk),
	.data(executeRegisterD),
	.out(executeRegisterE));
	defparam	b2v_executeRegister.W = 158;


extender12or24	b2v_extender(
	.control(immSrcD),
	.data(imm24),
	.out(extentedImmD));


simpleRegister	b2v_fetchRegister(
	.reset(reset),
	.clk(clk),
	.data(PCprime),
	.out(PCF));
	defparam	b2v_fetchRegister.W = 32;


constantValueGenerator	b2v_fifteen(
	.out(SYNTHESIZED_WIRE_18));
	defparam	b2v_fifteen.VAL = 15;
	defparam	b2v_fifteen.W = 4;


fourAdder	b2v_fourAdder(
	.data(PCF),
	.out(PCplus4F));
	defparam	b2v_fourAdder.W = 32;


constantValueGenerator	b2v_fourteen(
	.out(SYNTHESIZED_WIRE_1));
	defparam	b2v_fourteen.VAL = 14;
	defparam	b2v_fourteen.W = 4;


assign	decodeRegisterF[63:32] = instructionF;


assign	func = instructionD[25:20];


assign	condition = instructionD[31:28];


assign	imm24 = instructionD[23:0];


assign	shamtD = instructionD[11:7];


assign	SYNTHESIZED_WIRE_16 = instructionD[6:5];


assign	Rn = instructionD[19:16];


assign	Rm = instructionD[3:0];


assign	Rd = instructionD[15:12];


assign	executeRegisterD[37:36] = shD;


assign	executeRegisterD[42:38] = shamtD;


assign	executeRegisterD[74:43] = SYNTHESIZED_WIRE_2;


assign	decodeRegisterF[31:0] = PCplus4F;


assign	executeRegisterD[106:75] = SYNTHESIZED_WIRE_3;


assign	executeRegisterD[110:107] = condition;




conditionCheck	b2v_inst23(
	.clk(clk),
	.reset(reset),
	.ALUFlags(ALUFlags),
	.condition(conditionE),
	.flagW(flagWriteE),
	.condEx(condEx));

assign	executeRegisterD[142:111] = PC4D;


assign	conditionE = executeRegisterE[110:107];


assign	executeRegisterD[144:143] = flagWriteD;


assign	executeRegisterD[145] = ALUSrcD;


assign	executeRegisterD[149:146] = ALUControlD;


assign	executeRegisterD[151:150] = resultSrcD;


assign	instructionD = decodeRegisterD[63:32];


assign	executeRegisterD[152] = memWriteD;


assign	executeRegisterD[153] = regWriteD;


assign	executeRegisterD[154] = branchD;


assign	executeRegisterD[155] = PCSrcD;


assign	executeRegisterD[156] = regDataSrcD;


assign	flagWriteE = executeRegisterE[144:143];


assign	ALUSrcE = executeRegisterE[145];


assign	ALUControlE = executeRegisterE[149:146];


assign	resultSrcE = executeRegisterE[151:150];


assign	memWriteE = executeRegisterE[152];


assign	PC4D = decodeRegisterD[31:0];


assign	regWriteE = executeRegisterE[153];


assign	branchE = executeRegisterE[154];


assign	PCSrcE = executeRegisterE[155];


assign	regDataSrcE = executeRegisterE[156];


assign	writeDataE = executeRegisterE[74:43];


assign	srcAE = executeRegisterE[106:75];


assign	extentedImm = executeRegisterE[31:0];


assign	WA3E = executeRegisterE[35:32];


assign	shE = executeRegisterE[37:36];


assign	shamtE = executeRegisterE[42:38];


assign	PCplus8D = PCplus4F;


assign	PC4E = executeRegisterE[142:111];


assign	memoryStageRegisterE[104] = SYNTHESIZED_WIRE_4;


assign	SYNTHESIZED_WIRE_6 = PCSrcE & condEx;

assign	SYNTHESIZED_WIRE_5 = branchE & condEx;

assign	SYNTHESIZED_WIRE_7 = regWriteE & condEx;

assign	SYNTHESIZED_WIRE_8 = memWriteE & condEx;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6;

assign	memoryStageRegisterE[3:0] = WA3E;


assign	memoryStageRegisterE[35:4] = PC4E;


assign	memoryStageRegisterE[67:36] = writeDataE;


assign	WA3D = Rd;


assign	memoryStageRegisterE[99:68] = ALUOut;


assign	memoryStageRegisterE[103] = SYNTHESIZED_WIRE_7;


assign	memoryStageRegisterE[102] = SYNTHESIZED_WIRE_8;


assign	memoryStageRegisterE[101:100] = resultSrcE;


assign	WA3M = memoryStageRegisterM[3:0];


assign	PC4M = memoryStageRegisterM[35:4];


assign	writeDataM = memoryStageRegisterM[67:36];


assign	memoryStageRegisterE[105] = regDataSrcE;


assign	PCSrcM = memoryStageRegisterM[104];


assign	regWriteM = memoryStageRegisterM[103];


assign	executeRegisterD[31:0] = extentedImmD;


assign	memWriteM = memoryStageRegisterM[102];


assign	resultSrcM = memoryStageRegisterM[101:100];


assign	regDataSrcM = memoryStageRegisterM[105];


assign	ALUOutM = memoryStageRegisterM[99:68];


assign	writebackRegisterM[135] = regDataSrcM;


assign	writebackRegisterM[134] = PCSrcM;


assign	writebackRegisterM[133] = regWriteM;


assign	writebackRegisterM[132:131] = resultSrcM;


assign	writebackRegisterM[130:99] = readDataM;


assign	writebackRegisterM[98:67] = ALUOutM;


assign	executeRegisterD[35:32] = WA3D;


assign	writebackRegisterM[66:35] = writeDataM;


assign	writebackRegisterM[35:4] = PC4M;


assign	writebackRegisterM[3:0] = WA3M;


assign	regDataSrcW = writebackRegisterW[135];


assign	PCSrcW = writebackRegisterW[134];


assign	regWriteW = writebackRegisterW[133];


assign	resultSrcW = writebackRegisterW[132:131];


assign	readDataW = writebackRegisterW[130:99];


assign	PC4W = writebackRegisterW[35:4];


assign	WA3W = writebackRegisterW[3:0];


assign	op = instructionD[27:26];


assign	ALUOutW = writebackRegisterW[98:67];


assign	writeDataW = writebackRegisterW[66:35];


assign	executeRegisterD[157] = SYNTHESIZED_WIRE_9;


assign	destinationSrcE = executeRegisterE[157];


assign	memoryStageRegisterE[106] = destinationSrcE;


assign	destinationSrcM = memoryStageRegisterM[106];


assign	writebackRegisterM[136] = destinationSrcM;


assign	destinationSrcW = writebackRegisterW[136];



memory	b2v_instructionMemory(
	.clk(clk),
	.WE(SYNTHESIZED_WIRE_10),
	.ADDR(PCF),
	.WD(PCF),
	.RD(instructionF));
	defparam	b2v_instructionMemory.ADDR_WIDTH = 32;
	defparam	b2v_instructionMemory.BYTE_SIZE = 4;


simpleRegister	b2v_memoryStageRegister(
	.reset(reset),
	.clk(clk),
	.data(memoryStageRegisterE),
	.out(memoryStageRegisterM));
	defparam	b2v_memoryStageRegister.W = 107;


mux2to1	b2v_out1Selector(
	.sel(movImm),
	.in0(SYNTHESIZED_WIRE_11),
	.in1(extentedImmD),
	.out(SYNTHESIZED_WIRE_2));
	defparam	b2v_out1Selector.W = 32;


mux2to1	b2v_PCMux(
	.sel(PCSrcW),
	.in0(PCplus4F),
	.in1(resultW),
	.out(PCprime));
	defparam	b2v_PCMux.W = 32;


Register_file	b2v_registerFile(
	.clk(clk),
	.write_enable(regWriteW),
	.reset(reset),
	.DATA(SYNTHESIZED_WIRE_12),
	.Destination_select(SYNTHESIZED_WIRE_13),
	.Reg_15(PCplus8D),
	.Source_select_0(SYNTHESIZED_WIRE_14),
	.Source_select_1(SYNTHESIZED_WIRE_15),
	.out_0(SYNTHESIZED_WIRE_3),
	.out_1(SYNTHESIZED_WIRE_11));
	defparam	b2v_registerFile.WIDTH = 32;


mux4to1	b2v_resultMux(
	.in0(ALUOutW),
	.in1(readDataW),
	
	.in3(writeDataW),
	.sel(resultSrcW),
	.out(resultW));
	defparam	b2v_resultMux.W = 32;


mux2to1	b2v_shSelector(
	.sel(movImm),
	.in0(SYNTHESIZED_WIRE_16),
	.in1(SYNTHESIZED_WIRE_17),
	.out(shD));
	defparam	b2v_shSelector.W = 2;


mux2to1	b2v_source0Mux(
	.sel(regSrcD[1]),
	.in0(Rn),
	.in1(SYNTHESIZED_WIRE_18),
	.out(SYNTHESIZED_WIRE_14));
	defparam	b2v_source0Mux.W = 4;


mux2to1	b2v_source1Mux(
	.sel(regSrcD[0]),
	.in0(Rm),
	.in1(Rd),
	.out(SYNTHESIZED_WIRE_15));
	defparam	b2v_source1Mux.W = 4;


mux2to1	b2v_srcBMux(
	.sel(ALUSrcE),
	.in0(shiftedE),
	.in1(extentedImm),
	.out(srcBE));
	defparam	b2v_srcBMux.W = 32;


constantValueGenerator	b2v_three(
	.out(SYNTHESIZED_WIRE_17));
	defparam	b2v_three.VAL = 3;
	defparam	b2v_three.W = 2;


simpleRegister	b2v_writebackRegister(
	.reset(reset),
	.clk(clk),
	.data(writebackRegisterM),
	.out(writebackRegisterW));
	defparam	b2v_writebackRegister.W = 137;


endmodule
