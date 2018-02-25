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