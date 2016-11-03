.data
      f: .word 45
      G: .word 10 24 55 67 89 90 110
      H: .space 100

.text
main: la $s0, f
      lw $t0, 0($s0)                # $t0 <- 45 (f[0])
      la $s1, G                     # $s1 <- G
      la $s2, H                     # $s2 <- H
      addi $t1, $zero, 7            # $t1 <- 7, Contador para controlar el bucle
      la $t4, 0($s1)                # $t4 <- 0($s1)
      la $t5, 0($s2)                # $t5 <- 0($s2)

loop: addi $t1, $t1, -1             # $t1-- Disminuimos el contador
      lw $t2, 0($t4)                # $t2 <- G[i] Se ira desplazando
      add $t3, $t2, $t0             # $t3 <- G[i] + f(=45)
      sw $t3, 0($t5)                # H[i] <- $t3
      addi $t4, $t4, 4              # G[i+1] Desplazamiento del array G
      addi $t5, $t5, 4              # H[i+1] Desplazamiento del array H
      bne $t1, $zero, loop          # Condicion de finalizacion del bucle

      addi $t1, $t1, 7              # $t1 <- 7, Contador para controlar el bucle

write:  addi $t1, $t1, -1           # $t1-- Disminuimos el contador
        la $t2, 0($s2)              # $t2 <- H[0]
        lw $a0, 0($t2)              # $a0 <- $t2
        li $v0, 1                   # print($a0)
        syscall
        addi $a0, $zero, 13         # $a0 <- 13
        li $v0, 11                  # print(\n)
        syscall
        addi $s2, $s2, 4            # H[i+1] Desplazamiento por el array
        bne $t1, $zero, write       # Condicion de finalizacion del bucle

        #el caracter de salto de linea es el 13

exit:   li $v0  10                  # Llamada a sistema para finalizar el programa.
        syscall
