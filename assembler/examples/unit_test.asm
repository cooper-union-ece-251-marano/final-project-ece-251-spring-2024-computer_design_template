NOOP
JR $hi
BNE $a, $x, 100
BE $a, $x, 100
BL $a, $x, 100
BG $a, $x, 100
BLE $a, $x, 100
BGE $a, $x, 100
HALT 0x10
LIHI 0b20
LILO 0b20
INC $a
DEC $a
RST $hi
ADD $lo, $a, $x
LWOFF $a, $x, $lo
SWOFF $a, $x, $lo
XOR $lo, $a, $x
AND $lo, $a, $x
OR $lo, $a, $x
SET $lo, $hi
MULT $a, $x
MFHI $lo
MFLO $lo
OUT $a
SLL $lo, $a, $x
SLR $lo, $a, $x
ADDI $lo, $hi, 4000
J 100
LW $hi, $lo, 4000
SW $hi, $lo, 4000
XORI $lo, $hi, 4000
ANDI $lo, $hi, 4000
ORI $lo, $hi, 4000
SETI $lo, 4000
SLLI $lo, $hi, 4000
SLRI $lo, $hi, 4000
JAL 100