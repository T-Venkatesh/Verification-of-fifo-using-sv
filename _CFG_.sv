`ifndef _config_
`define _config_

typedef enum{BURST_RD,BURST_WR, WR_RD}cmd_type;
typedef enum{random1,constant_data,incremental1,decremental1}data_type;


class configuration;
rand cmd_type cmd;
rand data_type data1;
int num_txns;
rand bit[3:0]txdata;
endclass
`endif
  