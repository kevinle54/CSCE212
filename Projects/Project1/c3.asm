.data
	# i must be in $s0
	j: .word -1 # j must be in $s1
	k: .word -1 # k must be in $s2
	starts: .asciiz "Program starts \n"
	newLine: .asciiz "\n"
	ends: .asciiz  "Program ends \n"
.text
	# Program starts
	li $v0, 4 # prints string
	la $a0, starts # load starts to $a0 address
	syscall
	
	# initialize i to 0
	addi $s0, $zero, 0 # i = 0
	
	loop:
		bgt $s0, 4, exit # if i above 4, go to exit:
		# Equation: f = i + j - k
		
			# i + j
			lw $s1, j # load j to $s1 address
			add $s4, $s0, $s1 # $s4 is i + j
			
			# $s4 - k
			lw $s2, k # load k to $s2 address
			add $s5, $s4, $s2 # $s5 is $s4 - k
		
			# Displays f (output)
			li $v0 1 # prints integer
			add $a0, $zero, $s5 # adds 0 + $s5 to $a0 address
			syscall
		
			# print new line
			li $v0, 4 # prints string
			la $a0, newLine # load newLine to $a0 address
			syscall
		
			# increase i
			addi $s0, $s0, 1 # adds previous $s0 + 1 to i 
			j loop # jump to loop:
	exit:
		li $v0, 4 # prints string
		la $a0, ends # load ends o $a0 address
		syscall
