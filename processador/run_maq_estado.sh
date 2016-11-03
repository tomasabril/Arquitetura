#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on

nome=maq_estado

clear

tput setaf 3
echo "apagando arquivos antigos... "
tput sgr0

rm ${nome}
rm ${nome}.o
rm ${nome}_tb
rm e~${nome}.o
rm ${nome}_tb.ghw
rm *.cf

rm *.cf

tput setaf 3
echo "compilando... ${nome} "
tput sgr0

ghdl -a ${nome}.vhdl
ghdl -e ${nome}

tput setaf 3
echo "gerando graficos... "
tput sgr0

ghdl -a ${nome}_tb.vhdl
ghdl -e ${nome}_tb

ghdl -r ${nome}_tb --stop-time=30000ns --wave=${nome}_tb.ghw

tput setaf 3
echo "terminado "
tput sgr0

gtkwave ${nome}_tb.ghw


