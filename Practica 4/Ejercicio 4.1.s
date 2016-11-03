.data
cadena:  .asciiz "1002f001"
resultado: .space 32
.text

main:la $a0, cadena
     jal Funcion

     la $a0, resultado
     li $v0, 1
     syscall

     la $v0, 10
     syscall


Funcion:add $t0, $zero, $a0             #Parametro(=registro) direccion que contiene la cadena a convertir
        li $t1, 8                       #Contador para el bucle
        la $t3, resultado
        addi $t5, $zero, 97
      Loop:
        beq $t1, $zero, Continuar       #Si el contador llega a 0, finaliza la ejecucion del procedimiento
        rol $t0, $t0, 4                 #Rotamos 4 bits a la izquierda
        and $t4, $t0, 0xf                #Mascara con F(=1111)
        blt $t5, $t4, Resta
        addi $t4, $t4, -48
        add $a0, $zero, $t4
        li $v0, 1
        syscall
        b Guarda
      Resta:
      addi $t4, $t4, -87
      Guarda:
        sb $t4, 0($t3)                  #Guarda el digito hexadecimal en la cadena
        addi $t3, $t3, 1                #Incrementa el contador de direccion
        addi $t1, $t1, -1               #Disminuimos el contador que gobierna el bucle
      b Loop                          #Salto al inicio del bucle
      Continuar:  jr $ra                #Fin del procedimiento
