module  fifomem #(parameter DATASIZE = 8,
				parameter ADDRSIZE = 4) 
	(
	 output [DATASIZE-1:0] rdata,
	 input	[DATASIZE-1:0]	wdata,
	 input	[ADDRSIZE-1:0]	waddr, raddr,
	 input					wclken, wfull, wclk
	);

	 // RTL Verilog memory model
	 localparam DEPTH = 1<<ADDRSIZE;  //depth is 2^3
	 reg [DATASIZE-1:0] mem [0:DEPTH-1];
	 assign rdata     = mem[raddr];
	 always @(posedge wclk) begin
	 if (wclken && !wfull) mem[waddr] <= wdata;
    end
endmodule