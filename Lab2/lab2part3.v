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