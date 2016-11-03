.data
n:	.asciiz "El numero es negativo"
p:	.asciiz "El numero es positivo"
.text

main:addi $t0, $t0, -51
   srl $t0, $t0, 31
   bne $t0, $zero, jump
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
