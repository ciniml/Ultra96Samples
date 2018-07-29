`timescale 1ns / 1ps
`default_nettype none 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/28 23:08:39
// Design Name: 
// Module Name: blink
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blink
#(
    parameter MAX_COUNT = 100000000
) (
    input wire clock,
    output wire blink_out
);

localparam W = $clog2(MAX_COUNT);

reg [W-1:0] counter = 0;

assign blink_out = counter < (MAX_COUNT/2) ? 1'b1 : 1'b0;

always @(posedge clock) begin
    counter <= counter < MAX_COUNT - 1 ? counter + 1 : 0;
end 

endmodule

`default_nettype wire
