#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on

clear

tput setaf 3
echo "apagando arquivos antigos... "
tput sgr0

rm registrador16b
rm registrador16b.o
rm registrador16b
rm e~registrador16b.o
rm registrador16b.ghw
rm banco_reg16b
rm banco_reg16b.o
rm banco_reg16b
rm e~banco_reg16b.o
rm banco_reg16b.ghw
rm *.cf

tput setaf 3
echo "compilando... ${nome} "
tput sgr0

ghdl -a registrador16b.vhdl
ghdl -e registrador16b
ghdl -a banco_reg16b.vhdl
ghdl -e banco_reg16b

tput setaf 3
echo "gerando graficos... "
tput sgr0

ghdl -a banco_reg16b_tb.vhdl
ghdl -e banco_reg16b_tb
ghdl -r banco_reg16b_tb --stop-time=30000ns --wave=banco_reg16b_tb.ghw

gtkwave banco_reg16b_tb.ghw


