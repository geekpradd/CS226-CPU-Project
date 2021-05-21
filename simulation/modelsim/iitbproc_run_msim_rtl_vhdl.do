transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/226/alu/testbench.vhd}
vcom -93 -work work {E:/226/Controller.vhd}
vcom -93 -work work {E:/226/alu/two_nand.vhd}
vcom -93 -work work {E:/226/alu/Sub16bit.vhd}
vcom -93 -work work {E:/226/alu/nand16.vhd}
vcom -93 -work work {E:/226/alu/four_or.vhd}
vcom -93 -work work {E:/226/alu/ALU.vhd}
vcom -93 -work work {E:/226/alu/Adder16bit.vhd}
vcom -93 -work work {E:/226/RAM.vhd}
vcom -93 -work work {E:/226/register_file.vhd}
vcom -93 -work work {E:/226/register_16bit.vhd}
vcom -93 -work work {E:/226/register_1bit.vhd}
vcom -93 -work work {E:/226/iitbproc_tb.vhd}
vcom -93 -work work {E:/226/alu/KS16bit.vhd}
vcom -93 -work work {E:/226/iitbproc.vhd}

vcom -93 -work work {E:/226/iitbproc_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  cputest

add wave *
view structure
view signals
run -all
