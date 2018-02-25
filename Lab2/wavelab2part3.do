vlib work

vlog - timesclae 1ns/1ns lab2part3.v

vsim decoder

log{/*}

add wave{/*}

#A
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 10 ns

#b
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 10 ns

#C
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10 ns

#2
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 10 ns

#5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 10 ns

#8
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10 ns