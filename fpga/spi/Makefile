all:
	yosys -p "plugin -i systemverilog" -p "read_systemverilog top.sv spi_master.sv ../util/clock_divider.sv; synth_ecp5 -top top -json out.json"
	ecppack --compress --freq 38.8 --input out.config --bit out.bit
	nextpnr-ecp5 --json out.json --textcfg out.config --85k --package CSFBGA285 --lpf ../orangecrab_r0.2.pcf
	dfu-suffix -v 1209 -p 5af0 -a out.bit
dfu:
	dfu-util -a 0 -D out.bit
