cls:
cd Desktop
cd ULA
ghdl -a ula.vhdl
ghdl -e ula
ghdl -a ula_tb.vhdl
ghdl -e ula_tb
ghdl -r ula_tb —stop-time=80000ns —wave=ula_tb.ghw 
gtkwave ula_tb.ghw
pause