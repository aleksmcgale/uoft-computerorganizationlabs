module shifter(SW, KEY, LEDR);
    input [9:0] SW;
    input [3:0] KEY;
    output [7:0] LEDR;
    
    wire [7:0] Q;
    wire asrq;
    
    assign Q = LEDR;
    
    mux2to1 m0(
	.x(1'b0),
	.y(Q[7]),
	.s(KEY[3]),
	.m(asrq)
    );
    
    shifter_bit s7(
	.load_val(SW[7]), 
	.in(asrq), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[7])
    );
    
    shifter_bit s6(
	.load_val(SW[6]), 
	.in(Q[7]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[6])
    );
    
    shifter_bit s5(
	.load_val(SW[5]), 
	.in(Q[6]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[5])
    );
    
    shifter_bit s4(
	.load_val(SW[4]), 
	.in(Q[5]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[4])
    );
    
    shifter_bit s3(
	.load_val(SW[3]), 
	.in(Q[4]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[3])
    );
    
    shifter_bit s2(
	.load_val(SW[2]), 
	.in(Q[3]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[2])
    );
    
    shifter_bit s1(
	.load_val(SW[1]), 
	.in(Q[2]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[1])
    );
    
    shifter_bit s0(
	.load_val(SW[0]), 
	.in(Q[1]), 
	.shift(KEY[2]), 
	.load_n(KEY[1]), 
	.clk(KEY[0]), 
	.reset_n(SW[9]), 
	.out(LEDR[0])
    );
endmodule
    

module shifter_bit(load_val, in, shift, load_n, clk, reset_n, out);
    input load_val, in, shift, load_n, clk, reset_n;
    output out;
    
    wire w0, w1;
    
    mux2to1 m0(
        .x(out),
        .y(in),
        .s(shift),
        .m(w0)
    );
    
    mux2to1 m1(
        .x(load_val),
        .y(w0),
        .s(load_n),
        .m(w1)
    );
    
    dflipflop d0(
	.d(w1),
	.q(out),
	.reset_n(reset_n),
	.clock(clk)
    );
endmodule
	
    
        
    


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule

module dflip_flop(d, q, reset_n, clock);

    input d;
    input reset_n;
    input clock;
    output q;
    
    reg q;
    
    
    always @(posedge clock) 
    begin
	if (reset_n == 1'b0)
	    q <= 0;
	else
	    q <= d;
    end
endmodule