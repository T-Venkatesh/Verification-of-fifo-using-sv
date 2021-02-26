 module DUT(intif.dut inf);

 fifo vcode(.clk(inf.clk),.rst(inf.rst),.wr(inf.wr),.rd(inf.rd),.datain(inf.datain),.full(inf.full),.empty(inf.empty),.dataout(inf.dataout));
endmodule
