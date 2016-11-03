#Autores: Raúl Rodríguez Carracedo, Iván González Rincón
#Grupo: 1
#Practica 6. Ejercicio:4
.data

msg1:      .asciiz "Introduzca numero:"
msg2:     .asciiz "Introduzca segundo numero:"
err1:     .asciiz "Caracter incorrecto. Ha introducido alguna letra o algo distinto a un número [0-9]"
res:      .asciiz "Resultado:"
opc:	  .asciiz "Codigo de error:"
salto:    .asciiz "\n"
num1:	  .space 100
num2:	  .space 100
.text
main:  addi $s1, $zero, 1
       la $a0, msg1
       li $v0, 4          
       syscall									#Mensaje de petición.
          
       la $a0, num1
       li $a1, 11
       li $v0, 8	
       syscall									#Petición de cadena de texto de tamaño = 8.    
       jal decToBin
       
     
       beq $v0, $s1, caracter_incorrecto					#Si el código de error es 1, el carácter es incorrecto
       add $t4, $zero, $v0
       add $t9, $zero, $v1  
     
       la $a0, msg2
       li $v0, 4          
       syscall									#Mensaje de petición.
       
       la $a0, num2
       li $a1, 11
       li $v0, 8	
       syscall	
       jal decToBin
       beq $v0, $s1, caracter_incorrecto					#Si el código de error es 1, el carácter es incorrecto
       add $t6, $zero, $v0
       add $s2, $zero, $v1
       
       
    
       la $a0, res
       li $v0, 4
       syscall
       add $a0, $t9, $s2
       li $v0, 1
       syscall
       li $v0, 10
       syscall
       
caracter_incorrecto:add $a0, $v1, $zero
       		    li $v0, 4          
       		    syscall									
       		    li $v0, 10
       		    syscall
       
decToBin:	add $t0, $zero, $a0
		addi $t3, $zero, 10
		addi $t5, $zero, 45			#Si el número es negativo, el primer carácter es un guión
		addi $t7, $zero, 48			#Ascii correspondiente al 0
          	addi $t8, $zero, 57			#Ascii correspondiente al 9
          	add $v1, $zero, $zero
	 	add $v0, $zero, $zero
	 	lb  $t1, 0($t0)
	 	beq $t1, $t5, negDecToBin		#Pasamos a hacer el complemento a 2
Loop:		lb  $t1, 0($t0)	                        
		beq $t1, $t3, seguir
		blt $t1, $t7, wrong			#if $t1 < 0 (48 en ascii), es un carácter incorrecto
		blt $t8, $t1, wrong			#if 9(57 en  ascii) < $t1, es un carácter incorrecto
seguir:		beq $t1, $zero, fin	
	 	beq $t1, $t3, fin			#Si llegamos a fin de cadena, termina
	 	mul $v1, $v1, $t3
	 	addi $t1, $t1, -48			#Valor en ASCII del número	 	
	 	add $v1, $v1, $t1
		addi $t0, $t0, 1
		j Loop
negDecToBin:	addi $t0, $t0, 1
		lb  $t1, 0($t0)	 
		beq $t1, $zero, fin_n	
	 	beq $t1, $t3, fin_n			#Si llegamos a fin de cadena, termina
	 	mul $v1, $v1, $t3
	 	addi $t1, $t1, -48			#Valor en ASCII del número	 	
	 	add $v1, $v1, $t1
		j negDecToBin
	fin_n:	nor $v1, $zero, $v1
		addi $v1, $v1, 1
	fin:	jr $ra
	
wrong:		addi $v0, $zero, 1
           	la $v1, err1
           	jr $ra
