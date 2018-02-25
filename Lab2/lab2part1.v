module mux2to1(x, y, s, m);
	input x; input y; input s; output m;
	assign m = s ? y : x;
endmodule

module mux4to1(u, v, w, x, s0, s1, m);
	input u; input v; input w; input x; input s0; input s1; output m;
	wire f, d;
	mux2to1 mux1(u, v, s0, f);
	mux2to1 mux2(w, x, s0, d);
	mux2to1 mux3(f, d, s1, m);
endmodule

module mux(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	
	mux4to1 u0(
			.u(SW[0]),
			.v(SW[1]),
			.w(SW[2]),
			.x(SW[3]),
			.s0(SW[8]),
			.s1(SW[9]),
			.m(LEDR[0])
			);
endmodule
