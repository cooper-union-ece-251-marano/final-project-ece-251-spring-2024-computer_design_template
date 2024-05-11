main:
    addi $at, $zero, 0       # Initialize $at (assembler temporary) to 0 (Fibonacci(0))
    addi $v0, $zero, 1       # Initialize $v0 (value for function result) to 1 (Fibonacci(1))
    addi $a0, $zero, 2       # Initialize $a0 (argument) to 2 (counter starts at 2)
    addi $a1, $zero, 9       # Initialize $a1 (argument) to 8 (target Fibonacci index)

loop:
    beq  $a0, $a1, finish    # If counter ($a0) equals 8, exit the loop
    add  $v1, $at, $v0       # $v1 (value for function result) = $at + $v0 (next Fibonacci number)
    add  $at, $zero, $v0     # $at = $v0 (update $at for the next iteration)
    add  $v0, $zero, $v1     # $v0 = $v1 (update $v0 for the next iteration)
    addi $a0, $a0, 1         # Increment counter ($a0)
    j    loop                # Repeat the loop

finish:
    sw   $v0, 0($zero)       # Store the 8th Fibonacci number in memory address 0
    lw   $at, 0($zero)       # Store the 8th Fibonacci number in memory address 0

end:
    j    end                 # Loop forever (end of program)

