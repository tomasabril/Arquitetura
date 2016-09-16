## tomas abril
## laboratorio assembly 4

j exe2

exe1:	## primeiro exercicio ##############################################
main:
	jal lerval 
	move $a0, $v0
	jal celtofah
	move $a0,$v0
	
	li $v0,1		## print
	syscall 
	
	li $v0,10		## termina programa
	syscall 

lerval:				## ler variavel do teclado
	li $v0,5
	syscall
	jr $ra
	
celtofah:			# converte celcius para Fahrenheit
	mul $v0,$a0,9
	div $v0,$v0,5
	addi $v0,$v0,32
	jr $ra


exe2:	## segundo exercicio ##############################################
# uma função pode destruir os valores de $t's (temporários) e $a's (argumentos), mas não pode destruir nenhum outro, em especial os $s's (salvos).
#  y = 3x5 + 2x3 - 6x

	li $v0,5		## le do teclado
	syscall
	
	move $a0,$v0
	jal calcula
		
	li $v0,1		## print
	syscall 
	
	li $v0,10		## termina programa
	syscall 

calcula:
	mul $s0,$a0,-6
	addi $sp,$sp,-4		 # reserva espaço na pilha para um dado
 	sw $ra,0($sp) 		 # guarda o $ra original no topo da pilha
 	jal pow			 # isso vai destruir o valor original de $ra!


pow:

 	lw $ra,0($sp) 		# recupera valor original guardado na pilha
 	addi $sp,$sp,4 		# libera o espaço reservado para o $ra
 	jr $ra 










