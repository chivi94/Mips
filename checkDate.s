      .data
fech: .asciiz "02/02/10"
      .text


main: la $a0, fech
      jal checkDate
      add $a0, $zero, $v0
      li $v0, 1
      syscall
      li $v0, 10
      syscall

#Funcion que comprueba si una fecha ha sido introducida correctamente.
#Parametros en $a0 -> Fecha introducida por el usuario(direccion)
#Resultado en $v0 -> Devuelve -1 si hay algo mal en la fecha, 0 en caso contrario.
.Codigo de error-> -1. 0 Si ha ido todo bien
checkDate:
                    add $t0, $zero, $a0
                    addi $t1,$zero, 48 #Numero 0 en ascii
                    addi $t2, $zero, 57#Numero 9 en ascii
                    addi $t3, $zero, 47 #/ en ascii
                    add $t4, $zero, $zero #Contador para recorrer la cadena
                    add $t5, $zero, $zero
      LoopCheckDate:beq $t4, 10, exitCheckDate
                    lb $t5, 0($t0)
                    beq $t4, 2, Barra#Posiciones donde debe estar el separador dd/mm/aaaa
                    beq $t4, 5, Barra
                    blt $t5, $t1, Erronea
                    blt $t2, $t5, Erronea
      ContinueCheckDate:addi $t0, $t0, 1
                        addi $t4, $t4, 1
                        j LoopCheckDate
            Barra: beq $t5, $t3, ContinueCheckDate

            Erronea: addi $v0, $zero, 1
                     jr $ra
      exitCheckDate: add $v0, $zero, $zero
                     jr $ra
