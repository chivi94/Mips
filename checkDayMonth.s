.data

.text

main:
      addi $a0, $zero, 29
      addi $a1, $zero, 2#Mes
      addi $a2, $zero, 2013
      jal checkDayNumber
      add $a0, $zero, $v0
        li $v0, 1
      syscall
      li $v0, 10
      syscall



#Comprobara si el numero de mes introducido es o no correcto
#Argumentos-> $a0, Mes
#Resultado-> $v0 = -1 si el mes es menor a 1 o mayor a 12, 0 en caso contrario
checkMonthNumber:
                add $t5,$zero,$a0
                addi $t6, $zero, 12
                blt $t5, 1, wrongMonth
                blt $t6, $t5, wrongMonth
                add $v0, $zero, $zero
                j exitCMN
    wrongMonth: addi $v0, $zero, -1
    exitCMN:    jr $ra
#Comprobara si el numero de dia introducido es o no correcto. Debera comprobarlo en funcion del mes pasado como parametro
#Argumentos-> $a0, Dia; $a1, Mes; $a2, Año(Para febrero, y por si es o no bisiesto)
#Resultado -> $v0, 0 si los dias son correctos, -1 si no lo son
checkDayNumber:	
        add $t9, $zero, $ra #Apuntador de la función
        add $t7,$a0, $zero
        add $a0, $zero, $a2
        jal leanOrNotLean
        add $t1, $zero, $t7 #dias 
        add $t2, $zero, $a1 #mes
        add $t3, $zero, $a2 #año
        add $t8, $zero, $v0 #Resultado de la funcion de bisiest
        add $a0, $zero, $a1
        jal checkMonthNumber
        beq $v0, -1, exitCDN

        addi $t0, $zero, 31
        addi $t4, $zero, 30
        addi $t5, $zero, 28
        addi $t6, $zero, 29       
        beq $t2, 1, Grande
        beq $t2, 2, Feb
        beq $t2, 3, Grande
        beq $t2, 4, Pequenio
        beq $t2, 5, Grande
        beq $t2, 6, Pequenio
        beq $t2, 7, Grande
        beq $t2, 8, Grande
        beq $t2, 9, Pequenio
        beq $t2, 10, Grande
        beq $t2, 11, Pequenio
        beq $t2, 12, Grande
 Grande: blt $t1, 1, wrongDay
        blt $t0, $t1, wrongDay
        add $v0, $zero, $zero
        b exitCDN
 Pequenio:  blt $t1, 1, wrongDay
        blt $t4, $t1, wrongDay
        add $v0, $zero, $zero
        b exitCDN
 Feb:    blt $t1, 1, wrongDay #Si no, no es bisiesto
 	 beq $t8, -1, lean #Si la función devuelve -1, es bisiesto
         blt $t5, $t1, wrongDay
         b exitCDN
    lean:blt $t6, $t1, wrongDay
	 b exitCDN
  wrongDay:
  	
  	addi $v0, $zero, -1

  exitCDN:
        add $ra, $t9, $zero
        jr $ra