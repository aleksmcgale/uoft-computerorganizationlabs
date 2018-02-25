vlog -timescale 1ns/1ns lab5part2.v

# Load simulation using mux as the top level simulation module.
vsim sim

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# First test case
# Set input values using the force command, signal names need to be in {} brackets.
#enable
force {SW[2]} 1
#clock

force {CLOCK_50]} 0 0, 1 20 -r 40
#clear_b
force {SW[0]} 0 0, 1 80 -r 160

force {}


run 400ns