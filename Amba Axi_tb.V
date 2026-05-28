// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb;

reg clk;
reg reset;


// wires

wire [3:0] AWADDR;
wire [7:0] WDATA;

wire AWVALID;
wire WVALID;

wire AWREADY;
wire WREADY;

wire [3:0] ARADDR;
wire ARVALID;
wire ARREADY;

wire [7:0] RDATA;
wire RVALID;
wire RREADY;



// MASTER

axi_master M(

.clk(clk),
.reset(reset),

.AWREADY(AWREADY),
.WREADY(WREADY),

.ARREADY(ARREADY),
.RVALID(RVALID),

.RDATA(RDATA),

.AWADDR(AWADDR),
.WDATA(WDATA),

.AWVALID(AWVALID),
.WVALID(WVALID),

.ARADDR(ARADDR),
.ARVALID(ARVALID),

.RREADY(RREADY)

);


// SLAVE

axi_slave S(

.clk(clk),

.AWADDR(AWADDR),
.WDATA(WDATA),

.AWVALID(AWVALID),
.WVALID(WVALID),

.ARADDR(ARADDR),
.ARVALID(ARVALID),

.RREADY(RREADY),

.AWREADY(AWREADY),
.WREADY(WREADY),

.RDATA(RDATA),
.RVALID(RVALID),

.ARREADY(ARREADY)

);


// clock

always #5 clk=~clk;


// stimulus

initial
begin

clk=0;
reset=1;

#10;

reset=0;

#100;

$finish;

end


initial
begin
$dumpfile("axi.vcd");
$dumpvars;
end


endmodule