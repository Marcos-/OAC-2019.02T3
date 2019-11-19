if {[file isdirectory work]} { vdel -all -lib work } 
vlib work
vcom -2008 *.vhd
vsim tb
do wave.do 
run 50 ns 

