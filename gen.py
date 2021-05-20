s = ""
l = 32

for _ in range(l):
	for c in range(16):
		import random
		temp = str(random.randint(0, 1))
		s += temp
	s += "\n"

with open("inp", "w") as f:
	f.write(s)
