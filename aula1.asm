##########
addi $s0,$zero,123
addi $s1,$zero,456
addi $s2,$zero,789

###########
add $s3,$s0,$s1
add $s3,$s3,$s2

##########
addi $s4,$zero,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234
add $s4,$s4,1234

#######
addi $s5,$zero,23
addi $s6,$zero,29
loop1:
	addi $s5,$s5,23
	addi $s6,$s6,-1
	bne $s6,$zero,loop1

#########
addi $s0,$zero,40	#contador
addi $s1,$zero,0	#soma total
addi $s2,$zero,1	#valor temporario
loop2:
	addi $s0,$s0,-1
	add $s1,$s1,$s2
	addi $s2,$s2,2
	bne $s0,$zero,loop2


#zerando os registradores
addi $s0,$zero,0	# i
addi $s1,$zero,0	# 
addi $s2,$zero,0
addi $s3,$zero,0	# resultado
addi $s4,$zero,0	# temporario da multiplicacao
addi $s5,$zero,0	# resultado da multiplicacao
addi $s6,$zero,0
### somatorio

addi $s0,$zero,0	# i

loop3:
addi $s0,$s0,1
add $s4,$zero,$s0

	loopmult:
	add $s5,$s5,$s0
	addi $s4,$s4,-1
	bne $s4,$zero,loopmult
add $s3,$s3,$s5
bne $s0,20,loop3


#zerando os registradores
addi $s0,$zero,8	# valor a ser fatorado
addi $s1,$zero,0	# multiplicacao atual
addi $s2,$zero,0	# temp da multiplicacao
addi $s3,$zero,0	# contador da multiplicacao
addi $s4,$zero,0	# resultado final
addi $s5,$zero,0	# resultado anterior
addi $s6,$zero,1	# 1
### fatorial

add $s1,$zero,$s0
add $s5,$zero,$s1
loopfat:
	addi $s3,$s1,-1
	addi $s2,$zero,0
		loopmult2:
		add $s2,$s2,$s5
		addi $s3,$s3,-1
		bne $s3,$zero,loopmult2
	addi $s1,$s1,-1
	add $s4,$s4,$s2
	add $s5,$zero,$s2
	bne $s1,$s6,loopfat


















