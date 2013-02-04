#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'ivan'

# SelectionSort function.
# Time: n*n
def selection_sort(list):
	N = len(list)
	for i in range(0, N - 1):
		minInd = list[i]
		for j in range(i, N - 1):
			if list[j] <= list[minInd]:
				minInd = j
		#swap
		tmp = list[i]
		list[i] = list[minInd]
		list[minInd] = tmp
		#print list
	return list


def main():
	list = [5, 2, 6, 3, 1, 4, 7, 9, 0, 8]
	print ' input:' + str(list)
	result = selection_sort(list)
	print 'result:' + str(result)

if __name__ == '__main__':
	main()