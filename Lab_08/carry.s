	.data
num1:	.word 0x7fffffff
num2:	.word 0x80000000
num3:	.word 0xffffffff
num4:	.word 0
num5:	.word 1

main: 
	addi	$sp, $sp, -4
	la 	$t3, num1
	la	$t4, num2
	add	$t2, $t3, $t4
	