.data

buffer:		.space 8
msg:      .asciiz "Introduzca numero hexadecimal:"
err1:     .asciiz "Caracter incorrecto."
res:      .asciiz "Resultado de la operacion:"
opc:	  .asciiz "Codigo de error:"
salto:    .asciiz "\n"
.text
main:     la $a0, msg
          li $v0, 4
          syscall		#Mensaje de petición.
          la $a0, buffer
          li $a1, 9
          li $v0, 8	
          syscall		#Petición de cadena de texto de tamaño = 8.


          jal funcion		#Llamada a la función
          addi $t5, $zero, 1
          add $t6, $zero, $v0	#Almacenamos el restultado de la función en un registro temporal para no alterarlo con llamadas al sistema.
          beq $t6, $t5, cadena_incorrecta
          la $a0, salto
          li $v0, 4
          syscall		#Salto de linea
          sll $v1, $v1, 2
          la $a0, opc
          li $v0, 4
          syscall		
          add $a0, $zero, $t6	#Codigo de error
          li $v0, 1
          syscall
          la $a0, salto
          li $v0, 4
          syscall		#Salto de linea
          la $a0, res
          li $v0, 4
          syscall
          add $a0, $zero, $v1	#Resultado
          li $v0, 1
          syscall
          li $v0, 10
          syscall
cadena_incorrecta: la $a0, salto
          	   li $v0, 4
          	   syscall		#Salto de linea
          	   la $a0, opc
          	   li $v0, 4
         	   syscall		
          	   add $a0, $zero, $t6	#Codigo de error
          	   li $v0, 1
          	   syscall
          	   la $a0, salto
          	   li $v0, 4
          	   syscall		#Salto de linea
                   la $a0, res
          	   li $v0, 4
          	   syscall
                   add $a0, $zero, $v1
                   li $v0, 4
                   syscall
                   li $v0, 10
                   syscall

funcion:	add $s0, $zero, $a0		#Cadena introducida por el usuario
          	addi $t1, $zero, 97		
          	addi $t2, $zero, 48
          	addi $t3, $zero, 57
          	addi $t4, $zero, 102		#Para comprobaciones de rango. Caracter incorrecto --> c = caracter:
          					#If (c< 48) || (c> 57 && c<97) || (c > 102)
bucle:		lb $t0, 0($s0)
          	beq $t0, $zero, final
          	sll $s1, $s1, 4
          	
          	blt $t0, $t1, numero	#If $t0 < $t1 then goto label(=numero) --> Si el caracter en ASCII es menor que 97, entonces PUEDE ser un numero.
letra:	        blt $t4, $t0, incorrecto#If caracter > 102 then incorrecto.
		addi $t0, $t0, 	-87
guardar:	add $s1, $t0, $s1
          	addi $s0, $s0, 1
          	j bucle
incorrecto:	addi $v0, $zero, 1
            	la $v1, err1
            	jr $ra
final:		add $v0, $zero, $zero
		add $v1, $zero, $s1
		jr $ra

numero:		blt $t0, $t2, incorrecto #If caracter(en ASCII) < 48 = incorrecto.
          	blt $t3, $t0, incorrecto #If caracter > 57
		addi $t0, $t0,	-48
          	j guardar
