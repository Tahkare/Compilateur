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
	move $t2, $zero
	li $t0, 0
	move $t3, $t0
	move $t4, $zero
	li $t0, 1
	move $t5, $t0
	move $t6, $zero
	li $t0, 0
	move $t7, $t0
	addi $sp, $sp, 32
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	move $t6, $t8
	move $t7, $t9
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	move $t2, $t8
	move $t3, $t9
	addi $sp, $sp, 8
#FlatSetStart
	li $t8, 3
	li $t9, 0
#FlatSetEnd
#FlatSetStart
	li $v0, 9
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $t0, $t8
	li $t1, 8
	mul $a0, $t0, $t1
	addi $a0, $a0, 4
	syscall
	addi $t1, $v0, 4
	sll $t0, $t0, 16
	addi $t0, $t0, 0
	sw $t0, -4($t1)
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t8, $t1
	li $t9, 1
#FlatSetEnd
#SetStart
	move $t4, $t8
	move $t5, $t9
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	sw $t8, 0($t0)
	sw $t9, 0($t1)
	b _label_42
_label_41:
#FlatSetStart
	li $t8, 3
	li $t9, 0
#FlatSetEnd
#FlatSetStart
	li $v0, 9
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $t0, $t8
	li $t1, 8
	mul $a0, $t0, $t1
	addi $a0, $a0, 4
	syscall
	addi $t1, $v0, 4
	sll $t0, $t0, 16
	addi $t0, $t0, 0
	sw $t0, -4($t1)
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t8, $t1
	li $t9, 1
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#SetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	sw $t8, 0($t0)
	sw $t9, 0($t1)
_label_44:
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	add $t8, $t8, $t0
	li $t9, 0
#FlatSetEnd
#SetStart
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	sw $t8, 0($t0)
	sw $t9, 0($t1)
_label_42:
#SetStart
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t8, $t0
	move $t9, $t1
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	li $s0, 3
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	slt $t8, $t8, $t0
	neg $t8, $t8
	li $t9, -1
#FlatSetEnd
	bltz $t8, _label_41
_label_43:
	subi $sp, $sp, 8
	addi $sp, $sp, 8
	b _label_33
_label_32:
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	jal scan_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t8, $v0
	move $t9, $v1
#FlatSetEnd
#SetStart
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	sw $t8, 0($t0)
	sw $t9, 0($t1)
#SetStart
	move $t8, $t4
	move $t9, $t5
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	li $s0, 2
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	li $s0, 1
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	li $s0, 3
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	div $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t8
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t8, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t8, $t0
	move $t9, $t1
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	li $s0, 1
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	li $s0, 3
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	rem $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t8
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t8, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t8, $t0
	move $t9, $t1
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	li $s0, 0
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	seq $t8, $t8, $t0
	neg $t8, $t8
	li $t9, -1
#FlatSetEnd
	bltz $t8, _label_35
	b _label_36
_label_35:
#SetStart
	move $t8, $t2
	move $t9, $t3
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	li $s0, 2
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#FlatSetStart
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	li $s0, 1
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	li $s0, 3
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	div $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#SetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 40
	addi $t1, $fp, 44
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#SetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	li $s0, 1
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	li $s0, 3
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $s2, $t0
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	rem $t0, $s2, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#FlatSetEnd
#SetStart
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	sw $t8, 0($t0)
	sw $t9, 0($t1)
#SetStart
	move $t8, $t4
	move $t9, $t5
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t8
	move $a1, $t9
	jal display_array_of_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#SetStart
	move $t8, $t4
	move $t9, $t5
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t8
	move $a1, $t9
	jal check_win_array_of_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t8, $v0
	move $t9, $v1
#FlatSetEnd
	bltz $t8, _label_38
	b _label_39
_label_38:
#SetStart
	move $t8, $t2
	move $t9, $t3
#SetStart
	move $t6, $t8
	move $t7, $t9
	b _label_40
_label_39:
#FlatSetStart
	li $t8, 3
	li $t9, 0
#FlatSetEnd
#SetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	sw $t2, 0($t0)
	sw $t3, 0($t1)
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sub $t8, $t8, $t0
	li $t9, 0
#FlatSetEnd
#SetStart
	move $t2, $t8
	move $t3, $t9
_label_40:
	b _label_37
