#Autores: Raúl Rodríguez Carracedo, Iván González Rincón
#Grupo: 1
#Practica 6. Ejercicio:
.data

msg1:      .asciiz "Introduzca numero:"
msg2:     .asciiz "Introduzca segundo numero:"
err1:     .asciiz "Caracter incorrecto."
res:      .asciiz "Resultado:"
opc:	  .asciiz "Codigo de error:"
salto:    .asciiz "\n"
num1:	  .space 100
num2:	  .space 100
.text
main:  la $a0, msg1
       li $v0, 4          
       syscall									#Mensaje de petición.
          
       la $a0, num1
       li $a1, 13
       li $v0, 8	
       syscall									#Petición de cadena de texto de tamaño = 8.    
       jal decToBin
       add $t4, $zero, $v0
       
       la $a0, msg2
       li $v0, 4          
       syscall									#Mensaje de petición.
       
       la $a0, num2
       li $a1, 13
       li $v0, 8	
       syscall	
       jal decToBin
       add $t6, $zero, $v0
       
    
       la $a0, res
       li $v0, 4
       syscall
       add $a0, $t4, $t6
       li $v0, 1
       syscall
       li $v0, 10
       syscall
       
       
decToBin:	add $t0, $zero, $a0
		addi $t3, $zero, 10
		addi $t5, $zero, 45			#Si el número es negativo, el primer carácter es un guión
	 	add $v0, $zero, $zero
	 	lb  $t1, 0($t0)
	 	beq $t1, $t5, negDecToBin		#Pasamos a hacer el complemento a 2
Loop:		lb  $t1, 0($t0)	 
		beq $t1, $zero, fin	
	 	beq $t1, $t3, fin			#Si llegamos a fin de cadena, termina
	 	mul $v0, $v0, $t3
	 	addi $t1, $t1, -48			#Valor en ASCII del número	 	
	 	add $v0, $v0, $t1
		addi $t0, $t0, 1
		j Loop
negDecToBin:	addi $t0, $t0, 1
		lb  $t1, 0($t0)	 
		beq $t1, $zero, fin_n	
	 	beq $t1, $t3, fin_n			#Si llegamos a fin de cadena, termina
	 	mul $v0, $v0, $t3
	 	addi $t1, $t1, -48			#Valor en ASCII del número	 	
	 	add $v0, $v0, $t1
		j negDecToBin
	fin_n:	nor $v0, $zero, $v0
		addi $v0, $v0, 1
	fin:	jr $ra