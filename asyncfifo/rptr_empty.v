module rptr_empty
#(
    parameter ADDRSIZE = 4
)
(
    output reg                rempty,
    output     [ADDRSIZE-1:0] raddr, //binary ptr
    output reg [ADDRSIZE  :0] rptr,  //gray code ptr
    input      [ADDRSIZE  :0] rq2_wptr, //pointer after sync
    input                     rq, rclk, rrst_n
);
  reg  [ADDRSIZE:0] rbin;
  wire [ADDRSIZE:0] rgraynext, rbinnext;
 // GRAYSTYLE2 pointer
 // sync graycode read pointer with binary read pointer
  always @(posedge rclk or negedge rrst_n) begin
      if (!rrst_n) begin
          rbin <= 0;
          rptr <= 0;
      end
      else begin
          rbin<=rbinnext;
          rptr<=rgraynext; //output to sync_r2w.v
      end
  end
  // Memory read-address pointer (okay to use binary to address memory)
  assign raddr     = rbin[ADDRSIZE-1:0]; //
  assign rbinnext  = rbin + (rq & ~rempty); //not empty and read request, then plus 1
  assign rgraynext = (rbinnext>>1) ^ rbinnext; //graycode,左移一位异或本身得到格雷码

  // FIFO empty when the next rptr == synchronized wptr or on reset
  assign rempty_val = (rgraynext == rq2_wptr); //empty when read graycode equal write prt after sync
  always @(posedge rclk or negedge rrst_n) begin
      if (!rrst_n)
          rempty <= 1'b1;
      else
          rempty <= rempty_val;
  end
endmodule