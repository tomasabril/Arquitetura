#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on


clear

tput setaf 3
echo "apagando arquivos antigos... "
tput sgr0

nome=pc
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=rom
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=maq_estado
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=ula1
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
rm *.cf
rm *.o



nome=pc	#####################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}

nome=rom		#####################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}

nome=maq_estado	#####################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}

nome=ula1	#####################
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


