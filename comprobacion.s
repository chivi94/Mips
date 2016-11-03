		.data 
		
		.text
		#Fechas
main:			addi $s0, $zero, 1
			addi $s1, $zero, 12
			addi $s2, $zero, 2017
			
			addi $s3, $zero, 3
			addi $s4, $zero, 12
			addi $s5, $zero, 2016
			
			add $a0, $zero, $s2
			add $a1, $zero, $s5
			
			jal lessOrHigherThan
			
			add $a0, $zero, $v0
			li $v0, 1
			syscall
			
			li $v0, 10
			syscall
		
		
lessOrHigherThan:	#Función que comprobará sí dos dígitos son iguales o distintos. Criterio: Iguales -> 0 Primero<Segundo-> -1. Segundo < Primero -> -2.
			add $s0, $zero, $a0		#Primer dígito
			add $s1, $zero, $a1		#Segundo dígito
			
			beq $s0, $s1, Same		#If primero == segundo -> 0.
			blt $s0, $s1, Less		#If primero < segundo -> -1.
			addi $v0, $zero, -2		#Si no, -2.
			b ExitCheck
			
	Same:		addi $v0, $zero, 0		#Si primero == segundo
			b ExitCheck
	
	Less:		addi $v0, $zero, -1		#Si primero < segundo
	
	ExitCheck:	jr $ra
			
			
			
			
			
