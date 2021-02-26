`ifndef _drv_
`define _drv_
`include "_BP_.sv"

class driver;
basepkt pkt;
mailbox tx2drv;
virtual intif inf;
extern function new(basepkt pkt,mailbox tx2drv,virtual intif inf);
extern  task run();
endclass

function driver::new(basepkt pkt,mailbox tx2drv,virtual intif inf);
this.pkt=pkt;
this.tx2drv=tx2drv;
this.inf=inf;
endfunction

task driver::run();
while(1)
begin
@(posedge inf.clk);
tx2drv.get(pkt);
 $display($time,"DRIVERRRRRRRRRR pkt.wr=%d,pkt.rd=%d,pkt.datain=%d",pkt.wr,pkt.rd,pkt.datain);
begin
    if((pkt.wr)&&(pkt.rd==0))
    begin
    inf.datain=pkt.datain;
    inf.wr=pkt.wr;
    inf.rd=pkt.rd;
    $display($time,"DRIVER::WRITE OPERATION pkt.wr=%d,pkt.rd=%d,pkt.datain=%d",pkt.wr,pkt.rd,pkt.datain);
    end
else
  begin
     if((pkt.rd)&&(pkt.wr==0)) 
    begin
    inf.wr=pkt.wr;
    inf.rd=pkt.rd;
    $display($time,"driver:READ pkt.wr=%d,pkt.rd=%d,pkt.datain=%d",pkt.wr,pkt.rd,pkt.datain);
    end
 end
end
end

endtask
`endif
