.data
a:	.space 64
.text

main:   la    $s0, a
        la    $t0, 0($s0)

        addi  $t1, $zero, 0      #Contador 1
        addi  $t2, $zero, 0      #Contador 2
        addi  $t3, $zero, 10     #Guardar 10
        addi  $t5, $zero, 4      #Guardar 4

Bucle1: addi  $t1, $t1, 1
        mul   $t4, $t1, $t3

Bucle2: addi  $t2, $t2, 1
        add   $t6, $t4, $t2   #Suma para poner el valor de la posicion
        sw    $t6, 0($t0)     #Cargamos en memoria el valor
        add   $a0, $t6, $zero
        li    $v0, 1
        syscall
        addi  $t0, $t0, 4     #Desplazamos posicion
        bne   $t2, $t5, Bucle2

        addi  $t2, $zero, 0
        bne   $t1, $t5, Bucle1

        li    $v0, 10
        syscall
