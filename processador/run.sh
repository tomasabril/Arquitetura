#!/bin/bash

#set -x #echo on


nome=ula

echo "compilando... ${nome} "

ghdl -a ${nome}.vhdl
ghdl -e ${nome}

echo "gerando graficos... "

ghdl -a ${nome}_tb.vhdl
ghdl -e ${nome}_tb

ghdl -r ${nome}_tb —stop-time=30000ns —wave=${nome}_tb.ghw

echo "terminado "

gtkwave porta_tb.ghw

