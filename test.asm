.text
	beqz $a0, init_end
	lw $a0, 0($a1)
	jal atoi
	move $s7, $v0
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
	move $a0, $s7
	li $a1, 0
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
main_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#start
	li $t0, -1
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#end
	move $t1, $t3
	move $t0, $t2
	bltz $t0, _label_1
	b _label_2
_label_1:
#start
	li $t0, 2
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#end
#start
	la $t0, i
	addi $t1, $t0, 4
	move $s0, $t0
	move $s1, $t1
	move $t1, $t3
	move $t0, $t2
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
	b _label_3
_label_2:
#start
	li $t0, 3
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#end
#start
	la $t0, i
	addi $t1, $t0, 4
	move $s0, $t0
	move $s1, $t1
	move $t1, $t3
	move $t0, $t2
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
_label_3:
#start
	la $t0, i
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
	b print_int_int
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
j:
	.word 0
_type_j:
	.word 0
i:
	.word 0
_type_i:
	.word 0
arg:
	.word 0
_type_arg:
	.word 0
