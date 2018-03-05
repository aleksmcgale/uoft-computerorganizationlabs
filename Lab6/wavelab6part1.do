vlib work

vlog -timescale 1ns/1ns lab6part1.v

vsim sequence_detector

log {/*}
add wave {/*}

#reset
force {SW[0]} 0
#input signal w
force {SW[1]} 0 0 ns, 1 10 ns -repeat 110
#clock
force {KEY[0]} 0 0 ns, 1 10ns, 0 10ns -repeat 110


run 120ns
