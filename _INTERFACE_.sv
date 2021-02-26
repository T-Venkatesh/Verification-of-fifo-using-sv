interface intif(input clk,rst);
logic wr;
logic rd;
logic [3:0]datain;
logic full;
logic empty;
logic [3:0]dataout;

clocking cb@(posedge clk);
default input #1ns output #1ns;
endclocking



modport dut(input clk,rst,wr,rd,datain,output full,empty,dataout);
modport tb(output wr,rd,datain,input clk,rst,full,empty,dataout);
endinterface


