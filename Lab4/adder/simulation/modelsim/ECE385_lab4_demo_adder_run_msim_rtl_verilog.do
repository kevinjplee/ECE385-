transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Quartus/Lab/Lab4/adders {D:/Quartus/Lab/Lab4/adders/ripple_adder.sv}
vlog -sv -work work +incdir+D:/Quartus/Lab/Lab4/adders {D:/Quartus/Lab/Lab4/adders/HexDriver.sv}
vlog -sv -work work +incdir+D:/Quartus/Lab/Lab4/adders {D:/Quartus/Lab/Lab4/adders/lab4_adders_toplevel.sv}

vlog -sv -work work +incdir+D:/Quartus/Lab/Lab4/adder/../adders {D:/Quartus/Lab/Lab4/adder/../adders/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
