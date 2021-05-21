  
codes = {"add": ("0000", 0), "adc": ("0000", 0), "adz": ("0000", 0), \
"adi": ("0001", 1), "ndu": ("0010", 0), "ndc": ("0010", 0), \
"ndz": ("0010", 0), "lhi": ("0011", 2), "lw": ("0100", 1), \
"sw": ("0101", 1), "lm": ("0110", 2), "sm": ("0111", 2), \
"beq": ("1100", 1) \
}

import sys
in_file = open('in.txt', 'r')
out_file = open('input_file.txt', 'w')

lines = in_file.readlines()

for line in lines:
	inst = line.strip().lower().split()
	outline = ""

	if inst[0] == 'jalr':
		if inst[2][0] == 'r':
			outline = "1001" + '{0:03b}'.format(int(inst[1][1])) + '{0:03b}'.format(int(inst[2][1])) + "000000"
		else:
			outline = "1000" + '{0:03b}'.format(int(inst[1][1])) + '{0:09b}'.format(int(inst[2]))
	else :

		if inst[0] not in codes.keys():
			sys.exit("Invalid Instruction : {}\n".format(inst[0]))

		op = codes[inst[0]][0]
		typ = codes[inst[0]][1]

		if typ == 0:
			rc = '{0:03b}'.format(int(inst[1][1]))
			ra = '{0:03b}'.format(int(inst[2][1]))
			rb = '{0:03b}'.format(int(inst[3][1]))

			lst = "00"
			if inst[0][2] == 'c': lst = "10"
			if inst[0][2] == 'z': lst = "01"

			outline = op + ra + rb + rc + "0" + lst

		if typ == 1:
			imm = '{0:06b}'.format(int(inst[3]))
			ra = '{0:03b}'.format(int(inst[1][1]))
			rb = '{0:03b}'.format(int(inst[2][1]))
			if inst[0] == 'adi':
				ra, rb = rb, ra

			outline = op + ra + rb + imm

		if typ == 2:
			imm = "0"*9
			if inst[0] == "lhi":
				imm = '{0:09b}'.format(int(inst[2]))
			ra = '{0:03b}'.format(int(inst[1][1]))

			outline = op + ra + imm

	out_file.write(outline + "\n")