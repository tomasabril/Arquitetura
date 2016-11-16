#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on

clear

tput setaf 3
echo "apagando arquivos antigos... "
tput sgr0

rm registrador17b
rm registrador17b.o
rm registrador17b
rm e~registrador17b.o
rm registrador17b.ghw
rm banco_reg17b
rm banco_reg17b.o
rm banco_reg17b
rm e~banco_reg17b.o
rm banco_reg17b.ghw
rm *.cf

tput setaf 3
echo "compilando... ${nome} "
tput sgr0

ghdl -a registrador17b.vhdl
ghdl -e registrador17b
ghdl -a banco_reg17b.vhdl
ghdl -e banco_reg17b

tput setaf 3
echo "gerando graficos... "
tput sgr0

ghdl -a banco_reg17b_tb.vhdl
ghdl -e banco_reg17b_tb
ghdl -r banco_reg17b_tb --stop-time=30000ns --wave=banco_reg17b_tb.ghw

gtkwave banco_reg17b_tb.ghw


