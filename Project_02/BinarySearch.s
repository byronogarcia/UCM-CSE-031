.data 

original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: \n"
str2: .asciiz "Content of list: "
str3: .asciiz "Enter a key to search for: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"



.text 

#This is the main program.
#It first asks user to enter the size of a list.
#It then asks user to input the elements of the list, one at a time.
#It then calls printList to print out content of the list.
#It then calls inSort to perform insertion sort
#It then asks user to enter a search key and calls bSearch on the sorted list.
#It then prints out search result based on return value of bSearch
main: 
	addi $sp, $sp -8
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	#Read size of list from user
	syscall
	move $s0, $v0
	move $t0, $0
	la $s1, original_list
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	#Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	li $v0, 4 
	la $a0, str2 
	syscall 
	move $a0, $s1
	move $a1, $s0
	jal printList	#Call print original list
	
	jal inSort	#Call inSort to perform insertion sort in original list
	sw $v0, 4($sp)
	li $v0, 4 
	la $a0, str2 
	syscall 
	lw $a0, 4($sp)
	jal printList	#Print sorted list
	
	li $v0, 4 
	la $a0, str3 
	syscall 
	li $v0, 5	#Read search key from user
	syscall
	move $a2, $v0
	lw $a0, 4($sp)
	jal bSearch	#Call bSearch to perform binary search
	
	beq $v0, $0, notFound
	li $v0, 4 
	la $a0, strYes 
	syscall 
	j end
	
notFound:
	li $v0, 4 
	la $a0, strNo 
	syscall 
end:
	lw $ra, 0($sp)
	addi $sp, $sp 8
	li $v0, 10 
	syscall
	
	
#printList takes in a list and its size as arguments. 
#It prints all the elements in one line.
printList:
	#Your implementation of printList here	
	
	li $t0, 0 #resetting
	li $t1, 0 #the
	li $t2, 0 #temps
	li $t3, 0 #to
	li $t5, 0 #zero
	
	move $t4, $a1 #size of list
	la $t1, ($s1) #load list address
	
print_loop:
	add $t2, $t0, $t1 #spot in list
	lw $t3, 0($t2) #value of current spot
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $a0, 32 #in ascii 32 is a space character
	li $v0, 11 #sycscall 11 prints as an ascii character
	syscall
	
	addi $t0, $t0, 4 
	addi $t5, $t5, 1
	bne  $t4, $t5, print_loop
	
	addi $a0, $0, 10 
	addi $v0, $0, 11 #syscall 11 prints as an ascii character
        syscall
        
	jr $ra
	
#inSort takes in a list and it size as arguments. 
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort:
	#Your implementation of inSort here
	la $t0, original_list
	la $t1, sorted_list
	li $t2, 0 #reset
	li $t5, 0 #again
	
array_copy: #original_list -> sorted_list
	add $t3, $t0, $t2
	add $t4, $t1, $t2
	lw $t3, 0($t3)
	sw $t3, 0($t4)
	addi $t2, $t2, 4
	addi $t5, $t5, 1
	bne $t5, $a1, array_copy
	
	la $t0, sorted_list
	li $t1, 0
	#add $t1, $0, $0
outerLoop:
	addi $t1, $t1, 1 #counter
	addi $s7, $t1, 0 #count of times we move in inLoop
	addi $t0, $t0, 4 #curr
	lw $t3, 0($t0)
	add $t2, $t1, $zero
	bne $t1, $a1, inLoop #if ($t1 != $a1) then go to inLoop
	beq $t1, $a1, sortEnd
	
inLoop:
	addi $t2, $t2, -1 #point before current $t1
	la $t9, sorted_list
	add $t8, $t2, $zero
	add $t8, $t8, $t8
	add $t8, $t8, $t8
	add $t8, $t9, $t8 #value at $t2 point in list
	lw $t4, 0($t8)
	slt $t9, $t3, $t4 #if curr value < value before it, then switch spots
	beq $t9, 1, replace
	
	beqz $t2, outerLoop #if done
	bnez $t2, inLoop #if not done
	
replace:
	la $t9, sorted_list

	add $t5, $s7, $zero
	add $t5, $t5, $t5
	add $t5, $t5 $t5 
	add $t5, $t5, $t9
	
	add $t6, $t2, $zero
	add $t6, $t6, $t6
	add $t6, $t6, $t6
	add $t6, $t6, $t9	
	
	sw $t3, ($t6)
	sw $t4, ($t5)

	addi $s7, $s7, -1 #update inloop counter
	bnez $t2, inLoop
	move $s7, $t1 #reset inloop counter
	beqz $t2, outerLoop
	 

sortEnd:
	la $s1, sorted_list
	jr $ra
	
	
#bSearch takes in a list, its size, and a search key as arguments.
#It performs binary search RECURSIVELY to look for the search key.
#It will return a 1 if the key is found, or a 0 otherwise.
#Note: you MUST NOT use iterative approach in this function.
bSearch:
	#Your implementation of bSearch here
	#$a2 = key
	#$s0 = size
	#$s1 = address
	lw $t0, ($s1)
	
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	add $t3, $s0, $0 
	sra $s0, $s0, 1 #size/2
	
	add $t2, $s0, $0 #midpoint
	add $t2, $t2, $t2
	add $t2, $t2, $t2
	la $t4, ($s1)
	add $t4, $t2, $t4
	lw $t5, ($t4)
	move $v0 $s7
	
	beq $s7, $t5, bSearchEnd #check if both are equal to eachother
	beq $s0, 0, bSearchCont #check if end of search
	
	bgt $a2, $t5, keyGreater
	blt $a2, $t5, keyLess
	
keyGreater: 
	la $s1, 4($t4) 
keyLess:
	jal bSearch #recursion
	
Exit: #restore return address and exit
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
		
bSearchEnd:	
	addi $v0, $0, 1
	j  Exit
			
bSearchCont:
	move $v0, $0
	j  Exit
