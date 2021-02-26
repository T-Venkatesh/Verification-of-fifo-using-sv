`ifndef _txgen_
`define _txgen_
`include "_BP_.sv"
`include "_CFG_.sv"

class txgen;
basepkt pkt;
mailbox tx2sb,tx2drv;
configuration cfg;
bit[3:0]datainout;

extern function new(basepkt pkt, mailbox tx2sb,tx2drv,configuration cfg);
extern task run();
extern function bit[3:0]calc_datain(configuration cfg);
endclass



function txgen::new(basepkt pkt, mailbox tx2sb,tx2drv,configuration cfg);
this.pkt=pkt;
this.tx2sb=tx2sb;
this.tx2drv=tx2drv;
this.cfg=cfg;
this.datainout=cfg.txdata;
endfunction


task txgen::run();
begin
repeat(cfg.num_txns)
begin
  case(cfg.cmd)
BURST_WR:
    repeat(20)                     //WRITE OPERATION
    begin
    pkt.datain=calc_datain(cfg);
    pkt.wr=1'b1;
    pkt.rd=1'b0;
    tx2drv.put(pkt);
    tx2sb.put(pkt);
    end
   
BURST_RD:
   repeat(8)                       //READ OPERATION
   begin
   pkt.datain=calc_datain(cfg);
   pkt.wr=1'b0;
   pkt.rd=1'b1;
   tx2drv.put(pkt);
   tx2sb.put(pkt);
   end

WR_RD:
repeat(10)
   begin
#10;
    begin
    pkt.datain=calc_datain(cfg);         //WRITE && READ OPERATION
    pkt.wr=1'b1;
    pkt.rd=1'b0;                  
    tx2drv.put(pkt);
    $display($time,"TX2DRV WRITEEEE basepkt=%p",pkt);
    tx2sb.put(pkt);
    $display($time,"TX2SB  WRITEEEE  basepkt=%p",pkt);
  #10;
    pkt.wr=1'b0;
    pkt.rd=1'b1;
    tx2drv.put(pkt);
    $display($time,"TX2DRV READ basepkt=%p",pkt);
    tx2sb.put(pkt);
    $display($time,"TX2SB READ Pbasepkt=%p",pkt);
end
 end 
endcase
end
end
endtask


 
function bit[3:0]txgen::calc_datain(configuration cfg);
begin
 case(cfg.data1)
random1:begin datainout=$random; return datainout;end                                                                                                    
constant_data:begin return datainout;end
incremental1:begin  return datainout++;end
decremental1:begin return datainout--;end
endcase
end
endfunction
`endif

 
 






