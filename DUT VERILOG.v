module fifo(input clk,rst,wr,rd,input [3:0]datain,
            output full,empty,output reg [3:0]dataout);//,
reg [3:0] wr_ptr;
reg [3:0]rd_ptr;
reg[3:0]mem[0:15];



always@(posedge clk)
begin
if(rst==0)
dataout<=4'b0;
else if((wr==1)&&(full==0))
mem[wr_ptr]<=datain;       //write operation
else if((rd==1)&&(empty==0))
dataout<=mem[rd_ptr];    //read operation
end

always@(posedge clk)
begin
if(rst==0)
    begin
    wr_ptr<=0;
    rd_ptr<=0;
    end
else

     begin
     if(full==0&&wr)
     wr_ptr<=wr_ptr+1;
     
     if(empty==0&&rd)
     rd_ptr<=rd_ptr+1;
     end

end
assign full = (wr_ptr == 15&& rd_ptr==0)?1'b1:1'b0;
assign empty = ( wr_ptr == rd_ptr)?1'b1:1'b0;
endmodule









