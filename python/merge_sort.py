#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'ivan'

# MergeSort function.
# Time: n*ln(n)
def merge_sort(list):
	N = len(list)
	if N <= 1:
		return list
	middle = N / 2
	left = merge_sort(list[0:middle])
	right = merge_sort(list[middle: N])
	return merge(left, right)

# merges two sorted arrays.
def merge(left, right):
	result = []
	i = j = 0
	while i < len(left) and j < len(right):
		if left[i] <= right[j]:
			result.append(left[i])
			i += 1
		else:
			result.append(right[j])
			j += 1
	#copy rest - one of them is empty.
	result += left[i:]
	result += right[j:]
	return result


def main():
	list = [5, 2, 6, 3, 1, 4, 7, 9, 0, 8]
	print ' input:' + str(list)
	result = merge_sort(list)
	print 'result:' + str(result)

if __name__ == '__main__':
	main()
