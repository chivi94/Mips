.data
  .space 64
.text
main:addi $t0, $zero, 32767
     addi $t1, $zero, 2
     mult $t0, $t1
     la $v0, 10
     syscall
