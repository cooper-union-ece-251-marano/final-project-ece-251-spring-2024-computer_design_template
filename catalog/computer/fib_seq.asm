addi $a0, $zero, 6 # 6th Fib number

fib:
    addi $sp, $sp, -12   # Allocate space on the stack for three items
    sw $ra, 0($sp)       # Save the return address
    sw $a0, 4($sp)       # Save the argument (current Fibonacci index)
    sw $s0, 8($sp)       # Save the temporary register $s0

    slti $t0, $a0, 2     # Set $t0 to 1 if $a0 is less than 2, else set to 0
    bne $t0, $0, ReturnOne  # If $a0 is less than 2, process ReturnOne

    addi $a0, $a0, -1    # Decrement $a0 for the recursive call fib(n-1)
    jal fib              # Call fib recursively
    add $s0, $v0, $0     # Store the result of fib(n-1) in $s0

    lw $a0, 4($sp)       # Load the original $a0 from the stack
    addi $a0, $a0, -2    # Prepare $a0 for the next recursive call fib(n-2)
    jal fib              # Call fib recursively
    add $v0, $v0, $s0    # Sum the results of fib(n-1) and fib(n-2) to get fib(n)

    lw $ra, 0($sp)       # Restore the return address
    lw $a0, 4($sp)       # Restore the original $a0
    lw $s0, 8($sp)       # Restore the original $s0
    addi $sp, $sp, 12    # Deallocate the stack space
    jr $ra               # Return to caller

ReturnOne:
    lw $ra, 0($sp)       # Restore the return address
    lw $a0, 4($sp)       # Restore the original $a0
    lw $s0, 8($sp)       # Restore the original $s0
    addi $sp, $sp, 12    # Deallocate the stack space
    addi $v0, $0, 1      # Set return value to 1 for base cases 0 and 1
    jr $ra               # Return to caller

ReturnZero:
    lw $ra, 0($sp)       # Restore the return address
    lw $a0, 4($sp)       # Restore the original $a0
    lw $s0, 8($sp)       # Restore the original $s0
    addi $sp, $sp, 12    # Deallocate the stack space
    addi $v0, $0, 0      # Set return value to 0 for base case 0
    jr $ra               # Return to caller
