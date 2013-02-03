#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'ivan'

#MergeSort function.
# Time: n*ln(n)
def mergesort(list):
	N = len(list)
	if N <= 1:
		return None
	l1 = list[0:N / 2]
	l2 = list[N / 2: N]
	mergesort(l1)
	mergesort(l2)
	return merge(l1, l2)

#merges two sorted arrays.
def merge(list1, list2):
	p = len(list1)
	q = len(list2)
	result = []
	i = j = 0
	while i < p and j < q:
		if list1[i] <= list2[j]:
			result.append(list1[i])
			i += 1
		else:
			result.append(list2[j])
			j += 1
	if i == p:
		result.extend(list2[j:])#copy rest
	elif j == q:
		result.extend(list1[i:])#copy rest
	print str(list1) +"   "+str(list2)
	print result
	return result

list = [5, 2, 6, 3, 1, 4, 7, 9, 8]
print 'input:' + str(list)
result = mergesort(list)
print 'result:' + str(result)

#merge([0,2,5],[3,6,9])


