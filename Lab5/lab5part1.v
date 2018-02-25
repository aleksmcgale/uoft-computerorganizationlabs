module t_flip_flop(Clear_b, Clock, Enable, q);
    input Clear_b;
    input Enable;
    input Clock;
    output q;
    
    reg q;
    
    
    always @(posedge Clock, negedge Clear_b) 
    begin
	if (Clear_b == 1'b0)
	    q <= 0;
	else
	    q <= ~q;
    end
endmodule

module eight_bit_counter(Clear_b, Clock, Enable, Q);
    input Clear_b;
    input Enable;
    input Clock;
    output [7:0] Q;
    
    wire [6:0] a;
    
    t_flip_flop t7(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(Enable), 
	.q(Q[7])
    );
    
    and a7(Enable, Q[7], a[6]);
    
    t_flip_flop t6(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[6]), 
	.q(Q[6])
    );
    
    and a6(Enable, Q[6], a[5]);
    
    t_flip_flop t5(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[5]), 
	.q(Q[5])
    );
    
    and a5(Enable, Q[5], a[4]);
    
    t_flip_flop t4(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[4]), 
	.q(Q[4])
    );
    
    and a4(Enable, Q[4], a[3]);
    
    t_flip_flop t3(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[3]), 
	.q(Q[3])
    );
    
    and a3(Enable, Q[3], a[2]);
    
    t_flip_flop t2(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[2]), 
	.q(Q[2])
    );
    
    and a2(Enable, Q[2], a[1]);
    
    t_flip_flop t1(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[1]), 
	.q(Q[1])
    );
    
    and a1(Enable, Q[1], a[0]);
    
    t_flip_flop t0(
	.Clear_b(Clear_b), 
	.Clock(Clock), 
	.Enable(a[0]), 
	.q(Q[0])
    );
endmodule
    
module sim(KEY, SW, HEX0, HEX1);
	input [0:0] KEY;
	input [1:0] SW;
	output [6:0] HEX0, HEX1;
    
	wire [7:0] q;
    
	eight_bit_counter e0(
		.Clear_b(SW[0]), 
		.Clock(KEY[0]), 
		.Enable(SW[1]), 
		.Q(q)
	);
	
		
	    
	    
	hex hex00(
		.SW(q[3:0]),
		.HEX0(HEX0)
	);
		
		
	hex hex01(
		.SW(q[7:4]),
		.HEX0(HEX1)
	);
	
	
endmodule
    
    
module hex0(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((~c2 & ~c0) | (c3 & ~c0) | (c1 & ~c0) | (c3 & ~c1) | (c2 & c1) | (~c3 & c1) | (~c3 & c2 & c0));
endmodule

module hex1(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((~c2 & ~c0) | (~c3 & ~c2) | (~c2 & ~c1) | (c3 & ~c1 & c0) | (~c3 & c1 & c0) | (~c3 & ~c1 & ~c0));
endmodule

module hex2(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((~c3 & ~c1) | (c3 & ~c2) | (~c3 & c2) | (~c1 & c0) | (~c2 & c0));
endmodule

module hex3(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((c3 & ~c1) | (c2 & c1 & ~c0) | (~c3 & ~c2 & ~c0) | (~c2 & c1 & c0) | (c2 & ~c1 & c0));
endmodule

module hex4(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((~c2 & ~c0) | (c3 & ~c2) | (c1 & ~c0) | (c3 & c1));
endmodule

module hex5(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((~c1 & ~c0) | (c3 & ~c2) | (c2 & ~c0) | (c3 & c1) | (~c3 & c2 & ~c1));
endmodule

module hex6(c3,c2,c1,c0,y);
	input c3,c2,c1,c0; output y;
	assign y = ~((c3 & ~c2) | (c1 & ~c0) | (c3 & c0) | (~c3 & c2 & ~c1) | (~c3 & ~c2 & c1));
endmodule

module hex(SW, HEX0);
	input [3:0] SW; output [0:6] HEX0;
	
	hex0 h0(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[0])
		);
		
	hex1 h1(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[1])
		);
		
	hex2 h2(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[2])
		);

	hex3 h3(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[3])
		);
		
	hex4 h4(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[4])
		);
		
	hex5 h5(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[5])
		);
		
	hex6 h6(
		.c3(SW[3]),
		.c2(SW[2]),
		.c1(SW[1]),
		.c0(SW[0]),
		.y(HEX0[6])
		);
endmodule
