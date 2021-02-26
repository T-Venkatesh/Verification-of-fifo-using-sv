`ifndef _env_
`define _env_
`include "_BP_.sv"
`include "_TXGEN_.sv"
`include "_DRV_.sv"
`include "_MON_.sv"
`include "_SB_.sv"
`include "_CFG_.sv"
class environ;
basepkt pkt1,pkt2;
mailbox tx2drv,tx2sb,mon2sb;
virtual intif inf;
configuration cfg;

txgen tx;
driver drv;
monitor mon;
scoreboard sb;

function new(virtual intif inf,configuration cfg);
pkt1=new();
pkt2=new();
tx2drv=new();
tx2sb=new();
mon2sb=new();
this.inf=inf;
this.cfg=cfg;



tx=new(pkt1,tx2drv,tx2sb,cfg);
drv=new(pkt1,tx2drv,inf);
mon=new(pkt2,mon2sb,inf);
sb=new(pkt1,pkt2,tx2sb,mon2sb);
endfunction


task env_run();
begin
$display($time,"environ::run phase");
begin
fork
tx.run();
drv.run();
mon.run();
sb.run();
join
end
end
endtask
endclass
`endif

