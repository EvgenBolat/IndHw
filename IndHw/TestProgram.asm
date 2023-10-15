.include "MyLib.s"
.data 
	.align	2
	arrA:	.space 40
	arrend:
	.align	2
	arrB: .space 40
.text 
	la	t0, arrA
	li	t1, 2 #full array
	sw	t1, (t0)
	li	t1, -6
	sw	t1, 4(t0)
	li	t1, 0
	sw	t1, 8(t0)
	li	t1, 2343
	sw	t1, 12(t0)
	li	t1, -123
	sw	t1, 16(t0)
	li	t1, 5 #write the arrayA size
	print_str("\nArrayA: ")
	la	t0, arrA
	printArray(t1, t0)
	li	t1, 5
	la	t0, arrA
	SumOfEvenIndexes(t1, t0, t2)
	li	t1, 5
	la	t0, arrA
	la	t3, arrB
	ArrayFromElemLessSum(t2, t1, t0, t3, t2)
	print_str("\nArrayB: ")
	la	t3, arrB
	printArray(t2, t3)
	newline
	print_str("____________________________")
	
	#second test: all zero
	la	t0, arrA
	li	t1, 0
	sw	t1, (t0)
	li	t1, 0
	sw	t1, 4(t0)
	li	t1, 0
	sw	t1, 8(t0)
	li	t1, 3
	print_str("\nArrayA: ")
	la	t0, arrA
	printArray(t1, t0)
	li	t1, 3
	la	t0, arrA
	SumOfEvenIndexes(t1, t0, t2)
	li	t1, 3
	la	t0, arrA
	la	t3, arrB
	ArrayFromElemLessSum(t2, t1, t0, t3, t2)
	print_str("\nArrayB: ")
	la	t3, arrB
	printArray(t2, t3)
	newline
	print_str("____________________________")
	
	#third test: all elements less sum
	la	t0, arrA
	li	t1, -2
	sw	t1, (t0)
	li	t1, 0
	sw	t1, 4(t0)
	li	t1, -6
	sw	t1, 8(t0)
	li	t1, 3
	print_str("\nArrayA: ")
	la	t0, arrA
	printArray(t1, t0)
	li	t1, 3
	la	t0, arrA
	SumOfEvenIndexes(t1, t0, t2)
	li	t1, 3
	la	t0, arrA
	la	t3, arrB
	ArrayFromElemLessSum(t2, t1, t0, t3, t2)
	print_str("\nArrayB: ")
	la	t3, arrB
	printArray(t2, t3)
	newline
	print_str("____________________________")
	
	#fourth test: 10 elements
	la	t0, arrA
	li	t1, 234
	sw	t1, (t0)
	li	t1, 0
	sw	t1, 4(t0)
	li	t1, -24
	sw	t1, 8(t0)
	la	t0, arrA
	li	t1, 1000
	sw	t1, 12(t0)
	li	t1, 34
	sw	t1, 16(t0)
	li	t1, -234
	sw	t1, 20(t0)
	li	t1, 423
	sw	t1, 24(t0)
	li	t1, 12
	sw	t1, 28(t0)
	li	t1, 90
	sw	t1, 32(t0)
	li	t1, 31
	sw	t1, 36(t0)
	li	t1, 10
	print_str("\nArrayA: ")
	la	t0, arrA
	printArray(t1, t0)
	li	t1, 10
	la	t0, arrA
	SumOfEvenIndexes(t1, t0, t2)
	li	t1, 10
	la	t0, arrA
	la	t3, arrB
	ArrayFromElemLessSum(t2, t1, t0, t3, t2)
	print_str("\nArrayB: ")
	la	t3, arrB
	printArray(t2, t3)
	newline
	print_str("____________________________")
	
	#fifth test: 10 elements and overflow
	la	t0, arrA
	li	t1, 2147482647
	sw	t1, (t0)
	li	t1, 0
	sw	t1, 4(t0)
	li	t1, -24
	sw	t1, 8(t0)
	la	t0, arrA
	li	t1, 1500
	sw	t1, 12(t0)
	li	t1, 3400
	sw	t1, 16(t0)
	li	t1, -234
	sw	t1, 20(t0)
	li	t1, 423
	sw	t1, 24(t0)
	li	t1, 12
	sw	t1, 28(t0)
	li	t1, 90
	sw	t1, 32(t0)
	li	t1, 31
	sw	t1, 36(t0)
	li	t1, 10
	print_str("\nArrayA: ")
	la	t0, arrA
	printArray(t1, t0)
	li	t1, 10
	la	t0, arrA
	SumOfEvenIndexes(t1, t0, t2)
	li	t1, 10
	la	t0, arrA
	la	t3, arrB
	ArrayFromElemLessSum(t2, t1, t0, t3, t2)
	print_str("\nArrayB: ")
	la	t3, arrB
	printArray(t2, t3)
	newline
	li	a7, 10
	ecall
	
	
