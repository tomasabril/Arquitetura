# exercicio 1
########### valores a comparar ###########
addi $s1,$zero,1
addi $s2,$zero,33
###########

beq $s1,$zero,pos1
bgtz $s1,pos1

bltz  $s1,pos2

pos1:
	bgt $s2,32,pos11
	beq $s2,32,pos12
	blt $s2,32,pos13
	pos11:
		addi $s3,$zero,1
		beqz $zero,fim1
	pos12:
		addi $s3,$zero,2
		beqz $zero,fim1
	pos13:
		addi $s3,$zero,3
		beqz $zero,fim1
pos2:
	bgt $s2,32,pos21
	beq $s2,32,pos22
	blt $s2,32,pos23
	
	pos21:
		addi $s3,$zero,4
		beqz $zero,fim1
	pos22:
		addi $s3,$zero,5
		beqz $zero,fim1
	pos23:
		addi $s3,$zero,6
		beqz $zero,fim1
fim1:


# exercicio 2
###########  ###########
add $t3,$0,$s7
# 000000 00000 10111 01011 00000 100000
# 00175820

addi $s1,$s1,1
# 001000 10001 10001 0000000000000001
# 22310001

sub $t6,$t5,$t4
# 000000 01101 01100 01110 00000 100010
# 01AC7022

#### ####
# 0x02564020
# 0000 0010 0101 0110 0100 0000 0010 0000
# 000000 10010 10110 01000 00000 100000
add $t0,$s2,$s6

# 0x20C70057
# 0010 0000 1100 0111 0000 0000 0101 0111
# 001000 00110 00111 0000000001010111
addi $a3,$a2,87

# 0x36700010
# 0011 0110 0111 0000 0000 0000 0001 0000












