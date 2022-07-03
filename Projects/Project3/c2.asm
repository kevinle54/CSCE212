.data
	promptA: .asciiz "Value for A: "
	promptB: .asciiz "Value for B: "
	promptC: .asciiz "Value for C: "
	
	overflow: .asciiz "\nOverflow"
	noOverflow: .asciiz "\nNo overflow"
.text
	main:
		# jump to promptADisplay
		jal promptADisplay
		# jump to reader
		jal reader
		# store input for A in $t0
		move $t0, $v0
		# jump to promptBDisplay
		jal promptBDisplay
		# jump to reader
		jal reader
		# store input for B in $t1
		move $t1, $v0
		# jump to promptCDisplay
		jal promptCDisplay
		# jump to reader
		jal reader
		# store input for C in $t1
		move $t2, $v0
		# 0 + c to $t8
		add $t8, $zero, $t2
		# important for partOne
		# makes it so $v0 is 1
		li $v0, 1
		# jump to partOne
		jal partOne
		# jump to partTwo
		jal partTwo
		# jump to partThree
		jal partThree
		# jump to result
		jal result
		# store $t9 to $a0
		move $a0, $t9
		# jump to displayResult
		jal displayResult
		
		# jumps to checker
		jal checker
		
		
		
	
	# Note:
	# Equation: F = ((a + b^c) / (c - a^2)) + (3 * b)
	# a = $t0
	# b = $t1
	# c = $t2
	# temp = $t6
	# temp = $t7
	# temp = $t8
	# temp = $t9
	
	# (a + b^c)
	partOne:
		# 1 ($v0) * b to $v0
		mul $v0, $v0, $t1
		# store $v0 to $t9
		move $t9, $v0
		# decrease $t8 by 1
		addiu $t8, $t8, -1
		# if $t8 != 0, go to partOne
		bnez $t8, partOne
		
		# a + b^c ($t9 for now) to $t9
		add $t9, $t0, $t9
		# jump back to caller (main)
		jr $ra
	
	# temp = $t7
	# (c - a^2)
	partTwo:
		# a^2
		mul $t8, $t0, $t0
		# c - $t8 (a^2) to $t7
		sub $t7, $t2, $t8
		
		# jump back to caller (main)
		jr $ra
		
	# ((a + b^c) / (c - a^2))
	partThree:
		# $t9 (a + b^c) / $t7 (c - a^2) to $t9
		div $t9, $t9, $t7
		
		# jump back to caller (main)
		jr $ra
		
	# ((a + b^c) / (c - a^2)) + (3 * b)
	result:
		# $1 * 3 to $t7
		mul $t7, $t1, 3
		# $t9 (a + b^c) / (c - a^2) + $t7 (3 * b)
		addu $t9, $t9, $t7
		
		# jump back to caller (main)
		jr $ra
		
	promptADisplay:
		# prompt the user to enter in a value for A
		li $v0, 4
		la $a0, promptA
		syscall
		# jump back to caller (main)
		jr $ra
		
	promptBDisplay:
		# prompt the user to enter in a value for B
		li $v0, 4
		la $a0, promptB
		syscall
		# jump back to caller (main)
		jr $ra
		
	promptCDisplay:
		# prompt the user to enter in a value for C
		li $v0, 4
		la $a0, promptC
		syscall
		# jump back to caller (main)
		jr $ra
		
	reader:
		# service code for reading in integer
		li $v0, 5
		syscall
		# jump back to caller (main)
		jr $ra
		
	displayResult:
		# service code for print integer
		li $v0, 1
		syscall
		jr $ra
	
	checker:
		xor $t5, $t1, $t2
		xor $t5, $t5, $t0
		slt $t5, $t5, $zero
		bne $t5, $zero, no
	
		xor $t5, $t9, $t0
		slt $t5, $t5, $zero
		bne $t5, $zero, yes
	
		jr $ra
	
	no:
		# prompt noOverflow
		li $v0, 4
		la $a0, noOverflow
		syscall
		# jump to exit
		J exit
	
	yes: 
		# prompt overflow
		li $v0, 4
		la $a0, overflow
		syscall
		# jump to exit
		j exit
	
	exit:
		li, $v0, 10
		syscall
