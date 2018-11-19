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
	addi $sp, $sp, 24
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	move $t1, $t9
	move $t0, $t8
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	move $t1, $t9
	move $t0, $t8
	move $t2, $t0
	move $t3, $t1
#end
	addi $sp, $sp, 8
#startf
	li $t0, 3
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#startf
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
	move $t1, $t9
	move $t0, $t8
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
	move $t8, $t0
	move $t9, $t1
#endf
#start
	move $t1, $t9
	move $t0, $t8
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	move $s0, $t0
	move $s1, $t1
	move $t1, $t9
	move $t0, $t8
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
	b _label_45
_label_44:
#startf
	li $t0, 3
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#startf
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
	move $t1, $t9
	move $t0, $t8
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
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
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
	move $s0, $t0
	move $s1, $t1
	move $t1, $t9
	move $t0, $t8
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
_label_47:
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#startf
	move $t1, $t9
	move $t0, $t8
	move $s2, $t0
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t1, $s2
	add $t0, $t1, $t0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	move $s0, $t0
	move $s1, $t1
	move $t1, $t9
	move $t0, $t8
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
_label_45:
#start
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t8, $t0
	move $t9, $t1
#end
#startf
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	li $t0, 3
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#startf
	move $t1, $t9
	move $t0, $t8
	move $s2, $t0
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t1, $s2
	slt $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t8, $t0
	move $t9, $t1
#endf
	move $t1, $t9
	move $t0, $t8
	bltz $t0, _label_44
_label_46:
	subi $sp, $sp, 8
	addi $sp, $sp, 8
	b _label_39
_label_38:
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	move $s0, $t0
	move $s1, $t1
	move $t1, $t9
	move $t0, $t8
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t8, $t0
	move $t9, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#startf
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	li $t0, 3
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#startf
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
	move $t1, $s2
	div $t0, $t1, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	addi $t0, $fp, 32
	addi $t1, $fp, 36
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#startf
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	li $t0, 3
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#startf
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
	move $t1, $s2
	rem $t0, $t1, $t0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#start
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
	move $s0, $t0
	move $s1, $t1
	move $t1, $t9
	move $t0, $t8
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $t5
	move $t0, $t4
	move $t8, $t0
	move $t9, $t1
#end
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
	move $t1, $t9
	move $t0, $t8
	move $a0, $t0
	move $a1, $t1
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
#start
	move $t1, $t5
	move $t0, $t4
	move $t8, $t0
	move $t9, $t1
#end
#startf
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
	move $t1, $t9
	move $t0, $t8
	move $a0, $t0
	move $a1, $t1
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
	move $t0, $v0
	move $t1, $v1
	move $t8, $t0
	move $t9, $t1
#endf
	move $t1, $t9
	move $t0, $t8
	bltz $t0, _label_41
	b _label_42
_label_41:
#start
	move $t1, $t3
	move $t0, $t2
	move $t8, $t0
	move $t9, $t1
#end
#start
	move $t1, $t9
	move $t0, $t8
	move $t6, $t0
	move $t7, $t1
#end
	b _label_43
_label_42:
#startf
	li $t0, 3
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t3
	move $t0, $t2
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#startf
	move $t1, $t9
	move $t0, $t8
	move $s2, $t0
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t1, $s2
	sub $t0, $t1, $t0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
	move $t1, $t9
	move $t0, $t8
	move $t2, $t0
	move $t3, $t1
#end
_label_43:
_label_39:
#start
	move $t1, $t7
	move $t0, $t6
	move $t8, $t0
	move $t9, $t1
#end
#startf
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	li $t0, 0
	li $t1, 0
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#endf
#startf
	move $t1, $t9
	move $t0, $t8
	move $s2, $t0
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t1, $s2
	seq $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t8, $t0
	move $t9, $t1
#endf
	move $t1, $t9
	move $t0, $t8
	bltz $t0, _label_38
_label_40:
	subi $sp, $sp, 8
#start
	move $t1, $t7
	move $t0, $t6
	move $t8, $t0
	move $t9, $t1
#end
	subi $sp, $sp, 24
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t9
	move $t0, $t8
	move $a0, $t0
	move $a1, $t1
	b print_int_int
	subi $sp, $sp, 24
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
#startf
	li $t0, 0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	move $t2, $t0
	move $t3, $t1
#end
	b _label_35
_label_34:
#startf
	li $t0, 45
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
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
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
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
_label_37:
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#startf
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
#endf
#start
	move $t1, $t5
	move $t0, $t4
	move $t2, $t0
	move $t3, $t1
#end
_label_35:
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 5
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#startf
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
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_34
_label_36:
#startf
	li $t0, 13
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
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
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 10
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t5
	move $t0, $t4
	move $a0, $t0
	move $a1, $t1
	b print_int
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_line_array_of_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 124
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 124
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 13
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 10
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
	b print_int
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_aux_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#startf
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	seq $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
	move $t1, $t3
	move $t0, $t2
	bltz $t0, _label_28
	b _label_29
_label_28:
#startf
	li $t0, 88
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
	b _label_30
_label_29:
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#startf
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	seq $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
	move $t1, $t3
	move $t0, $t2
	bltz $t0, _label_31
	b _label_32
_label_31:
#startf
	li $t0, 79
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
	b _label_33
