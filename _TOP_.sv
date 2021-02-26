
`include "_INTERFACE_.sv"
`include "DUT VERILOG.v"
`include "_DUT_.sv"
`include"_TB_.sv"
module TOP_fifo();
bit clk;
bit rst;

initial
begin
clk=0;
forever #5 clk= ~clk;
end

initial
begin
rst=0;
#11;
 rst=1;
end
intif infc(clk,rst);
DUT dut(infc);
test tb(infc);

endmodule
