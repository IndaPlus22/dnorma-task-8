.data
primes:		.space  1000         
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"
.text

main:
    li      $v0,5                  
    syscall                     

    # validate input
    slti    $t0,$v0,1001	
    beqz    $t0,invalid_input
    nop                 
    li      $t1, 1
    slt     $t0,$t1,$v0		     
    beqz    $t0,invalid_input 
    nop 
    
    # initialise primes array
    la	    $t0,primes              # $s1 = address of the first element in the array
    li 	    $t1,999
    li 	    $t2,0
    li	    $t3,1
    
init_loop:
    sb 	    $t3, ($t0)              # primes[i] = 1
    addi    $t0, $t0, 1             # increment pointer
    addi    $t2, $t2, 1             # increment counter
    bne	    $t2, $t1, init_loop     # loop if counter != 999
    

    la      $t0, primes             #reset pointer
    li      $t2, 2                  #reset counter
    li      $t3, 0                  #to be loaded in non-prime numbers

next_prime:
    lb     $t1, ($t0)              #check if prime
    beqz    $t1, skip              #skip if not prime
    nop
    jal     removal
    nop
    skip:
    addi    $t0, $t0, 1            #increment pointer
    addi    $t2, $t2, 1            #increment counter
    blt     $t2, $v0, next_prime
    nop
    
print:
    la      $s2, ($v0)
    la      $s0, primes    #pointer
    li      $v0,  1        #ready to print integer
    li      $s1,  2        #counter

    loop2:
    lb      $t1, ($s0)
    beqz    $t1, skip2     #skip if not prime
    nop
    la      $a0, ($s1)     #print current counter value
    syscall
    skip2:
    addi    $s1, $s1, 1        #increment counter
    addi    $s0, $s0, 1        #increment pointer
    blt     $s1, $s2, loop2
    nop
    
    j       exit_program
    nop
    
removal:      
    la     $t5, ($t2)    
    add    $t5, $t5, $t2           #counter starts at 2x
    la     $t4, ($t0)              
    add    $t4, $t4, $t2           #pointer starts at address + x
    loop1:
    	sb      $t3, ($t4)
    	add     $t4, $t2, $t4      #increment pointer by x
    	add     $t5, $t2, $t5      #increment counter by x
    	ble     $t5, $v0, loop1
    jr      $ra
    
invalid_input:
    # print error message
    li      $v0, 4                  # set system call code "print string"
    la      $a0, err_msg            # load address of string err_msg into the system call argument registry
    syscall                         # print the message to standard output stream

exit_program:
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # exit program
