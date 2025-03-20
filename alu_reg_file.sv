`timescale 1ns / 1ps
module alu_reg_file (input logic rst, clk, wr_en, ALUSrc2, ALUSrc1,
                     input logic [2:0] rd0_addr, rd1_addr, wr_addr,
                     input logic [3:0] ALUOp,
                     input logic [15:0] wr_data, alu_input2_instr_src,
                     output logic ovf, take_branch,
                     output logic [15:0] result, input1, input2);
                     
                     logic [15: 0] rd0_data, rd1_data;
                     reg_file RF(rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data);
                     Mux2t1 M1(rd0_data, 16'b0, ALUSrc1, input1);
                     Mux2t1 M2(rd1_data, alu_input2_instr_src, ALUSrc2, input2);
                     alu ALU1(input1, input2, ALUOp, result, ovf, take_branch);
endmodule

module regfile(input logic rst, clk, wr_en,
                input logic[2:0] rd0_addr, rd1_addr, wr_addr,
                input logic[15:0] wr_data,
                output logic[15:0] rd0_data, rd1_data);
               
                reg [15:0] arr [0 : 2];
                always_comb
                  begin
                  arr[wr_addr] = wr_data;
                  rd0_data = arr[rd0_addr];
                  rd1_data = arr[rd1_addr];
                end
endmodule

module TwoToOneMux(input logic[15:0] data1, data2,
              input logic sel,
              output logic[15:0] d);
              always_comb
              begin
               if(sel)
                d = data2;
               else
                d = data1;
              end
endmodule

module alu(input logic[15:0] a, b,
           input logic[3:0] s,
           output logic[15:0] f,
           output logic ovf, take_branch);
           
           always_comb
            begin
              f = 0;
              ovf = 0;
              take_branch = 0;
                case(s)
                    4'b0000:
                    begin
                        f = a + b;
                        ovf = (a[15] & b[15] & ~f[15]) | (~a[15] & ~b[15] & f[15]);
                    end
                    4'b0001:
                        f = ~b;
                   4'b0010:
                        f = a & b;
                    4'b0011:
                        f = a | b;
                    4'b0100:
                        f = a >>> b;
                    4'b0101:
                        f = a << b;
                    4'b0110:
                        take_branch = (a == 0);
                    4'b0111:
                        take_branch = (a != 0);
                    4'b1000:
                        f = a ^ b
                    default:;
               endcase
            end
endmodule
