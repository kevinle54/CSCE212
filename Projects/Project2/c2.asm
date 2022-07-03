.data
	weightPrompt: .asciiz "\n\nEnter weight in pounds: "
	heightPrompt: .asciiz "Enter height in feet: "
	
	# formula: BMI = weight(lbs) / height(inches)^2 * 703
	# weight is $f1
	# height is $f2
	
	# feet to inches
	inches: .float 12.0 # $f3
	constant: .float 703.0 # $f4
	
	# BMI is $f5
	
	underweight: .float 18.5 # $f6
	overweight: .float 25.0 # $f7
	#normal is $f8
	
	BMIMessage: .asciiz "\nThe BMI is: "
	underMessage: .asciiz "\nBMI index is underweight."
	overMessage: .asciiz "\nBMI index is overweight."
	normalMessage: .asciiz "\nBMI index is normal."
	
	
.text 
	main:
		# go to the displayWeight procedure
		jal displayWeight
		# go to the displayHeight procedure
		jal displayHeight
		# go to the equation procedure
		jal equation
		# go to the indicator procedure
		jal indicator
		
		
	# displays prompt
	displayWeight:
		# service code for printing strings
		li $v0, 4
		# load address weightPrompt to the printing address ($a0)
		la $a0, weightPrompt
		syscall
		
		# section for assigning weight
		# service code for reading floats
		li $v0, 6
		syscall
		# moves $f0 content to $f1
		mov.s $f1, $f0
		# moves $f1 content to printing float address ($f12)
		# jump back to location on main
		jr $ra
	
	# displays prompt
	displayHeight:
		# service code for printing strings
		li $v0, 4
		# load address heightPrompt to the printing address ($a0)
		la $a0, heightPrompt
		syscall
		
		# section for assigning height
		# load single float inches (12.0) to $f3
		l.s $f3, inches
		# service code for reading floats
		li $v0, 6
		syscall
		# moves $f0 content to $f2
		mov.s $f2, $f0
		# multiply $f3 (12.0) with $f2 (height) to $f2 (height in inches)
		mul.s $f2, $f3, $f2
		# multiply $f2 (height in inches) to itself ($f2)
		# basically (height in inches)^2, and set it to $f2
		mul.s $f2, $f2, $f2
		# jump back to location on main
		jr $ra
		
	# equation handling
	equation:
		# load single float constant (703.0) to $f4
		l.s $f4, constant
		# divides $f1 (weight) and $f2 (height in inches)^2 to $f5
		div.s $f5, $f1, $f2
		# multiply the calculated $f5 from the previous code with the constant ($f4) to $f5 (BMI)
		mul.s $f5, $f5, $f4
		# service code for printing string
		li $v0, 4
		# print BMI message
		la $a0, BMIMessage
		syscall
		# service code for printing floats
		li $v0, 2
		# move single float from $f5 to printing float addess ($f12)
		movf.s $f12, $f5
		syscall
		# jump back to location on main
		jr $ra
		
	# compare BMI to BMI indices
	indicator:
		# load single float underweight (18.5) to $f6
		l.s $f6, underweight
		# load single float overweight (25.0) to $f7
		l.s $f7, overweight
		# if the BMI is less than 18.5 is true...
		c.lt.s $f5, $f6
		bc1t printUnder
		# or, if the BMI is less than 18.5 is false...
		c.le.s $f5, $f7
		bc1f printOver
		#else, go to printNormal
		j printNormal
	
	# print underweight message
	printUnder:
		# service code to print string
		li $v0, 4
		# print underMessage
		la $a0, underMessage
		syscall
		# jump to main
		j main
	
	# print overweight message
	printOver:
		# service code to print string
		li $v0, 4
		# print overMessage
		la $a0, overMessage
		syscall
		# jump to main
		j main
	
	# print overweight message
	printNormal:
		# service code to print string
		li $v0, 4
		# print normalMessage
		la $a0, normalMessage
		syscall
		# jump to main
		j main