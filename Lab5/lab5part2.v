module sim(SW, CLOCK_50, HEX0);
    input [3:0] SW;
    input CLOCK_50;
    output [6:0] HEX0;
    wire [3:0] out;    
    
    counter c0(
        .reset_n(SW[3]),
        .par_load(SW[9]),
        .load(SW[7:4]), 
        .enable(SW[2]), 
        .freq(SW[1:0]), 
        .clock(CLOCK_50), 
        .q(out)
    );
        
    decoder d0(
        .out(out), 
        .HEX0(HEX0)
    );
    
endmodule
    
    
module counter(reset_n, par_load, load, enable, freq, clock, q);
    input reset_n, par_load, enable, clock;
    input [1:0] freq;
    input [3:0] load;
    output [3:0] q;
    
    wire [27:0] hz1, hz05, hz025; //due to log2(x)
    reg out;
    
    
    rate_divider r1(
        .enable(enable),
        .par_load({2'b00, 26'd49999999}), //hrtz
        .clock(clock), 
        .reset_n(reset_n), 
        .q(hz1)
    );
    
    rate_divider r05(
        .enable(enable),
        .par_load({1'b00, 27'd499999999}), 
        .clock(clock), 
        .reset_n(reset_n), 
        .q(hz05)
    );
    
    rate_divider r025(
        .enable(enable),
        .par_load(28'd499999999), 
        .clock(clock), 
        .reset_n(reset_n), 
        .q(hz025)
    );
    
    
    
    always @(*)
        begin
            case(freq)
                2'b00: out = enable;
                2'b01: out =(hz1 == 0) ? 1:0;
                2'b10: out =(hz05 == 0) ? 1:0;
                2'b11: out =(hz025 == 0) ? 1:0; //from lab notes
            endcase
        end
    
    display_counter d1(
        .enable(out), 
        .clock(clock), 
        .reset_n(reset_n),
        .par_load(par_load),
        .q(q)
        );
endmodule
        
module rate_divider(enable, load, clock, reset_n, q)
    input enable, clock, reset_n, load;
    output [27:0] q;
    
    reg [27:0] q; //28 d long
    
    always @(posedge clock ) 
    begin
        if (reset_n == 1’b0) 
            q <= 0;

        ￼￼else if (par_load == 1’b1) //from notes
￼           q <= load;
        else if (enable == 1’b1)
            begin
                if (q == 0)
                    q <= load;
                else
                q <= q - 1'b1; //need to subtract like the notes said?
            end 
    end
endmodule
    

module display_counter(enable, clock, par_load, load reset_n, q);
    input enable, clock, reset_n, par_load, load;
    output [3:0] load;
    reg [3:0] q;
    always @(posedge clock)
    begin
        if (reset_n == 1'b0)
            q <= 0;
        else if (par_load == 1'b1)
            q<=load;
        else if (enable == 1’b1)
            begin
                if (q == 4’b1111)
                    q <= 0;
                else //changed d in the notes to load
                q <= q + 1'b1;
            end 
    end
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
        .c2(x[1]),f
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