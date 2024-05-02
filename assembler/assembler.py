from typing import Callable
from nTypes import *

def removNestings(l):
    output = []
    for i in l:
        if type(i) == list:
            output.extend(removNestings(i))
        else:
            output.append(i)
    return output

instructions: dict[str, list[int, str, int]] = {
    'ADDI' : [-1, 'N'],
    'NOOP' : [0, 'J'],
    'INC' : [16, 'R'],
    'DEC' : [17, 'R'],
    'RST' : [18, 'R'],
    'J' : [-1, 'N'],
    'JR' : [1, 'J'],
    'BNE' : [2, 'J'],
    'BE' : [3, 'J'],
    'ADD' : [19, 'R'],
    'LW' : [-1, 'N'],
    'SW' : [-1, 'N'],
    'LWOFF' : [20, 'R'],
    'SWOFF' : [21, 'R'],
    'XOR' : [22, 'R'],
    'AND' : [23, 'R'],
    'OR' : [24, 'R'],
    'XORI' : [-1, 'N'],
    'ANDI' : [-1, 'N'],
    'ORI' : [-1, 'N'],
    'SETI' : [-1, 'N'],
    'SET' : [25, 'R'],
    'MULT' : [26, 'R'],
    'MFHI' : [27, 'R'],
    'MFLO' : [28, 'R'],
    'BL' : [4, 'J'],
    'BG' : [5, 'J'],
    'BLE' : [6, 'J'],
    'BGE' : [7, 'J'],
    'LIHI' : [9, 'I'],
    'LILO' : [10, 'I'],
    'OUT' : [29, 'R'],
    'HALT' : [8, 'I'],
    'SLLI' : [-1, 'N'],
    'SLRI' : [-1, 'N'],
    'SLL' : [30, 'R'],
    'SLR' : [31, 'R'],
    'JAL' : [-1, 'N']
}

nTypeFunctions: dict[str, Callable] = {
    'ADDI' : ADDI,
    'J' : J,
    'LW' : LW,
    'SW' : SW,
    'XORI' : XORI,
    'ANDI' : ANDI,
    'ORI' : ORI,
    'SETI' : SETI,
    'SLLI' : SLLI,
    'SLRI' : SLRI,
    'JAL' : JAL
}

blanks: dict[str, int] = {
    'R' : 2,
    'I' : 3,
    'J' : 8,
    'N' : 0
}

registers: dict[str, int] = {
    '$pc' : 0,
    '$sp' : 1,
    '$ra' : 2,
    '$im' : 3,
    '$a' : 4,
    '$x' : 5,
    '$hi' : 6,
    '$lo' : 7,
}

import sys

def parseLine(line: str, labels: dict[str, int], insCount: int) -> list[str]:
    values: list[str] = line.strip().split(' ')
    info: list[int, str] = instructions[values[0]]
    op: str = bin(info[0])[2:].rjust(5, '0')[:5] + ('0' * blanks[info[1]])
    if info[1] == 'R':
        for reg in values[1:]:
            op += bin(registers[reg.rstrip(',')])[2:].rjust(3, '0')
    elif info[1] == 'I':
        halfImm: str = values[1]
        if len(halfImm) >= 3:
            if halfImm[0:2] == '0b':
                num = halfImm[2:].rjust(8, '0')
                op += num
            elif halfImm[0:2] == '0x':
                num = bin(int(halfImm[2:], 16))[2:].rjust(8, '0')
                op += num
            else:
                op += bin(int(halfImm))[2:].rjust(8, '0')
        else:
            op += bin(int(halfImm))[2:].rjust(8, '0')
    elif info[1] == 'J':
        if (values[0] not in 'NOOP'):
            op += bin(registers[values[1].rstrip(',')])[2:].rjust(3, '0')
    else:
        if values[0] in ['JAL', 'J']:
            ops = (nTypeFunctions[values[0]](line, labels, insCount))
        else:
            ops = (nTypeFunctions[values[0]](line))
        return removNestings([parseLine(ins, labels, insCount) for ins in ops])
    op = op.ljust(16, '0')
    return [op]

def main() -> None:
    verbose: bool = False
    labels: dict[str, int] = {}
    insCount: int = 0
    args: list[str] = sys.argv[1:]
    if len(args) == 0:
        raise Exception('Input file name not provided.')
    if len(args) == 1:
        raise Exception('Output file name not provided.')
    if len(args) == 3:
        if args[2] == '-v':
            verbose = True
    inFileName = args[0]
    outFileName = args[1]
    lines: list[str] = []
    with open(inFileName, 'r') as inFile:
        lines = inFile.readlines()
    with open(outFileName, 'w') as outFile:
        for line in lines:
            if line[0] == '#' or line == '\n':
                if verbose:
                    print(line.strip())
                    print(['COMMENT'])
                    print()
                continue
            if line[0] == '.':
                labels[line.strip()] = insCount
                if verbose:
                    print(line.strip())
                    print(['LABEL', f'{line.strip()} = {labels[line.strip()]}'])
                    print()
                continue
            ops = parseLine(line, labels, insCount)
            if verbose:
                print(line.strip())
                print(ops)
                print()
            insCount += len(ops)
            for op in ops:
                outFile.write(op+'\n')
    
if __name__ == '__main__':
    main()