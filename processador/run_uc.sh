#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on


clear

tput setaf 3
echo "apagando arquivos antigos... "
tput sgr0

nome=registrador17b
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=pc
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=rom
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=maq_estado2b
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=banco_reg17b
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=estado_pulo
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=ula
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=uc
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw
nome=ram
rm ${nome}
rm ${nome}_tb
rm ${nome}_tb.ghw

rm *.cf
rm *.o



nome=registrador17b		#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=pc				#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=rom			#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=maq_estado2b		#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=banco_reg17b		#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=estado_pulo		#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=ula			#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=ram			#########################
tput setaf 3
echo "compilando... ${nome} "
tput sgr0
ghdl -a ${nome}.vhdl
ghdl -e ${nome}
nome=uc				#########################
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

ghdl -r ${nome}_tb --stop-time=300000ns --wave=${nome}_tb.ghw

tput setaf 3
echo "terminado "
tput sgr0

gtkwave ${nome}_tb.ghw


