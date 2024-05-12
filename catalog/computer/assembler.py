# define opcodes
opcodes = {
    'add': '000',
    'sub': '000',
    'and': '000',
    'or': '000',
    'slt': '000',
    'nor': '000',
    'lw': '001',
    'sw': '010',
    'addi': '011',
    'beq': '100',
    'slti': '101',
    'j': '110',
    'jal': '111'
}

# define alu controls
alu_controls = {
    'add': '0000',
    'sub': '0001',
    'and': '0010',
    'or': '0011',
    'slt': '0100',
    'nor': '0101'
}

# define registers
register_map = {
    '$zero': '000',
    '$t1': '001',
    '$t2': '010',
    '$t3': '011',
    '$s1': '100',
    '$s2': '101',
    '$s3': '110',
    '$ra': '111'
}

# convert register name to binary
def reg_to_bin(reg):
    if reg in register_map:
        return register_map[reg]
    else:
        raise ValueError(f"Unknown register: {reg}")

# sign extension and binary formatting
def format_binary(value, bits):
    return format((value + (1 << bits)) % (1 << bits), f'0{bits}b')

# instruction to binary
def assemble(parts, label_map, current_address):
    inst_type = parts[0].lower()
    opcode = opcodes[inst_type]

    if inst_type in ['add', 'sub', 'and', 'or', 'slt', 'nor']:
        rs = reg_to_bin(parts[3].strip(','))
        rt = reg_to_bin(parts[2].strip(','))
        rd = reg_to_bin(parts[1].strip(','))
        funct_bin = alu_controls[inst_type]
        return f'{opcode}{rs}{rt}{rd}{funct_bin}'

    elif inst_type in ['lw', 'sw']:
        rt = reg_to_bin(parts[1].strip(','))
        offset_reg = parts[2].split('(')
        immediate = int(offset_reg[0])
        rs = reg_to_bin(offset_reg[1].strip(')').strip(','))
        immediate_bin = format_binary(immediate, 7)
        return f'{opcode}{rs}{rt}{immediate_bin}'

    elif inst_type in ['addi', 'beq', 'slti']:
        rs = reg_to_bin(parts[2].strip(','))
        rt = reg_to_bin(parts[1].strip(','))
        immediate = parts[3]
        if immediate.isdigit():
            immediate_bin = format_binary(int(immediate), 7)
        else:
            offset = (label_map[immediate] - (current_address + 2)) * 2
            immediate_bin = format_binary(offset, 7)
        return f'{opcode}{rs}{rt}{immediate_bin}'

    elif inst_type in ['j', 'jal']:
        address = parts[1]
        if address.isdigit():
            address_bin = format_binary(int(address), 13)
        elif address in label_map:
            address_bin = format_binary(label_map[address], 13)
        else:
            address_bin = '0000000000000'
        return f'{opcode}{address_bin}'

def process_asm_file(input_file, output_file):
    label_map = {}
    address = 0 

    try:
        with open(input_file, 'r') as file:
            for line in file:
                line = line.strip()
                if line.endswith(':'):
                    label = line[:-1]
                    label_map[label] = address
                elif not line.startswith('#') and line:
                    address += 2

        with open(input_file, 'r') as file, open(output_file, 'w') as output_file:
            address = 0
            for line in file:
                line = line.strip()
                if line and not line.startswith('#') and not line.endswith(':'):
                    parts = line.split()
                    binary_instruction = assemble(parts, label_map, address)
                    if binary_instruction:
                        output_file.write(binary_instruction + '\n')
                    address += 2

    except Exception as e:
        print(f"An error occurred during assembly: {str(e)}")

# enter input file here
input_asm_file = 'asm/leaf.asm'

# enter output file here
output_machine_code_file = 'exe/leaf_exe'

process_asm_file(input_asm_file, output_machine_code_file)
