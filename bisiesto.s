#$a0 recibe un número (año) y la funcion devuelve un -1 o un 0 en $v0 en función de si es o no bisiesto
.data
msg1:  .asciiz "Introduce un año:"

.text

main:   la $a0, msg1
		li $v0, 4
		syscall     #Peticion

		li $v0, 5
		syscall
		add $a0, ,$zero, $v0    #Entrada de datos
         
        jal check
        
        add $a0, $zero, $v0
        li $v0, 1
        syscall
        
        li $v0, 10
        syscall
         

check:   add $t0, $zero, $a0
			addi $t4, $zero, 4
			addi $t5, $zero, 100
			addi $t6, $zero, 400
			div $t0, $t4
			mfhi $t1			# Guardamos el primer resto
			div $t0, $t5
			mfhi $t2			# Guardamos el segundo resto
			div $t0, $t6
			mfhi $t3			# Guardamos el tercer resto
			bne $t1, $zero, noBis		# Si el primer resto es igual a 0 Y...
			bne $t2, $zero, bis		# El segundo resto es distinto de 0 O...
			beq $t3, $zero, bis		# El tercer resto es igual a cero, el numero es bisiesto
			
noBis:      addi $v0, $zero, 0	
	    b exit
	    
bis:        addi $v0, $zero, -1

exit: jr $ra

