transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/Courses/CS226-CPU-Project/Controller.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/two_nand.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/Sub16bit.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/nand16.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/four_or.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/ALU.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/Adder16bit.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/RAM.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/register_file.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/register_16bit.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/register_1bit.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/iitbproc_tb.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/iitbproc.vhd}
vcom -93 -work work {D:/Courses/CS226-CPU-Project/alu/KS16bit.vhd}

vcom -93 -work work {D:/Courses/CS226-CPU-Project/iitbproc_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  cputest

add wave *
view structure
view signals
run -all
