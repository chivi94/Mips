.data
f: .double 4.40625
.text
main:
	lw $a0, f
	li $v0,1
	syscall
	li $v0, 10
	syscall