_label_36:
_label_37:
_label_33:
#SetStart
	move $t8, $t6
	move $t9, $t7
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	li $s0, 0
	li $s1, 0
	sw $s0, 0($t0)
	sw $s1, 0($t1)
#FlatSetEnd
#FlatSetStart
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	seq $t8, $t8, $t0
	neg $t8, $t8
	li $t9, -1
#FlatSetEnd
	bltz $t8, _label_32
_label_34:
	subi $sp, $sp, 8
#SetStart
	move $t8, $t6
	move $t9, $t7
	subi $sp, $sp, 32
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $a0, $t8
	move $a1, $t9
	b print_int_int
	subi $sp, $sp, 32
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_separator:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
	move $t2, $zero
	li $t0, 0
	move $t3, $t0
#FlatSetStart
	li $t4, 0
	li $t5, 0
#FlatSetEnd
#SetStart
	move $t2, $t4
	move $t3, $t5
	b _label_29
_label_28:
#FlatSetStart
	li $t4, 45
	li $t5, 0
#FlatSetEnd
	sw $fp, 0($sp)
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
	move $fp, $sp
	move $a0, $t4
	move $a1, $t5
	jal print_int
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
	lw $fp, 0($sp)
_label_31:
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#FlatSetStart
	add $t4, $t4, $t6
	li $t5, 0
#FlatSetEnd
#SetStart
	move $t2, $t4
	move $t3, $t5
_label_29:
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	li $t6, 5
	li $t7, 0
#FlatSetEnd
#FlatSetStart
	slt $t4, $t4, $t6
	neg $t4, $t4
	li $t5, -1
#FlatSetEnd
	bltz $t4, _label_28
_label_30:
#FlatSetStart
	li $t4, 13
	li $t5, 0
#FlatSetEnd
	sw $fp, 0($sp)
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
	move $fp, $sp
	move $a0, $t4
	move $a1, $t5
	jal print_int
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
	lw $fp, 0($sp)
#FlatSetStart
	li $t4, 10
	li $t5, 0
#FlatSetEnd
	sw $fp, 0($sp)
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
	move $fp, $sp
	move $a0, $t4
	move $a1, $t5
	jal print_int
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
	lw $fp, 0($sp)
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_line_array_of_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 0
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_aux_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 124
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 1
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_aux_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 124
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 2
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_aux_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 13
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 10
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_aux_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 1
	li $t5, 0
#FlatSetEnd
#FlatSetStart
	seq $t2, $t2, $t4
	neg $t2, $t2
	li $t3, -1
#FlatSetEnd
	bltz $t2, _label_22
	b _label_23
_label_22:
#FlatSetStart
	li $t2, 88
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	b _label_24
_label_23:
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 2
	li $t5, 0
#FlatSetEnd
#FlatSetStart
	seq $t2, $t2, $t4
	neg $t2, $t2
	li $t3, -1
#FlatSetEnd
	bltz $t2, _label_25
	b _label_26
_label_25:
#FlatSetStart
	li $t2, 79
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	b _label_27
_label_26:
#FlatSetStart
	li $t2, 32
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
_label_27:
_label_24:
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_array_of_array_of_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 0
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_line_array_of_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	jal display_separator
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 1
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_line_array_of_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	jal display_separator
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 2
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal display_line_array_of_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 13
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
#FlatSetStart
	li $t2, 10
	li $t3, 0
#FlatSetEnd
	sw $fp, 0($sp)
	addi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	addi $sp, $sp, 8
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	addi $sp, $sp, 8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	addi $sp, $sp, 8
	move $fp, $sp
	move $a0, $t2
	move $a1, $t3
	jal print_int
	subi $sp, $sp, 8
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	subi $sp, $sp, 8
	lw $t2, 0($sp)
	lw $t3, 4($sp)
	subi $sp, $sp, 8
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
check_win_array_of_array_of_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
	move $t2, $zero
	li $t0, 1
	move $t3, $t0
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
#SetStart
	move $t6, $a0
	move $t7, $a1
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t6, $t0
	move $t7, $t1
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t6
	move $a1, $t7
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t6, $v0
	move $t7, $v1
#FlatSetEnd
#FlatSetStart
	or $t4, $t4, $t6
	li $t5, -1
