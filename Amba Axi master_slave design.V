// Code your design here
module axi_master(

input clk,
input reset,

input AWREADY,
input WREADY,
input ARREADY,
input RVALID,

input [7:0] RDATA,

output reg [3:0] AWADDR,
output reg [7:0] WDATA,
output reg AWVALID,
output reg WVALID,

output reg [3:0] ARADDR,
output reg ARVALID,
output reg RREADY

);

always @(posedge clk or posedge reset)
begin

if(reset)
begin
    AWVALID<=0;
    WVALID<=0;
    ARVALID<=0;
    RREADY<=0;
end

else
begin

// WRITE

AWADDR<=4'd2;
WDATA<=8'hAA;

AWVALID<=1;
WVALID<=1;


// READ

ARADDR<=4'd2;
ARVALID<=1;

RREADY<=1;

end

end

endmodule

module axi_slave(

input clk,

input [3:0] AWADDR,
input [7:0] WDATA,

input AWVALID,
input WVALID,

input [3:0] ARADDR,
input ARVALID,

input RREADY,

output reg AWREADY,
output reg WREADY,

output reg [7:0] RDATA,
output reg RVALID,
output reg ARREADY

);

reg [7:0] mem[0:15];


always @(posedge clk)
begin

// WRITE ADDRESS HANDSHAKE

if(AWVALID)
begin
    AWREADY<=1;
end

if(WVALID)
begin
    WREADY<=1;

    mem[AWADDR]<=WDATA;
end


// READ

if(ARVALID)
begin

    ARREADY<=1;

    RDATA<=mem[ARADDR];

    RVALID<=1;

end


if(RREADY)
RVALID<=0;

end

endmodule