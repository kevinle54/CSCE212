.data
	question: .ascii "Hello, may I have your name, please? \n"
	inputName: .space 100 # initialize max input limit
	response: .ascii "Welcome, "
.text
	# Displays question
	li $v0, 4 # prints string
	la $a0, question # load question to $a0
	syscall
	
	# Reads input from user
	li $v0, 8 # reads string
	la $a0, inputName # load inputName to $a0 address
	li $a1, 50 # specific input limit
	syscall
	
	# Displays response
	li $v0, 4 # prints string
	la $a0, response # load response to $a0 address
	syscall
	
	# Displays name
	li $v0, 4 # prints string
	la $a0, inputName # load input response to $a0 address
	syscall