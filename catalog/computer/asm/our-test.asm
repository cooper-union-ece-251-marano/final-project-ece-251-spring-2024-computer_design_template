addi $t1, $zero, 5
addi $t2, $zero, 9
add $s1, $t2, $t1
sub $s2, $s1, $t2
and $t3, $t1, $t2
or $t2, $t2, $t3
slt $s1, $t1, $t2
sw $t2, 32($t1)
lw $s1, 32($t1)
stli $s3, $t3, 8
j 32
