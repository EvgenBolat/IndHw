.include "MyLib.s"
.data  
	.align	2
	arrayB: .space 40
	.align	2
	arrayA:	.space 40
.text
	inputSize(t0) #arg - where we need to return the introduced from user size of Array
	addi	sp, sp, -20
	la	t1, arrayA
	sw	t1, 4(sp) 
	sw	t0, (sp) #save the array size on the stack
	inputArray(t0, t1) #first arg – Array size; second arg - pointer to Array. Returns nothing
	print_str("\nArrayA: ")
	lw	t0, (sp)
	lw	t1, 4(sp)
	printArray(t0, t1) #first arg – Array size; second arg - pointer to Array. Print the array in the console and returns nothing.
	lw	t0, 4(sp)
	lw	t1, (sp)
	SumOfEvenIndexes(t1, t0, t2) #first arg – Array size; second arg - pointer to Array; third arg - where we need to return the sum
	lw	t0, 4(sp)
	lw	t1, (sp)
	la	t3, arrayB
	sw	t3, 8(sp)
	ArrayFromElemLessSum(t2, t1, t0, t3, t2) #first arg – the sum of even elements in ArrayA; second arg – ArrayA size; third arg - pointer to ArrayA; fourth arg – pointer to ArrayB; fifth arg – where we need to return the size of ArrayB
	la	t0, arrayB
	print_str("\nArrayB: ")
	printArray(t2, t0) #first arg – Array size; second arg - pointer to Array. Print the array in the console and returns nothing.
	addi	sp, sp, 20
	li	a7, 10
	ecall
