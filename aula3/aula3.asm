#j exer7

############## exercicio a ############
.data 
buffer: .space 200
frase: .asciiz " "

.text
la $t0,buffer
li $s0,20

loop1:
li $v0,5
syscall
# $v0 tem 32 bits
sw $v0,0($t0)
addi $t0,$t0,4
addi $s0,$s0,-1
bgtz $s0,loop1

li $s0,20
loop11:
addi $t0,$t0,-4
lw $a0,0($t0)
li $v0,1	#print $a0
syscall
addi $s0,$s0,-1

la $a0,frase
li $v0,4
syscall

bgtz $s0,loop11

############## exercicio b ############
exerb:

addi $s1,$zero,33
bne $s1,$zero,pulei
nop
nop
pulei: addi $s1,$s1,1

############## exercicio c ############
exerc:

start:	j final
	beq $zero,$zero,final
	la $t6,final
	jr $t6
final:	bne $0,$0,final


# exercicio 1 #
# 0000 0000 0000 0000 0000 0000
# os 4 primeiros bit sao copiados do pc atual
# isto significa que a distancia maxima pulada é
#      1111 1111 1111 1111 1111
# FFFFF enderecos
# ou 262143 instrucoes


### exe 3 #
# vantagens: o programador precisa de menos instrucoes para fazer a acao desejada, mais flexibilidade
# desvantagens: instrucoes complicadas aumentam a complexidade dos circuitos ndo computador

### exe 4 #
# houve estouro, os numeros originais tem 8 bits e o resultado 9

### exe 5
#1000 000 000 000 000
# numeros positivos podem ter até 15 bits, esse tem 16. portanto o montador 
# precisa dividir essa instrucao em outras para efetuar essa operacao

### exe 6 #
# endereco pc's
# 0x00400000
# 0x00400004
# 0x00400008
# 0x0040000C


## exe 7 ###
exer7:

# calcula fatorial de x
# resultado nao estourou
# multiplica por x+1

li $t0,$zero	# x fatorial atual
li $t1,$zero	# resultado do fatorial atual
li $t2,$zero
li $t3,$zero
li $t4,$zero
li $t5,$zero





















