#Autores: Raúl Rodríguez Carracedo, Iván González Rincón
.data

buffer:		.space 8
msg:      .asciiz "Introduzca numero hexadecimal:"
err1:     .asciiz "Caracter incorrecto."
res:      .asciiz "Resultado de la operacion:"
opc:	  .asciiz "Codigo de error:"
salto:    .asciiz "\n"
cadena:   .space 8
.text
main:     la $a0, msg
          li $v0, 4
          syscall		#Mensaje de petición.
          la $a0, buffer
          li $a1, 9
          li $v0, 8	
          syscall		#Petición de cadena de texto de tamaño = 8.


          jal HexToDec		#Llamada a la función
          addi $t5, $zero, 1
          add $t6, $zero, $v0	#Almacenamos el restultado de la función en un registro temporal para no alterarlo con llamadas al sistema.
          beq $t6, $t5, cadena_incorrecta
          la $a0, salto
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
          nor $a0, $zero, $v1  #Resultado
          addi $a0, $a0, 1
          la $a1, cadena
          jal DecToHex
          la $a0, cadena
          li $v0, 4
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

HexToDec:	add $s0, $zero, $a0		#Cadena introducida por el usuario
          	addi $t1, $zero, 97		
          	addi $t2, $zero, 48
          	addi $t3, $zero, 57
          	addi $t4, $zero, 102		
          	addi $t7, $zero, 65
          	addi $t8, $zero, 70				
          					#Para comprobaciones de rango. Caracter incorrecto --> c = caracter:
          					#If (c< 48) || (c> 57 && c<97) || (c > 102) || (c>= 65 && c <= 70)
bucle:		lb $t0, 0($s0)
          	beq $t0, $zero, final
          	sll $s1, $s1, 4
          	
          	blt $t0, $t1, check	#If $t0 < $t1 then goto label(=numero) --> Si el caracter en ASCII es menor que 97, entonces puede ser un numero o una letra mayuscula.
lower_case:	blt $t4, $t0, incorrecto#If caracter > 102 then incorrecto.
		addi $t0, $t0, 	-87
guardar:	
		add $s1, $t0, $s1
          	addi $s0, $s0, 1
          	j bucle
incorrecto:	addi $v0, $zero, 1
            	la $v1, err1
            	jr $ra
final:		add $v0, $zero, $zero
		add $v1, $zero, $s1
		jr $ra

check:		blt $t7, $t0, seguir #If caracter > 65
seguir:		blt $t0, $t8, upper_case #Si es menor que 70, tenemos una mayúscula
		blt $t0, $t2, incorrecto #If caracter(en ASCII) < 48 = incorrecto.
          	blt $t3, $t0, incorrecto #If caracter > 57
		addi $t0, $t0,	-48
          	j guardar
upper_case:	addi $t0, $t0, -55
		j guardar

DecToHex:add $t2, $zero, $a0             #Parametro(=registro) que contiene el numero introducido por el usuario
        add $t3, $zero, $a1             #Parametro(=registro) que contiene la direccion donde se almacenara el resultado
        li $t0, 8                       #Contador para el bucle

      Loop:
        beq $t0, $zero, Continuar       #Si el contador llega a 0, finaliza la ejecucion del procedimiento
        rol $t2, $t2, 4                 #Rotamos 4 bits a la izquierda
        and $t4, $t2, 0xf               #Mascara con F(=1111)
        ble $t4, 9, Suma                #Si $t4 es menor o igual a 9, salta a Suma
        addi $t4, $t4, 55               #Si no se cumple lo anterior, suma 55
        b Guarda                        #Almacena el digito con el que estamos trabajando

        Suma:
          addi $t4, $t4, 48             #Suma 48 al digito con el que estamos trabajando

        Guarda:
          sb $t4, 0($t3)                #Guarda el digito hexadecimal en la cadena
          addi $t3, $t3, 1              #Incrementa el contador de direccion
          addi $t0, $t0, -1             #Disminuimos el contador que gobierna el bucle

        b Loop                          #Salto al inicio del bucle
      Continuar:  jr $ra                #Fin del procedimiento