#FlatSetEnd
#SetStart
	move $t6, $a0
	move $t7, $a1
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t6, $t0
	move $t7, $t1
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t6
	move $a1, $t7
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t6, $v0
	move $t7, $v1
#FlatSetEnd
#FlatSetStart
	or $t4, $t4, $t6
	li $t5, -1
#FlatSetEnd
	bltz $t4, _label_4
	b _label_5
_label_4:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_5:
#FlatSetStart
	li $t4, 3
	li $t5, 0
#FlatSetEnd
#FlatSetStart
	li $v0, 9
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $t0, $t4
	li $t1, 8
	mul $a0, $t0, $t1
	addi $a0, $a0, 4
	syscall
	addi $t1, $v0, 4
	sll $t0, $t0, 16
	addi $t0, $t0, 0
	sw $t0, -4($t1)
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $t1
	li $t5, 1
#FlatSetEnd
#SetStart
	move $t2, $t4
	move $t3, $t5
	addi $sp, $sp, 24
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	subi $sp, $sp, 24
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
	bltz $t4, _label_19
	b _label_20
_label_19:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_20:
_label_21:
	addi $sp, $sp, 24
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	subi $sp, $sp, 24
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
	bltz $t4, _label_16
	b _label_17
_label_16:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_17:
_label_18:
	addi $sp, $sp, 24
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	subi $sp, $sp, 24
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
	bltz $t4, _label_13
	b _label_14
_label_13:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_14:
_label_15:
	addi $sp, $sp, 24
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	subi $sp, $sp, 24
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
	bltz $t4, _label_10
	b _label_11
_label_10:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_11:
_label_12:
	addi $sp, $sp, 24
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 0
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 1
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 2
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $t2
	move $t7, $t3
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	subi $sp, $sp, 24
#SetStart
	move $t4, $t2
	move $t5, $t3
#FlatSetStart
	sw $fp, 0($sp)
	addi $sp, $sp, 8
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
	move $a0, $t4
	move $a1, $t5
	jal check_line_array_of_int
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
	subi $sp, $sp, 8
	lw $fp, 0($sp)
	move $t4, $v0
	move $t5, $v1
#FlatSetEnd
	bltz $t4, _label_7
	b _label_8
_label_7:
#FlatSetStart
	li $t4, -1
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
_label_8:
_label_9:
_label_6:
#FlatSetStart
	li $t4, 0
	li $t5, -1
#FlatSetEnd
	move $v0, $t4
	move $v1, $t5
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
check_line_array_of_int:
#SetStart
	move $t2, $a0
	move $t3, $a1
#FlatSetStart
	li $t4, 0
	li $t5, 0
#FlatSetEnd
#SetStart
	bltz $t4, atoi_error
	sw $t4, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t2, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	seq $t2, $t2, $t4
	neg $t2, $t2
	li $t3, -1
#FlatSetEnd
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 1
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#SetStart
	move $t6, $a0
	move $t7, $a1
#FlatSetStart
	li $t8, 2
	li $t9, 0
#FlatSetEnd
#SetStart
	bltz $t8, atoi_error
	sw $t8, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t6
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t6, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t6, $t0
	move $t7, $t1
#FlatSetStart
	seq $t4, $t4, $t6
	neg $t4, $t4
	li $t5, -1
#FlatSetEnd
#FlatSetStart
	and $t2, $t2, $t4
	li $t3, -1
#FlatSetEnd
#SetStart
	move $t4, $a0
	move $t5, $a1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#SetStart
	bltz $t6, atoi_error
	sw $t6, 0($sp)
	addi $sp, $sp, 8
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t4, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#FlatSetStart
	li $t6, 0
	li $t7, 0
#FlatSetEnd
#FlatSetStart
	sne $t4, $t4, $t6
	neg $t4, $t4
	li $t5, -1
#FlatSetEnd
#FlatSetStart
	and $t2, $t2, $t4
	li $t3, -1
#FlatSetEnd
	bltz $t2, _label_1
	b _label_2
_label_1:
#FlatSetStart
	li $t2, -1
	li $t3, -1
#FlatSetEnd
	move $v0, $t2
	move $v1, $t3
	jr $ra
_label_2:
#FlatSetStart
	li $t2, 0
	li $t3, -1
#FlatSetEnd
	move $v0, $t2
	move $v1, $t3
	jr $ra
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
