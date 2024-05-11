#
# This program is machine encoded in program.dat
#
.org 0                      # Memory begins at location 0x00000000
Main:                                                      # MIPS machine code
    addi $t1, $zero, 10     # $v0 = 10                     ; 2002000a
    addi $t2, $zero, 15     # $v1 = 15                     ; 2003000f
    sub $s1, $t2, $t1       # $v0 = $v0 - $v1              ; 00431022
    sw $s1, 84($zero)       # store sum in mem[84] = -5    ; ac020054
    lw $s2, 84($zero)       # store sum in mem[84] = -5    ; ac020054
End:  .end                  # final sum in LSB of 4th word from top.
