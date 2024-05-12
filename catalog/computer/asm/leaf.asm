addi $t1, $zero, 5  #t1 = 5
addi $t2, $zero, 9  #t2 = 9
sw $t1, 80($zero)   #store t1 into memory address 80
sub $s2, $t1, $t2   #s2 = t2 - t1 = 4
and $t3, $t1, $t2   #t3 = t1 & t2 = 0101 & 1001 = 0001 = 1
or $s3, $t1, $t2    #s3 = t1 | t2 = 0101 | 1001 = 1101 = 13
nor $s1, $s2, $t3   #s1 = ~(s2 | t3) = ~(0000 0000 0000 0100 | 0000 0000 0000 0001) = 0xfffa = 65530
slt $t1, $t2, $t1   #t1 = (t2 < t1) ? 1 : 0 = (5 < 9) = 1
slti $t1, $t1, 0    #t1 = (t1 < 2) ? 1 : 0 = (1 < 0) = 0
lw $t1, 80($zero)   #t1 = memory address 80 = 5
beq $t1, $t1, 100   #PC = 100 if t1 - t1 = 0 => true so jump to 0x0064
