#!/bin/bash

#faz os comandos que estao sendo executados aparecerem
#set -x #echo on


clear

a=0
until [ ! $a -lt 2 ]
do

	#arquivo a ser compilado e testado
	
	if [ "$a" == 0 ]; then
		nome=registrador16b
	else
		nome=banco_reg16b
	fi
	
	#ula
	#registrador16b

	#criar grafico com $tempo nano segundos
	tempo=30000

	#deixa echo colorido
	tput setaf 3

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

	a=`expr $a + 1`
done

gtkwave ${nome}_tb.ghw


