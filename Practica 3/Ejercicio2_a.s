.data
  descripcion: .asciiz "El programa transformara un numero decimal a uno en hexadecimal.\n"
  pedir: .asciiz "Introduzca un numero decimal: "
  respuesta: .asciiz "El numero correspondiente en hexadecimal es:"
  up_desbordamiento: .asciiz "Desbordamiento por arriba"
  down_desbordamiento: .asciiz "Desbordamiento por abajo"
  cadena: .space 8

.text

main: addi $t5, $zero, 2147483648
      addi $t6, $zero, -2147483647
      la $a0, descripcion
      li $v0, 4
      syscall                           #Descripcion del programa

      la $a0, pedir
      li $v0, 4
      syscall                           #Peticion de datos

      li $v0, 5
      syscall                           #Almacenamiento de los datos pedidos

      add $a0, $zero,$v0                #Guardamos los datos introducidos por el usuario
      beq $a0, $t5, Salida_desbordada
      beq $a0, $t6, Salida_desbordada_abajo

      la $a1, cadena                    #Almacenamos la direccion donde se almacenara la cadena resultante en hexadecimal
      jal Funcion                       #Llamada al procedimiento

      Salida_normal:
        la $a0, respuesta
        li $v0, 4
        syscall                         #Mensaje de respuesta

        la $a0, cadena
        li $v0, 4
        syscall                         #Cadena resultante

        la $v0, 10
        syscall                         #Fin de programa
      Salida_desbordada:
        la $a0, up_desbordamiento
        li $v0, 4
        syscall                         #Mensaje de respuesta

        la $v0, 10
        syscall                         #Fin de programa
      Salida_desbordada_abajo:
          la $a0, down_desbordamiento
          li $v0, 4
          syscall                         #Mensaje de respuesta

          la $v0, 10
          syscall                         #Fin de programa

Funcion:add $t2, $zero, $a0             #Parametro(=registro) que contiene el numero introducido por el usuario
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
