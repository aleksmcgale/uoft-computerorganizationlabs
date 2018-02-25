module morse_code(SW, KEY, LEDR0);
    input [4:0] SW;
    input [1:0] KEY0;
    output LEDR0;
    
    wire [13:0] w0;
    wire en;
    
    LUT l0(
	.x(SW[2:0]),
	.y(w0)
    );
    
    rate_divider r0(
	.enable(SW[3]),
	.load(````)
	.clock(CLOCK_50),
	.reset_n(KEY[1]),
	.q(en)
    );
    
    shift_register s1(
	.en(en),
	.load(w0);
	.par_load(KEY[1]),
	.clear_b(KEY[0]),
	.out(LEDR0)
    );
endmodule
    
module LUT(x, y);
    input [2:0] x;
    output reg [13:0] y;
    
    always @(*)
    begin 
        case(x)
            3'b000: y = 14'b10_1010_0000_0000;
	    3'b001: y = 14'b11_1000_0000_0000;
	    3'b010: y = 14'b10_1011_1000_0000;
	    3'b011: y = 14'b10_1010_1110_0000;
	    3'b100: y = 14'b10_1110_1110_0000;
	    3'b101: y = 14'b11_1010_1011_1000;
	    3'b110: y = 14'b11_1010_1110_1110;
	    3'b111: y = 14'b11_1011_1010_1000;
	endcase
    end
	
endmodule

module rate_divider(enable, clock, load, reset_n, q)
    input enable, clock, load, reset_n;
    output [3:0] q;
    
    reg [3:0] q;
    
    always @(posedge clock ) 
    begin
        if (reset n == 1’b0) 
            q <= 0;

        ￼￼else if (par_load == 1’b1) //
￼           q <= load;
        else if (enable == 1’b1)
            begin
                if (q == 4’b1111)
                    q <= 0;
                else
                q <= q + 1'b1;
            end 
    end
endmodule

module shift_register(en, x, par_load, clock, clear_b, q);
    input clear_b;
    input [13:0] x;
    input par_load;
    input en;
    input clock;
    output q;
    
    reg q;
    
    
    always @(posedge Clock, negedge Clear_b) 
    begin
	if (~Clear_b)
	    q <= 0;
	else
	    q <= ~q;
    end
endmodule
