GHDL_AFLAGS = --std=08
GHDL_EFLAGS = --std=08 -fexplicit -Wl,-no-pie

.PHONY: all clean test

all: test

clean:
	# ghdl --clean
	rm -f *.o *.cf *.vcd adder_tb

test: adder_tb
	ghdl -r adder_tb --vcd=adder.vcd

adder.o: adder.vhdl
	ghdl -a $(GHDL_AFLAGS) adder.vhdl

adder_tb.o: adder_tb.vhdl adder.o
	ghdl -a $(GHDL_AFLAGS) adder_tb.vhdl

adder_tb: adder_tb.o
	ghdl -e $(GHDL_EFLAGS) adder_tb
