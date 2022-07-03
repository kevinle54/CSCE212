.data
	# prompts the user of the program's operation
	prompt: .asciiz "Enter in an integer and press enter key for a total of 3 times\nthe integers will then be compare to return the minimum integer.\n"
	
	minimumMessage: .asciiz "The minimum integer is: "
.text
	main:
		# Track Keeping
		# 0 ($t0)
		# a ($t1)
		# b ($t2)
		# c ($t3)
		
		# go to displayPrompt procedures (method)
		jal displayPrompt
		
		# go to readInput procedures (method)
		# then move the value from v0 address to an address (3x)
		jal readInput
		move $t1, $v0
		jal readInput
		move $t2, $v0
		jal readInput
		move $t3, $v0
		
		# go to initialCompareAB procedures (method)
		jal initialCompareAB
		
		# go to minimumValue procedures (method)
		jal minimumValue
		
		#service code for ending program
		li $v0, 10
		syscall
		
		
	# display the prompt
	displayPrompt:
		# service code for printing strings
		li $v0, 4
		# load address of $a0 with prompt's content
		la $a0, prompt
		syscall
		# jump back to location on main
		jr $ra
	
	# reads in the user's inputs	
	readInput:
		# service code for reading in user's input
		li $v0, 5
		syscall
		# jump back to location on main
		jr $ra
	
	# comparing A ($t1) and B ($t2)
	initialCompareAB:
		# if A ($t1) is equal to zero, then go to compareBC
		beq $t1, $t0, compareBC
		# if B ($t2) is equal to zero, then go to compareAC
		beq $t2, $t0, compareAC
		# if A ($t1) is less than B ($t2), then go compareAC
		blt $t1, $t2, compareAC
		#if not, jump to compareBC
		j compareBC
		
	# comparing A ($t1) and C ($t3)
	compareAC:
		# if A ($t1) is less than C ($t3), then go aLess
		blt $t1, $t3, aLess
		#if not, jump to cLess
		j cLess
	
	# comparing B ($t2) and C ($t3)
	compareBC:
		# if B ($t2) is less than C ($t3), then go bLess
		blt $t2, $t3, bLess
		#if not, jump to cLess
		j cLess
		
	# move a ($t1) to $t4 address
	aLess:
		move $t4, $t1
		# jump back to location on main
		jr $ra
		
	# move b ($t2) to $t4 address
	bLess:
		move $t4, $t2
		# jump back to location on main
		jr $ra
		
	# move c ($t3) to $t4 address
	cLess:
		move $t4, $t3
		# jump back to location on main
		jr $ra
		
	# move minimum value ($t4) to printing address ($a0)
	minimumValue:
		# service code for printing string
		li $v0, 4
		la $a0, minimumMessage
		syscall
		# service code for printing integer
		li $v0, 1
		move $a0, $t4
		syscall
