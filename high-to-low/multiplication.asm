.data
.text

# Kör Multiplikation	
# li $v0, 5
# syscall
# la $s0, ($v0)
# li $v0, 5
# syscall
# la $s1, ($v0)
# jal multiply
# li $v0, 1
# la $a0, ($s3)
# syscall

# Kör Fakultet
# li $v0, 5
# syscall
# la $s2, ($v0)
# jal faculty
# li $v0, 1
# la $a0, ($s3)
# syscall
# j end

	

multiply: #$s0 och $s1 är argumenten. Returnerar $s3
li $t0, 0
li $t1, 0
loop1:
add $t0, $s0, $t0
addi $t1, $t1, 1
bne $t1, $s1, loop1

la $s3, ($t0) 
beqz $t9, loop2 #för fakultetsfunktionen

jr $ra

faculty: #$s2 är argumentet. Returnerar $s3
li $t9, 0
li $s3, 1
loop2:
la $s0, ($s3)
la $s1, ($s2)
addi $s2, $s2, -1
bgtz $s2, multiply

jr $ra

end:
li $v0, 10
syscall