_label_32:
#startf
	li $t0, 32
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
_label_33:
_label_30:
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
display_array_of_array_of_int:
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $sp, $sp, 8
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 13
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
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
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
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
#startf
	li $t0, 10
	li $t1, 0
	move $t2, $t0
	move $t3, $t1
#endf
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $t1, $t3
	move $t0, $t2
	move $a0, $t0
	move $a1, $t1
	b print_int
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
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_4
	b _label_5
_label_4:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_6
_label_5:
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_7
	b _label_8
_label_7:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_9
_label_8:
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_10
	b _label_11
_label_10:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_12
_label_11:
#startf
	li $t0, 3
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#startf
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
#endf
#start
	move $t1, $t5
	move $t0, $t4
	move $t2, $t0
	move $t3, $t1
#end
	addi $sp, $sp, 24
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
	subi $sp, $sp, 24
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_25
	b _label_26
_label_25:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_27
_label_26:
_label_27:
	addi $sp, $sp, 24
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
	subi $sp, $sp, 24
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_22
	b _label_23
_label_22:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_24
_label_23:
_label_24:
	addi $sp, $sp, 24
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
	subi $sp, $sp, 24
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_19
	b _label_20
_label_19:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_21
_label_20:
_label_21:
	addi $sp, $sp, 24
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
	subi $sp, $sp, 24
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_16
	b _label_17
_label_16:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_18
_label_17:
_label_18:
	addi $sp, $sp, 24
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	move $s0, $t0
	move $s1, $t1
	move $t1, $t5
	move $t0, $t4
	sw $t0, 0($s0)
	sw $t1, 0($s1)
#end
#start
	addi $t0, $fp, 8
	addi $t1, $fp, 12
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 16
	addi $t1, $fp, 20
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
#start
	addi $t0, $fp, 24
	addi $t1, $fp, 28
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $t3
	move $t0, $t2
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
#end
	subi $sp, $sp, 24
#start
	move $t1, $t3
	move $t0, $t2
	move $t4, $t0
	move $t5, $t1
#end
#startf
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
	move $t0, $v0
	move $t1, $v1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	bltz $t0, _label_13
	b _label_14
_label_13:
#startf
	li $t0, -1
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
	move $v0, $t0
	move $v1, $t1
	subi $sp, $sp, 8
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	jr $ra
	b _label_15
_label_14:
_label_15:
_label_12:
_label_9:
_label_6:
#startf
	li $t0, 0
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
	move $t1, $t5
	move $t0, $t4
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
check_line_array_of_int:
#start
	move $t1, $a1
	move $t0, $a0
	move $t2, $t0
	move $t3, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t4, $t0
	move $t5, $t1
#endf
#start
	move $t1, $t5
	move $t0, $t4
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t3
	move $t0, $t2
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t3
	move $t0, $t2
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t2, $t0
	move $t3, $t1
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	seq $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 1
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#start
	move $t1, $a1
	move $t0, $a0
	move $t6, $t0
	move $t7, $t1
#end
#startf
	li $t0, 2
	li $t1, 0
	move $t8, $t0
	move $t9, $t1
#endf
#start
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
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t6, $t0
	move $t7, $t1
#end
#startf
	move $t1, $t5
	move $t0, $t4
	move $s2, $t0
	move $t1, $t7
	move $t0, $t6
	move $t1, $s2
	seq $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
#startf
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	and $t0, $t1, $t0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
#start
	move $t1, $a1
	move $t0, $a0
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#start
	move $t1, $t7
	move $t0, $t6
	bltz $t0, atoi_error
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	move $t1, $t5
	move $t0, $t4
	lw $t0, -4($t0)
	srl $t0, $t0, 16
	lw $t1, -8($sp)
	bge $t1, $t0, atoi_error
	move $t1, $t5
	move $t0, $t4
	subi $sp, $sp, 8
	lw $t1, 0($sp)
	li $s3, 8
	mul $t1, $t1, $s3
	add $t0, $t0, $t1
	addi $t1, $t0, 4
	lw $t1, 0($t1)
	lw $t0, 0($t0)
	move $t4, $t0
	move $t5, $t1
#end
#startf
	li $t0, 0
	li $t1, 0
	move $t6, $t0
	move $t7, $t1
#endf
#startf
	move $t1, $t5
	move $t0, $t4
	move $s2, $t0
	move $t1, $t7
	move $t0, $t6
	move $t1, $s2
	sne $t0, $t1, $t0
	neg $t0, $t0
	li $t1, -1
	move $t4, $t0
	move $t5, $t1
#endf
#startf
	move $t1, $t3
	move $t0, $t2
	move $s2, $t0
	move $t1, $t5
	move $t0, $t4
	move $t1, $s2
	and $t0, $t1, $t0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
	move $t1, $t3
	move $t0, $t2
	bltz $t0, _label_1
	b _label_2
_label_1:
#startf
	li $t0, -1
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
	move $t1, $t3
	move $t0, $t2
	move $v0, $t0
	move $v1, $t1
	jr $ra
	b _label_3
_label_2:
#startf
	li $t0, 0
	li $t1, -1
	move $t2, $t0
	move $t3, $t1
#endf
	move $t1, $t3
	move $t0, $t2
	move $v0, $t0
	move $v1, $t1
	jr $ra
_label_3:
	jr $ra
logic_equality:
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
