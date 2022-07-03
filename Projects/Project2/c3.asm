.data
	numOfHw1: .asciiz "Number of homework: "
	AverHw2: .asciiz "Average time to complete each homework (in hours): "
	numOfExe3: .asciiz "Number of exercise: "
	AverExe4: .asciiz "Average time to complete each exercise (in hours): "
	totalPrompt: .asciiz "The total time is "
	
	# Keep Track
	# number of homework	($t1)
	# aver. homework	($t2)
	# num. of exercises	($t3)
	# aver. execerises	($t4)
	# temporary storage	($t7)
	# total time		($t9)
.text
	main:
		# jump at printPrompt1
		jal printPrompt1
		# jump at readInput
		jal readInput
		# move the user's inputted content to $t1
		move $t1, $v0
		# jump at printPrompt2
		jal printPrompt2
		jal readInput
		move $t2, $v0
		# jump at printPrompt3
		jal printPrompt3
		jal readInput
		move $t3, $v0
		# jump at printPrompt4
		jal printPrompt4
		jal readInput
		move $t4, $v0
		
		# jump at total
		jal total	# returns $v0
		
		# printing total time
		# moves the content from the return address ($v0) to $t9
		move $t9, $v0
		# service code to print string
		li $v0, 4
		# load address $a0 with totalPrompt
		la $a0, totalPrompt
		syscall
		# adds $t9 with 0 to printing address ($a0)
		add $a0, $t9, $zero
		# service code for printing integers
		li $v0, 1
		# print
		syscall
		
		# end program
		li $v0, 10
		syscall
		
	# printPrompt1-4 prints their corresponding messages
	printPrompt1:
		# service code for printing string
		li $v0, 4
		# load address $a0 with numOfHw
		la $a0, numOfHw1
		syscall
		# jump back to main
		jr $ra
	
	printPrompt2:
		# service code for printing string
		li $v0, 4
		# load address $a0 with AverHw2
		la $a0, AverHw2
		syscall
		# jump back to main
		jr $ra
		
	printPrompt3:
		# service code for printing string
		li $v0, 4
		# load address $a0 with nnumOfExe3
		la $a0, numOfExe3
		syscall
		# jump back to main
		jr $ra
		
	printPrompt4:
		# service code for printing string
		li $v0, 4
		# load address $a0 with AverExe4
		la $a0, AverExe4
		syscall
		# jump back to main
		jr $ra
		
	# reads in the user's input
	readInput:
		li $v0, 5
		syscall
		# jump back to main
		jr $ra
		
	# adds up aver. hw time and num. of hw
	addHw:
		# multiply $t1 and $t2 content
		mul $v0, $t1, $t2
		# jumps to the caller (total)
		jr $ra
	
	# adds up aver. exercise time and num. of exercise
	addExercise:
		# multiply $t3 and $t4 content
		mul $v0, $t3, $t4
		# jumps to the caller (total)
		jr $ra
	
	# total work hours
	total:
		# allocate (make) space on the stack
		addi $sp, $sp, -4
		# preserve the return address
		sw $ra, 0($sp)
		
		jal addHw	# $v0 return
		
		add $t7, $v0, $zero	# stores $v0 content from addHw to $t7
		
		jal addExercise		# $v0 return
		
		add $v0, $t7, $v0	# adds the $t7 and $v0 from addExercise to $v0 (overriding it with the new content)
		
		# load back the return address from this procedure
		lw $ra, 0($sp)
		# restore the spaces back on to the stack
		addi $sp, $sp, 4
		# jump to caller (main) and return $v0
		jr $ra