.data
choice_msg: .asciiz "Choose either multiply or factorial. Type [1] or [0]"
inv_input: .asciiz "Invalid input. Bye"
multi_msg: .asciiz "Multiplying 2 integers"
fact_msg: .asciiz "Factorializing(?) an integer"
.text
.spac
main:
	li $v0, 4
	la $a0, choice_msg
	syscall

	li $v0, 5
	syscall
	beq $v0, 1, multiply
	nop
	beq $v0, 0, factorial
	nop
	
	li $v0, 4
	la $a0, inv_input
	syscall

exit:
	li $v0, 10
	syscall
		
multiply:
	li $v0, 4
	la $a0, multi_msg
	syscall
	
	li $v0, 5  #Load first integer
	syscall
	la $a0, ($v0)
	
	li $v0, 5 #Load second integer
	syscall
	la $a1, ($v0)
	
	jal multiply_func
	
	la $a0, ($v0)
	li $v0, 1
	syscall
	
	j exit
	
factorial:
	li $v0, 4
	la $a0, fact_msg
	syscall
	
	li $v0, 5
	syscall
	la $a0, ($v0)
	
	jal factorial_func
	
	la $a0, ($v0)
	li $v0, 1
	syscall
	
	j exit
	
multiply_func:
	li $t0, 0
	la $t1, ($a0)
	la $t2, ($a1)
	
	loop1:
		add $t0, $t1, $t0
		addi $t2, $t2, -1
		bgtz $t2, loop1
		
	la $v0, ($t0)
	jr $ra

factorial_func:
	la $t3, ($a0)
	la $t4, ($ra) #Save return address
	
	loop2:
	la $a0, ($v0) 
	addi $t3, $t3, -1
	la $a1, ($t3)
	jal multiply_func
	bgtz $t3, loop2
	 
	jr $t4