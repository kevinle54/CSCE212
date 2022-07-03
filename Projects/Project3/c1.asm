.data
	promptA: .asciiz "Value for A: "
	promptB: .asciiz "Value for B: "
.text
	main:
		# section of printing prompts and readiing in user's inputs
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
		
		# section to multiply
		# jump to multiply
		jal multiply
		
		# Section to display result
		# jump to displayResult
		jal displayResult
	
	
	# Note:
	# A = $t0
	# B = $t1
	# temp = $t8
	# total = $t9
		
	multiply:
		# add 0 + a to $t8
		add $t8, $zero, $t0
		# add $t9 + $t8 to $t9
		add $t9, $t9, $t8
		# substract 1 from $t1
		subiu $t1, $t1, 1
		# if $t1 != 0, go to multiply
		bnez $t1, multiply
		
		# move results to $a0 for printing
		move $a0, $t9
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
		
	reader:
		# service code for reading in integer
		li $v0, 5
		syscall
		# jump back to caller (main)
		jr $ra
		
	displayResult:
		# service code for print intgeger
		li $v0, 1
		syscall
		li $v0, 10
		syscall
