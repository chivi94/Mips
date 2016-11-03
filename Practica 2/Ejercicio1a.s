	.data
little:	.asciiz "El procesador es little-endian"
big:	  .asciiz "El procesador es big-endian"
	.text

main:addi $t0, $t0, 1
		 sll $t0, $t0, 2
		 bne $t0, $zero, jump
		 la $a0, big
		 li $v0, 4
		 syscall
		 li $v0, 10
		 syscall

jump: la $a0, little
 			li $v0, 4
 			syscall
 			li $v0, 10
 			syscall
