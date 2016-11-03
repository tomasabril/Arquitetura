#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on

#arquivo a ser compilado e testado
nome=ula
#ula


#criar grafico com $tempo nano segundos
tempo=30000

#deixa echo colorido
tput setaf 3

clear
echo "apagando arquivos antigos... "
tput sgr0

rm ${nome}
rm ${nome}.o
rm ${nome}_tb
rm e~${nome}.o
rm ${nome}_tb.ghw
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

ghdl -r ${nome}_tb --stop-time=${tempo}ns --wave=${nome}_tb.ghw

tput setaf 3
echo "terminado "
tput sgr0

gtkwave ${nome}_tb.ghw

