main:
    addi $t1, $zero, 1       # Initialize $at (assembler temporary) to 0 (Fibonacci(0))
    addi $s1, $zero, 1       # Initialize $v0 (value for function result) to 1 (Fibonacci(1))
    addi $t2, $zero, 2       # Initialize $a0 (argument) to 2 (counter starts at 2)
    addi $t3, $zero, 9       # Initialize $a1 (argument) to 8 (target Fibonacci index)

loop:
    beq  $t2, $t3, finish    # If counter ($a0) equals 8, exit the loop
    add  $s2, $t1, $s1       # $v1 (value for function result) = $at + $v0 (next Fibonacci number)
    add  $t1, $zero, $s1     # $at = $v0 (update $at for the next iteration)
    add  $s1, $zero, $s2     # $v0 = $v1 (update $v0 for the next iteration)
    addi $t2, $t2, 1         # Increment counter ($a0)
    j    loop                # Repeat the loop

finish:
    sw   $s1, 0($zero)       # Store the 8th Fibonacci number in memory address 0
    lw   $t1, 0($zero)       # Store the 8th Fibonacci number in memory address 0

