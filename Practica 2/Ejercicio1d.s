.data
a:	.float 5.3
n:	.asciiz "El numero es negativo"
p:	.asciiz "El numero es positivo"
.text

main:lwc1 $f0, a
   mfc1 $s0, $f0
	 srl $s0, $s0,31
   bne $s0, $zero, jump
   la $a0, p
   li $v0, 4
   syscall
   li $v0, 10
   syscall

jump: la $a0, n
    li $v0, 4
    syscall
    li $v0, 10
    syscall
