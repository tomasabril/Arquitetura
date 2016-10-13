#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on

#arquivo a ser compilado e testado
nome=ula
#criar grafico com $tempo nano segundos
tempo=30000

echo "apagando arquivos antigos... "

rm ${nome}
rm ${nome}.o
rm ${nome}_tb
rm e~${nome}.o
rm ${nome}_tb.ghw
rm *.cf

echo "compilando... ${nome} "

ghdl -a ${nome}.vhdl
ghdl -e ${nome}

echo "gerando graficos... "

ghdl -a ${nome}_tb.vhdl
ghdl -e ${nome}_tb

ghdl -r ${nome}_tb --stop-time=${tempo}ns --wave=${nome}_tb.ghw

echo "terminado "

gtkwave ${nome}_tb.ghw

