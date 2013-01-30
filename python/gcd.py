__author__ = 'danili'

#Utils for finding GCD - Greatest Common Divisor

#1 by division
def gcd1(a, b):
	while a != 0 and b != 0:
		if a > b:
			a = a % b
		else:
			b = b % a
	return a + b #some of them will be null here.

#2 by subtraction
def gcd2(a, b):
	while a != 0 and b != 0:
		if a > b:
			a = a - b
		else:
			b = b - a
	return a + b

print gcd1(54,24)
print gcd2(0,21)

