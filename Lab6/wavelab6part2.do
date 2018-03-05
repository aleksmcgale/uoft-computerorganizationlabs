vlog -timescale 1ns/1ns lab6part1.v

vsim sequence_detector

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10, 0 90, 1 100

force {go} 0 0, 1 10 -r 20

# all value to 2, result should be 14
# A = 2, B = 2, C = 2, X = 2, result = 14 00001110
force {data_in[7:0]} 00000010 0, 00000010 20, 0000010 40, 00000010 60 

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10, 0 90, 1 100

force {go} 0 0, 1 10 -r 20

# A = 6, B = 10, C = 20, X = 2, result = 44 000101100
force {data_in[7:0]} 00000110 0, 00001010 20, 0010100 40, 00000010 60 


run 300ns
