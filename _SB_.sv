`ifndef _sb_
`define _sb_
`include "_BP_.sv"
class scoreboard;
basepkt pkt1,pkt2;
mailbox tx2sb,mon2sb;
bit[3:0]array[16];
int i;
//int1 q[$];
int data;

function new(basepkt pkt1,pkt2,mailbox tx2sb,mon2sb);
this.pkt1=pkt1;
this.pkt2=pkt2;
this.tx2sb=tx2sb;
this.mon2sb=mon2sb;
endfunction

extern task run();
extern task push_data();
extern task pop_data();
endclass

task scoreboard::run();
$display($time,"scoreboard::run phase");
fork
push_data();
pop_data();
join_none
endtask

task scoreboard::push_data();
while(1)
begin
tx2sb.get(pkt1);
$display($time,"SCOREBOARD tx2sbb basepkt_pkt1=%p",pkt1);
if(pkt1.wr==1) //write operation 
begin
array[i]=pkt1.datain;
$display($time,"SCOREBOARD pkt1.datain=%p",pkt1.datain);

end
end
endtask

task scoreboard::pop_data();
while(1)
begin
mon2sb.get(pkt2);
$display($time,"SCOREBOARD mon2sbbbb basepkt_pkt2=%p",pkt2);
if(pkt2.rd==1) //read operation
begin
$display($time,"SCOREBOARD  basepkt_pkt=%p",pkt1.dataout);
if(pkt2.dataout==array[i])
$display($time,"scoreboard DATAMATCHED,pkt2.dataout=%p,data=%p",pkt2.dataout,data);
else
$display($time,"scoreboard DATANOTMATCHED, pkt2.dataout=%p,data=%p",pkt2.dataout,data);
end
end
endtask
`endif

