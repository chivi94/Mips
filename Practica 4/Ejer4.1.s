.data

dato:		.asciiz "7a3f54cd"

.text
main:		la $a0, dato
  jal funcion
  add $a0, $zero, $s1
  li $v0, 1
  syscall
  li $v0, 10
  syscall


funcion:	add $s0, $zero, $a0
  addi $t1, $zero, 97
bucle:		lb $t0, 0($s0)
  beq $t0, $zero, final
  sll $s1, $s1, 4
  blt $t0, $t1, numero
letra:		addi $t0, $t0, 	-87
guardar:	add $s1, $t0, $s1
  addi $s0, $s0, 1
  j bucle
final:		jr $ra
numero:		addi $t0, $t0,	-48
  j guardar
