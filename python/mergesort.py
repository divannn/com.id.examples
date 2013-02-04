#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'ivan'

# MergeSort function.
# Time: n*ln(n)
def mergesort(list):
	N = len(list)
	if N <= 1:
		return list
	#middle = int(len(list) / 2)
	l1 = list[0:N / 2]
	l2 = list[N / 2: N]
	l1 = mergesort(l1)
	l2 = mergesort(l2)
	return merge(l1, l2)

# merges two sorted arrays.
def merge(left, right):
	result = []
	p = len(left)
	q = len(right)
	i = j = 0
	while i < p and j < q:
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

# test
list = [5, 2, 6, 3, 1, 4, 7, 9, 0, 8]
print ' input:' + str(list)
result = mergesort(list)
print 'result:' + str(result)
