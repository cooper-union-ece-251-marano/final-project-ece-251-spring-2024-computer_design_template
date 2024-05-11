# Define opcodes and alu controls
opcodes = {
    'add': '000',
    'sub': '000',
    'and': '000',
    'or': '000',
    'slt': '000',
    'lw': '001',
    'sw': '010',
    'addi': '011',
    'beq': '100',
    'stli': '101',
    'j': '110',
    'jal': '111'
}

alu_controls = {
    'add': '0000',
    'sub': '0001',
    'and': '0010',
    'or': '0011',
    'slt': '0100'
}

# Register name to binary mapping
register_map = {
    '$zero': '000',
    '$t1': '001',
    '$t2': '010',
    '$s1': '011',
    '$s2': '100',
    '$t3': '101',
    '$s3': '110',
    '$ra': '111'
}

# Convert register name to binary
def reg_to_bin(reg):
    if reg in register_map:
        return register_map[reg]
    else:
        raise ValueError(f"Unknown register: {reg}")

# Sign extension
def format_binary(value, bits):
    if value < 0:
        value = (1 << bits) + value
    return format(value, f'0{bits}b')[-bits:]


# Instruction to binary
def assemble(parts, label_map):
    inst_type = parts[0].lower()
    opcode = opcodes[inst_type]

    try:
        if inst_type in ['add', 'sub', 'and', 'or', 'slt']:
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

        elif inst_type in ['addi', 'beq', 'stli']:
            rs = reg_to_bin(parts[2].strip(','))
            rt = reg_to_bin(parts[1].strip(','))
            immediate = parts[3]
            if immediate.isdigit():
                immediate_bin = format_binary(int(immediate), 7)
            else:
                immediate_bin = format_binary(label_map[immediate], 7)
            return f'{opcode}{rs}{rt}{immediate_bin}'

        elif inst_type in ['j', 'jal']:
            address = parts[1]
            if address in label_map:
                address_bin = format_binary(label_map[address], 13)
            else:
                address_bin = '0000000000000'  # default for undefined labels, consider handling this case better
            return f'{opcode}{address_bin}'
    except KeyError as e:
        print(f"Error processing instruction: {parts}. Missing label or register info: {e}")
        return None

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
                elif not line.startswith('#') and not line.endswith(':'):
                    address += 1

        with open(input_file, 'r') as file, open(output_file, 'w') as output_file:
            for line in file:
                line = line.strip()
                if line and not line.startswith('#') and not line.endswith(':'):
                    parts = line.split()
                    if parts[0] in ['j', 'beq', 'jal'] and parts[-1] in label_map:
                        parts[-1] = str(label_map[parts[-1]])  # Replace label with its address
                    binary_instruction = assemble(parts, label_map)
                    if binary_instruction:
                        output_file.write(binary_instruction + '\n')

    except Exception as e:
        print(f"An error occurred during assembly: {str(e)}")

# Usage
input_asm_file = 'out-test.asm'
output_machine_code_file = 'fib_exe'
process_asm_file(input_asm_file, output_machine_code_file)

"""
# Example instructions
instructions = [
    'addi $t1, $zero, 5',
    'addi $t2, $zero, 9',
    'add $s1, $t2, $t1',
    'sub $s2, $s1, $t2',
    'and $t3, $t1, $t2',
    'or $t2, $t2, $t3',
    'slt $s1, $t1, $t2',
    'sw $t2, 32($t1)',
    'lw $s1, 32($t1)',
    'stli $s3, $t3, 8',
    'beq $t2, $s1, 70',
    'j 0'
]

# Assemble and print the instructions
for inst in instructions:
    try:
        print(f'{assemble(inst)}')
    except ValueError as e:
        print(e)"""

