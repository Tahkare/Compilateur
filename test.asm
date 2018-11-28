.text
	beqz $a0, init_end
	lw $a0, 0($a1)
	jal atoi
	la $t0, arg
	sw $v0, 0($t0)
init_end:
	li $v0, 9
	li $a0, 500
	syscall
	la $t0, __begin
	sw $v0, 0($t0)
	la $t0, __next
	sw $v0, 0($t0)
	add $v0, $v0, $a0
	la $t0, __end
	sw $v0, 0($t0)
	move $fp, $sp
	jal main_int
	li $v0, 10
	syscall
#print_int
print_int_int:
	li $v0, 1
	syscall
	move $v0, $a0
	li $v1, 0
	jr $ra
#power
power_int_int:
	move $s5, $a0
	move $s4, $a2
	li $t0, 1
	b power_loop_guard
power_loop_code:
	mul $t0, $t0, $s5
	subi $s4, $s4, 1
power_loop_guard:
	bgtz $s4, power_loop_code
	move $v0, $t0
	li $v1, 0
	jr $ra
#print
print_int:
	li $v0, 11
	syscall
	move $v0, $a0
	li $v1, 0
	jr $ra
#scan_int
scan_int:
	li $v0, 5
	syscall
	li $v1, 0
	jr $ra
print_three:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
	li $t0, 3
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
	jal print_int_int
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
main_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
	move $t2, $zero
	li $t0, 1
	move $t3, $t0
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	jal print_three
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	li $t0, 4
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	jal print_int_int
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	li $t0, 3
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	jal double_int
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	jal print_int_int
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	jal double
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	jal print_int_int
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 8
	li $t0, 2
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	li $v0, 9
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	li $t1, 8
	mul $a0, $t0, $t1
	addi $a0, $a0, 4
	syscall
	addi $t1, $v0, 4
	sll $t0, $t0, 16
	addi $t0, $t0, 0
	sw $t0, -4($t1)
	move $t0, $t1
	li $t1, 1
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	move $t4, $t0
	move $t5, $t1
	move $t1, $t5
	move $t0, $t4
	move $t2, $t0
	move $t3, $t1
	li $t0, 0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
	b _label_2
_label_1:
	li $t0, 2
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	li $v0, 9
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	sw $t6, 0($sp)
	sw $t7, 4($sp)
	addi $sp, $sp, 8
	sw $t8, 0($sp)
	sw $t9, 4($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	li $t1, 8
	mul $a0, $t0, $t1
	addi $a0, $a0, 4
	syscall
	addi $t1, $v0, 4
	sll $t0, $t0, 16
	addi $t0, $t0, 0
	sw $t0, -4($t1)
	move $t0, $t1
	li $t1, 1
	subi $sp, $sp, 8
	lw $t8, 0($sp)
	lw $t9, 4($sp)
	subi $sp, $sp, 8
	lw $t6, 0($sp)
	lw $t7, 4($sp)
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	move $t4, $t0
	move $t5, $t1
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t8, $t0
	move $t9, $t1
	move $t1, $t9
	move $t0, $t8
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t7
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t7
	move $t0, $t6
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
_label_4:
	li $t0, 1
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t6, $t0
	move $t7, $t1
	move $t1, $t5
	move $t0, $t4
	move $s2, $t0
	move $t1, $t7
	move $t0, $t6
	move $t1, $s2
	add $t0, $t1, $t0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
_label_2:
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
	move $t1, $t5
	move $t0, $t4
	move $s2, $t0
	move $t1, $t7
	move $t0, $t6
	move $t1, $s2
	slt $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_1
_label_3:
	subi $sp, $sp, 8
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
double_int:
	li $t0, 2
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	mul $t0, $t1, $t0
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
	move $t1, $t3
	move $t0, $t2
	move $v0, $t0
	move $v1, $t1
	jr $ra
	jr $ra
double:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
	li $t0, 0
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
	b double_int
	move $t2, $t0
	move $t3, $t1
	move $t1, $t3
	move $t0, $t2
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
logic_equality:
	beq $a1, $a3, le_same
	li $v0, 0
	jr $ra
le_same:
	bgtz $a1, le_block
	beq $a0, $a2, le_same_true
	li $v0, 0
	jr $ra
le_same_true:
	li $v0, -1
	jr $ra
le_block:
	lw $t0, -4($a0)
	lw $t1, -4($a2)
	move $t2, $t0
	move $t3, $t1
	srl $t0, $t0, 16
	srl $t1, $t1, 16
	sll $t2, $t2, 24
	srl $t2, $t2, 24
	sll $t3, $t3, 24
	srl $t3, $t3, 24
	beq $t0, $t1, le_block_same_length
	li $v0, 0
	jr $ra
le_block_same_length:
	beq $t2, $t3, le_block_same
	li $v0, 0
	jr $ra
le_block_same:
	li $t1, 0
	li $t2, 0
le_block_same_loop:
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a2, 8($sp)
	addi $sp, $sp, 12
	add $a0, $a0, $t2
	lw $a1, 4($a0)
	lw $a0, 0($a0)
	add $a2, $a2, $t2
	lw $a3, 4($a2)
	lw $a2, 0($a2)
	sw $t1, 0($sp)
	sw $t2, 4($sp)
	addi $sp, $sp, 8
	jal logic_equality
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	lw $t2, 4($sp)
	bnez $v0, le_bsl_end
	li $v0, 0
	lw $ra, -12($sp)
	jr $ra
le_bsl_end:
	subi $sp, $sp, 12
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a2, 8($sp)
	addi $t1, $t1, 1
	addi $t2, $t2, 8
	bne $t0, $t1, le_block_same_loop
	li $v0, -1
	jr $ra
#malloc
atoi:
	move $t0, $a0
	li $t1, 0
	li $t3, 10
	li $t4, 48
	li $t5, 57
atoi_loop:
	lbu $t2, 0($t0)
	beq $t2, $zero, atoi_end
	blt $t2, $t4, atoi_error
	bgt $t2, $t5, atoi_error
	addi $t2, $t2, -48
	mul $t1, $t1, $t3
	add $t1, $t1, $t2
	addi $t0, $t0, 1
	b atoi_loop
atoi_error:
	li $v0, 10
	syscall
atoi_end:
	move $v0, $t1
	jr $ra
.data
__next:
	.word 0
__begin:
	.word 0
__end:
	.word 0
arg:
	.word 0
_type_arg:
	.word 0
