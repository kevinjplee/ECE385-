transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Github/ECE385-Final/modules {D:/Github/ECE385-Final/modules/Land.sv}
vlib final_soc
vmap final_soc final_soc

vlog -sv -work work +incdir+D:/Github/ECE385-Final/modules {D:/Github/ECE385-Final/modules/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L final_soc -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
