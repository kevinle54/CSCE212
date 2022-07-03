.data
	a: .word 10 # $t0
	b: .word 20 # $t1
	c: .word 30 # $t3
	d: .word 10 # $t4
	f: .word 0
.text
	# Equation: F = (a + b) - (c + d) + (b + 3)
	
	# (a + b)
	lw $t0, a # stores a to $t0 address
	lw $t1, b # stores b to $t1 address
	add $t2, $t0, $t1 # $t2 is (a + b)
	
	# (c + d)
	lw $t3, c # stores c to $t3 address
	lw $t4, d # stores d to $t4 address
	add $t5, $t3, $t4 # $t5 is (c + d)
	
	# (b + 3)
	addi $t6, $t1, 3 # $t6 is (b + 3)
	
	# (a + b) - (c + d)
	sub $t7, $t2, $t5 # $t7 is (a + b) - (c + d)
	
	# $t7 - (b + 3)
	add $t8, $t7, $t6 # $t8 is $t7 - (b + 3)
	
	# Store $t8 with F variable
	sw $t8, f # f is $t8
	
	# Displays f
	li $v0, 1 # print integer
	lw $a0, f # load f to $a0 address
	syscall