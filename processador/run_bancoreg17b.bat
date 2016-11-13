cls:
ghdl -a registrador17b.vhdl
ghdl -e registrador17b
ghdl -a banco_reg17b.vhdl
ghdl -e banco_reg17b
ghdl -a banco_reg17b_tb.vhdl
ghdl -e banco_reg17b_tb
ghdl -r banco_reg17b_tb --stop-time=400000ns --wave=banco_reg17b_tb.ghw
gtkwave banco_reg17b_tb.ghw
pause