module sync_r2w
#(
    parameter ADDRSIZE = 4
)
(
    output reg [ADDRSIZE:0] wq2_rptr,   //read ptr sync to write clock domain
    input      [ADDRSIZE:0] rptr,       //gray code pointer
    input                   wclk, wrst_n
);

reg [ADDRSIZE:0] wq1_rptr;

always @(posedge wclk or negedge wrst_n)
      if (!wrst_n) begin
          wq1_rptr <= 0;
          wq2_rptr <= 0;
      end
      else begin
          wq1_rptr<= rptr;
          wq2_rptr<=wq1_rptr;
      end
endmodule