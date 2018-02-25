module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    mux4to1 u0(
        .u(SW[0]),
        .v(SW[1]),
        .w(SW[2]),
        .x(SW[3])
        .s0(SW[8]),
        .s1(SW[9]),
        .m(LEDR[0]),
        );
endmodule

module mux4to1(u, v, w, x, s0, s1, m);
    input u, v, w, x, s1, s2;
    output m;
    wire w0, w1;
    
    mux2to1 m0(
        .x(u),
        .y(v),
        .s(s0),
        .m(w0)
    );
    
    mux2to1 m1(
        .x(w),
        .y(x),
        .s(s0),
        .m(w1)
    );
    
    mux2to1 m2(
        .x(w0),
        .y(w1),
        .s(s1),
        .m(m)
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
