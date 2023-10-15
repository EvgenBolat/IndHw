.include "macrolib.s"		
.macro inputSize(%sizeRet)
	addi 	sp, sp, -4
	li	t0, 10 #store the maximal number of array elements
	sw	t0, (sp)
	print_str("Enter the number of elements in the array: ")
	read_int (a0)
	lw	t0, (sp)
	bgt	a0, t0, errorSize
	blez 	a0, errorSize
	j	doneInputSize #if everything is okay – go to the end of macro
	errorSize:
		print_str("\nThe number of elements must be from 1 to 10 inclusive!\n")
		li	a7, 10
		ecall
	doneInputSize:
		addi	sp, sp, 4
		mv 	%sizeRet, a0
	.end_macro

.macro inputArray(%size, %pointer)
	addi	sp, sp, -8
	sw	%size, (sp)
	sw	%pointer, 4(sp)
	fill:
		print_str("\nPlease enter a number into the array: ")
		read_int (a0)
	        lw	t1, 4(sp)
	        sw      a0, (t1)
        	addi    t1, t1, 4 #move the pointer
        	sw	t1, 4(sp)
        	lw	t0, (sp)
	        addi    t0, t0, -1 
	        sw	t0, (sp)
	        bnez    t0, fill
	addi	sp, sp, 8
.end_macro 

.macro SumOfEvenIndexes(%size, %pointer, %ret_sum)
	addi	sp, sp, -20
	sw	%pointer, 16(sp)
	li	t4, 0 #counter for Array
	li	t5, 0 #sum
	sw	t4, (sp)
	sw	t5, 8(sp)
	li	t2, 2 #for parity checking and for storing threshold values
	sw	t2, 4(sp)
	sw	%size, 12(sp)
	CountSum:
	lw	t2, 4(sp)
	lw	t5, 8(sp)
	lw	t1, 12(sp)
	lw	t4, (sp) 
	beq	t1, t4, DoneSum #array exit check
	rem	t6, t4, t2 #remainder
	bnez	t6, Next #if the index number is odd
	SumCheck:
	lw	t0, 16(sp)
	lw	t6, (t0)
	beqz 	t5, Sum #comparing the current Sum
        bgtz  	t5, SumGr0
        bltz	t5, SumLs0
	SumGr0:
		bgtz 	t5, SumNumGr0
		bltz	t5, Sum
	SumLs0:
		bgez 	t5, Sum
		li	t2, -2147483648
		sub	t2, t2, t5
		blt	t6, t2, error #in case of possible overflow
		b 	Sum
	SumNumGr0:
		li	t2, 2147483647
		sub	t2, t2, t5
		bgt	t6, t2, error 
	Sum:
		add	t5, t5, t6 #increase the sum
		sw	t5, 8(sp)			
	Next:
		addi    t4, t4, 1
		sw	t4, (sp)
		addi 	t0, t0, 4 #move on 4 bytes 
		sw	t0, 16(sp)
	        j CountSum
	DoneSum:
		print_str("\nThe sum of the numbers in even places is equal to: ")
		lw	a0, 8(sp) #for printing the sum
		print_int(a0)
		addi 	sp, sp, 20
		j	DoneSumEven
	error:
	print_str("\nThere's been an overflow!")
	li	a7, 10
	ecall
	DoneSumEven:
		mv	%ret_sum, a0
.end_macro 

.macro ArrayFromElemLessSum(%sum, %size, %pointerA, %pointerB, %sizeB)
	addi	sp, sp, -20
	sw	%sum, 16(sp)
	sw	%size, 12(sp)
	sw	%pointerA, 8(sp)
	sw	%pointerB, 4(sp)
	li	t5, 0 #ArrayB size
	sw	t5, (sp)
	loop:
	lw	t0, 12(sp)
	lw	t3, 4(sp)
	lw      t1, 8(sp)
	lw	t4, (t1)
	lw	t6, 16(sp)
	bge	t4, t6, NextElem #check if the element is greater than the sum
	sw	t4, (t3) #store the number of ArrayB in ArrayB
	addi	t3, t3, 4
	addi	t5, t5, 1
	sw	t3, 4(sp)
	sw	t5, (sp)
	NextElem:
	addi	t0, t0, -1
	addi	t1, t1, 4
	sw	t0, 12(sp)
	sw	t1, 8(sp)
	bnez    t0, loop
	mv	%sizeB, t5 # ArrayB size
	addi 	sp, sp, 20
	.end_macro 

.macro printArray(%size, %pointer)
	bnez	%size, NotEmpty
	print_str("\nArray is empty")
	j	doneprint
	NotEmpty:
	addi	sp, sp, -8
	sw	%size, 4(sp)
	sw	%pointer, (sp)
	lw	t1, 4(sp) #counter
	lw	t3, (sp)
	bnez 	t1, printNew
	addi	sp, sp, 12
	j	doneprint
	printNew:
	lw	t0, (t3)
	print_int(t0)
	print_str(" ")
	addi	t1, t1, -1
	sw	t1, 4(sp)
	addi	t3, t3, 4
	sw	t3, (sp)
	bnez  	t1, printNew
	addi	sp, sp, 8
	doneprint:
	.end_macro
