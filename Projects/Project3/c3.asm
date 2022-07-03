.data
	promptA: .asciiz "For processor A...\n"
	promptB: .asciiz "For processor B...\n"
	
	promptIC: .asciiz "Enter in IC: "
	promptCPI: .asciiz "Enter in CPI: "
	promptCR: .asciiz "Enter in CR: "
	
	ATime: .asciiz "A is "
	BTime: .asciiz "B is "
	
	AFastPrompt: .asciiz " times as fast as B"
	BFastPrompt: .asciiz " times as fast as A"
.text
	main:
		# Note:
		# A's IC = $f1
		# A's CPI = $f2
		# A's CR = $f3
		
		# B's IC = $f4
		# B's CPI = $f5
		# B's CR = $f6
		
		# A's CPU time = $f7
		# B's CPU time = $f8
		
		# section for getting processor A info
		# jump to printString
		jal printString
		# load address with promptA
		la $a0, promptA
		syscall
		# jump to printString
		jal printString
		# load address with promptIC
		la $a0, promptIC
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f1
		movf.s $f1, $f0
		
		# jump to printString
		jal printString
		# load address with promptCPI
		la $a0, promptCPI
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f2
		movf.s $f2, $f0
		
		# jump to printString
		jal printString
		# load address with promptCR
		la $a0, promptCR
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f3
		movf.s $f3, $f0
		
		
		# section for getting processor B info
		# jump to printString
		jal printString
		# load address with promptB
		la $a0, promptB
		syscall
		# jump to printString
		jal printString
		# load address with promptIC
		la $a0, promptIC
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f4
		movf.s $f4, $f0
		
		# jump to printString
		jal printString
		# load address with promptCPI
		la $a0, promptCPI
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f5
		movf.s $f5, $f0
		
		# jump to printString
		jal printString
		# load address with promptCR
		la $a0, promptCR
		syscall
		# jump to reader
		jal reader
		# store float in $f0 to $f6
		movf.s $f6, $f0
		
		# jump to ACPU
		jal ACPU
		
		# jump to BCPU
		jal BCPU
		
		# jump to compare
		jal compare
		
		# jump to exit
		jal exit
		
	
	printString:
		# service code for printing string
		li $v0, 4
		
		# jump back to caller
		jr $ra
		
	reader:
		# service code for reading in floating point
		li $v0, 6
		syscall
		
		# jump back to caller (main)
		jr $ra
	
	#Formula: CPU Time = instruction count * CPI / clock rate
	# Note:
	# A's CPU time = $f7
	# B's CPU time = $f8
	
	# A's CPU time
	ACPU:
		# instruction count * CPI = $f7
		mul.s $f7, $f1, $f2
		# CPU
		div.s $f7, $f7, $f3
		
		# jump back to caller (main)
		jr $ra
		
	# B's CPU time
	BCPU:
		# instruction count * CPI = $f7
		mul.s $f8, $f4, $f5
		# CPU
		div.s $f8, $f8, $f6
		
		# jump back to caller (main)
		jr $ra
		
	# Comparsion of A's CPU time to B's CPU time
	compare:
		c.le.s $f7, $f8
		bc1t AFaster
		
		# B faster by...
		div.s $f8, $f7, $f8
		
		# jump to printString
		#jal printString
		li $v0, 4
		# load address $a0 with prompt BTime
		la $a0, BTime
		syscall
		
		li $v0, 2
		mov.s $f12, $f8
		syscall
		
		# jump to printString
		#jal printString
		li $v0, 4
		# load address $a0 with prompt BTime
		la $a0, BFastPrompt
		syscall
		
		j exit
		
	AFaster:
		# A faster by...
		div.s $f7, $f8, $f7
		
		# jump to printString
		#jal printString
		li $v0, 4
		# load address $a0 with prompt ATime
		la $a0, ATime
		syscall
		
		#jal display
		li $v0, 2
		mov.s $f12, $f7
		syscall
		
		# jump to printString
		#jal printString
		li $v0, 4
		# load address $a0 with prompt ATime
		la $a0, AFastPrompt
		syscall
		
	exit:
		# service code to exit program
		li $v0, 10
		syscall
