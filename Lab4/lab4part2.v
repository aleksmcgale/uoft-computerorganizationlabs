module alu2(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [9:0] SW;
    input KEY;
    output [7:0] LEDR;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
    reg [7:0] ALUout, regout;
	
    wire [9:0] w1, w2;
    
    alf a0(
	.A(SW[3:0]),
	.B(regout[3:0]),
	.f(SW[7:5]),
	.ALUout(ALUout[7:0])
    );
	
    assign LEDR[7:0] = ALUout[7:0];
    
	
    dflip_flop d0(
	.d(ALUout[7:0]), 
	.q(regout[7:0]), 
	.reset_n(SW[9]), 
	.clock(KEY)
    );
    
    
    
    hex hex00(
	.SW(regout[3:0]),
	.HEX0(HEX0[6:0])
    );
	
    hex hex01(
	.SW(4'b0000),
	.HEX0(HEX1[6:0])
    );
	
    hex hex02(
	.SW(4'b0000),	
	.HEX0(HEX2[6:0])
    );
	
    hex hex03(
	.SW(4'b0000),
	.HEX0(HEX3[6:0])
    );
	
    hex hex04(
	.SW(regout[3:0]),
	.HEX0(HEX4[6:0])
    );
	
    hex hex05(
	.SW(regout[7:4]),
	.HEX0(HEX5[6:0])
    );
    
    
endmodule

module aluf(A, B, f, ALUout);
    input [3:0] A;
    input [3:0] B;
    input [2:0] f;
    output [7:0] ALUout;
    
    wire [4:0] w0;
    wire [4:0] w1;
    
    reg [7:0] ALUout;
    
    ripple_carry_adder r0(
	.sum(A[3:0]), 
	.cout(w0[4]), 
	.a(A[3:0]), 
	.b(4'b0001), 
	.cin(1'b0)
    );
    
    ripple_carry_adder r1(
	.sum(w1[3:0]), 
	.cout(w1[4]), 
	.a(A[3:0]), 
	.b(B[3:0]), 
	.cin(1'b0)
    );
    
    always @(*)
    begin
        case (ALU_function)
            0: ALUout = {3'b000, w0[4:0]};
            1: ALUout = {3'b000, w1[4:0]};
            2: ALUout = 8'b00000000 + A + B;
            3: ALUout = {A | B, A ^ B}; 
            4: ALUout = 8'b00000000 + A | B;
            5: ALUout = B << A;
	    6: ALUout = B >> A;
	    7: ALUout = A * B;
            default: 8'b00000000;
        endcase
    end

module dflip_flop(d, q, reset_n, clock);

    input [7:0] d;
    input reset_n;
    input clock;
    output q;
    
    reg[7:0] q;
    
    
    always @(posedge clock) 
    begin
	if (reset_n == 1'b0)
	    q <= 0;
	else
	    q <= d;
    end
endmodule
    

module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [9:0] SW;
    input [2:0] KEY;
    output [7:0] LEDR;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
    reg [7:0] ALUout;
	
    wire [9:0] w1, w2;
	
    assign LEDR[7:0] = ALUout[7:0];
	
    sim s0(
	.SW({2'b01, SW[7:4]}),		
	.LEDR(w1[9:0])
    );
	
    sim s1(
	.SW({SW[7:4], SW[3:0]}),
	.LEDR(w2[9:0])
    );
	
    
    assign ALUout[7:0] = LEDR[7:0]
    
    hex hex00(
	.SW(SW[3:0]),
	.HEX0(HEX0[6:0])
    );
	
    hex hex01(
	.SW(4'b0000),
	.HEX0(HEX1[6:0])
    );
	
    hex hex02(
	.SW(SW[7:4]),	
	.HEX0(HEX2[6:0])
    );
	
    hex hex03(
	.SW(4'b0000),
	.HEX0(HEX3[6:0])
    );
	
    hex hex04(
	.SW(ALUout[3:0]),
	.HEX0(HEX4[6:0])
    );
	
    hex hex05(
	.SW(ALUout[7:4]),
	.HEX0(HEX5[6:0])
    );
    
    reg [7:0] ALUout;
	
    
    always @(*)
    begin
        case (KEY[2:0])
            0: ALUout = w1[9:0];
            1: ALUout =w2[9:0];
            2: ALUout = 8'b00000000 + SW[7:4] + SW[3:0];
            3: ALUout = {(SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0])}; 
            4: ALUout = 8'b00000000 + (SW[7:4] | SW[3:0]);
            5: ALUout = {SW[7:4], SW[3:0]};
            default: 8'b00000000;
        endcase
    end
endmodule


module sim(SW, LEDR);
    input [8:0] SW;
    output [4:0] LEDR;
    
    ripple_carry_adder rca(
        .sum(LEDR[3:0]),
        .cout(LEDR[4]),
        .a(SW[7:4],
        .b(SW[3:0]),
        .cin(SW[8])
    );
endmodule

module ripple_carry_adder(sum, cout, a, b, cin);
    input [3:0] a; 
    input [3:0] b; 
    input cin;
    output [3:0] sum;
    output cout;
    
    wire c0, c1, c2;
    
    full_adder f0(
        .sum(sum[0]),
        .cout(c0),
        .a(a[0]),
        .b(b[0]),
        .cin(cin)
    );
    
    full_adder f1(
        .sum(sum[1]),
        .cout(c1),
        .a(a[1]),
        .b(b[1]),
        .cin(c0)
    );
    
    full_adder f2(
        .sum(sum[2]),
        .cout(c2),
        .a(a[2]),
        .b(b[2]),
        .cin(c1)
    );
    
    full_adder f3(
        .sum(sum[3]),
        .cout(cout),
        .a(a[3]),
        .b(b[3]),
        .cin(c2)
    );
endmodule



module full_adder(sum, cout, a, b, cin);
    output sum, cout;
    input a, b, cin;
    
    assign sum = a^b^cin;
    assign cout = (a&b)|(cin&(a^b));
endmodule

module decoder(SW, HEX0);
    input [3:0] SW;
    output [6:0] HEX0;
    
    seven_seg_decoder ssd0(
        .x(SW),
        .y(HEX0)
    );
endmodule

module seven_seg_decoder(x, y);
    input [3:0] x;
    output [6:0] y;
    
    hex0 h0(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[0])
    );
    
    hex1 h1(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[1])
    );
    
    hex2 h2(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[2])
    );
    
    hex3 h3(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[3])
    );
    
    hex4 h4(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[4])
    );
    
    hex0 h5(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[5])
    );
    
    hex6 h6(
        .c3(x[3]),
        .c2(x[1]),
        .c1(x[1]),
        .c0(x[0]),
        .m(y[6])
    );
endmodule
    


module hex0(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(c1&~c0)|(~c1&c3&~c2)|(~c0&~c3&~c2)|(c0&~c3&c2)|(c1&~c3&~c2)|(c1&c2)
    
end module

module hex1(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(~c3&~c2)|(~c1&~c0&~c3)|(c0&~c3&c1)|(~c0&c3&~c2)|(~c1&c0&c3)
    
end module

module hex2(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(c3&~c2)|(c1&~c0)|(~c3&c2)|(~c1&~c3&~c0)|(c1&~c3&c0)
    
end module

module hex3(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(c0&c3&~c2)|(~c1&c2)|(~c0&~c3&~c2)|(c1&~c3&~c2)|(c2&c1&~c0)
    
end module

module hex4(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(c3&c2)|(c1&~c0)|(~c1&~c2&~c0)|(c1&c3&c0)
    
end module

module hex5(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m = (~c1&~c0)|(c3&~c2)|(~c3&c2&~c1)|(c1&c3)|(c1&~c0&c2)
    
end module

module hex5(c3, c2, c1, c0, m);
    input c3, c2, c1, c0;
    output m;
    
    assign m =(c3&~c2)|(c1&~c0)|(~c3&c2&~c1)|(c3&c2&c0)|(~c3&~c2&c1)
    
end module
