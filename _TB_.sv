`include "_ENV_.sv"
`include "_CFG_.sv"


program test(intif.tb infc);
configuration cfg;
environ env;
initial
begin
cfg=new();
cfg.num_txns=10;
cfg.cmd=WR_RD;
cfg.data1=random1;
env=new(infc,cfg);
env.env_run();
end
endprogram

