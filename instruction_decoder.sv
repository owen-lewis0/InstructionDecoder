`timescale 1ns / 1ps

module instruction_decoder(input logic[6:0] immediate,
                           input logic[5:0] nzimm,
                           input logic[8:0] offset,
                           input logic[3:0] opcode_in,
                           output logic RegWrite, RegDst, ALUSrc1, ALUSrc2, MemWrite, MemToReg, RegSrc,
                           output logic[3:0] opcode_out, ALUOp,
                           output logic[15:0] instr_i);
                           
                           always_comb
                           begin
                               opcode_out = opcode_in;
                               ALUSrc1 = 0;
                               MemToReg = opcode_in == 4'b0000;
                               MemWrite= opcode_in == 4'b0001;
                               case(opcode_in)
                               //LOAD WORD -> lw
                                4'b0000:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = immediate;
                                    ALUSrc2 = 1;
                                    ALUOp = 0;
                                    RegSrc = 0;
                                end
                                
                                //STORE WORD -> sw
                                4'b0001:
                                begin
                                    RegWrite = 0;
                                    RegDst = 0;
                                    instr_i = immediate;
                                    ALUSrc2 = 1;
                                    ALUOp = 0;
                                    RegSrc = 0;
                                end
                                
                                //ADD -> add
                                4'b0010:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = 0;
                                    ALUSrc2 = 0;
                                    ALUOp = 0;
                                    RegSrc = 1;
                                end
                                
                                //ADD IMMEDIATE -> addi
                                4'b0011:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = nzimm;
                                    ALUSrc2 = 1;
                                    ALUOp = 0;
                                    RegSrc = 1;
                                end
                                
                                //AND -> and
                                4'b0100:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = 0;
                                    ALUSrc2 = 0;
                                    ALUOp = 2;
                                    RegSrc = 1;
                                end
                                
                                //AND IMMEDIATE -> andi
                                4'b0101:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = immediate;
                                    ALUSrc2 = 1;
                                    ALUOp = 2;
                                    RegSrc = 1;
                                end
                                
                                //OR -> or
                                4'b0110:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = 0;
                                    ALUSrc2 = 0;
                                    ALUOp = 3;
                                    RegSrc = 1;
                                end
                                
                                //XOR -> xor
                                4'b0111:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = 0;
                                    ALUSrc2 = 1;
                                    ALUOp = 8;
                                    RegSrc = 1;
                                end
                                
                                //ARITHMETIC RIGHT SHIFT IMMEDIATE -> srai
                                4'b1000:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = nzimm;
                                    ALUSrc2 = 1;
                                    ALUOp = 4;
                                    RegSrc = 1;
                                end
                                
                                //LOGICAL SHIFT LEFT IMMEDIATE -> slli
                                4'b1001:
                                begin
                                    RegWrite = 1;
                                    RegDst = 1;
                                    instr_i = nzimm;
                                    ALUSrc2 = 1;
                                    ALUOp = 5;
                                    RegSrc = 1;
                                end
                                
                                //BRANCH EQUALS -> beqz
                                4'b1010:
                                begin
                                    RegWrite = 0;
                                    RegDst = 0;
                                    instr_i = offset;
                                    ALUSrc2 = 1;
                                    ALUOp = 6;
                                    RegSrc = 0;
                                end
                                
                                //BRANCH NOT EQUALS -> bneqz
                                4'b1011:
                                begin
                                    RegWrite = 0;
                                    RegDst = 0;
                                    instr_i = offset;
                                    ALUSrc2 = 1;
                                    ALUOp = 7;
                                    RegSrc = 0;
                                end
                             endcase
                           end     
endmodule
