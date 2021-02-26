`ifndef _Mon_
`define _Mon_
`include "_BP_.sv"
class monitor;
basepkt pkt;
mailbox mon2sb;
virtual intif inf;
extern function new(basepkt pkt,mailbox mon2sb,virtual intif inf);
extern task run();
endclass

function monitor::new(basepkt pkt,mailbox mon2sb,virtual intif inf);
this.pkt=pkt;
this.mon2sb=mon2sb;
this.inf=inf;
endfunction

task monitor::run();
begin
while(1)
begin
@(posedge inf.clk);
pkt.rd=inf.rd;
begin
if(pkt.rd==1)
begin
pkt.rd=inf.rd;
pkt.dataout=inf.dataout;
$display($time,"MONITOR222: read dataout=%p",pkt);
mon2sb.put(pkt);
$display($time,"MONITORRR: read dataout=%p",pkt);
end
end
end
end
endtask
`endif

