module mux32(
    output reg [31:0] out,
    input wire [31:0] a,
    input wire [31:0] b,
    input wire selector
);
     always @(*) begin
        case (selector)
            1'b0: out = a; 
            1'b1: out = b;
        endcase
    end
endmodule

module mux5(
    output reg [4:0] out,
    input wire [4:0] a,
    input wire [4:0] b,
    input wire selector
);
     always @(*) begin
        case (selector)
            1'b0: out = a; 
            1'b1: out = b;
        endcase
    end
endmodule