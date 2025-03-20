`timescale 1ns / 1ps

module instruction_decoder_tb();
    logic[6:0] immediate;
    logic[5:0] nzimm;
    logic[8:0] offset;
    logic[3:0] opcode_in, opcode_out, ALUOp;
    logic RegWrite, RegDst, ALUSrc1, ALUSrc2, MemWrite, MemToReg, RegSrc;
    logic[15:0] instr_i;
    
    instruction_decoder ID(.immediate(immediate), .nzimm(nzimm), .offset(offset), .opcode_in(opcode_in),
                            .RegWrite(RegWrite), .RegDst(RegDst), .ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2),
                            .MemWrite(MemWrite), .MemToReg(MemToReg), .RegSrc(RegSrc), .opcode_out(opcode_out),
                            .ALUOp(ALUOp), .instr_i(instr_i));
                            
    initial begin
        $monitor("%d -> opcode: %b", $time, opcode_in);
        #10 opcode_in = 4'b0000;
            immediate = 10;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0001;
            immediate = 10;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0010;
            immediate = 0;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0011;
            immediate = 0;
            offset = 0;
            nzimm = 10;
        #10 opcode_in = 4'b0100;
            immediate = 0;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0101;
            immediate = 10;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0110;
            immediate = 0;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b0111;
            immediate = 0;
            offset = 0;
            nzimm = 0;
        #10 opcode_in = 4'b1000;
            immediate = 0;
            offset = 0;
            nzimm = 10;
        #10 opcode_in = 4'b1001;
            immediate = 0;
            offset = 0;
            nzimm = 10;
        #10 opcode_in = 4'b1010;
            immediate = 0;
            offset = 10;
            nzimm = 0;
        #10 opcode_in = 4'b1011;
            immediate = 0;
            offset = 10;
            nzimm = 0;
        #10 $finish;
    end
endmodule
