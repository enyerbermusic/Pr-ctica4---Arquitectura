.data
    verde:    .asciiz "Semáforo en verde, esperando pulsador (presiona 's')\n"
    pulsado:  .asciiz "\nPulsador activado: en 20 segundos, cambiará a amarillo\n"
    amarillo: .asciiz "\nSemáforo en amarillo, en 10 segundos cambiará a rojo\n"
    rojo:     .asciiz "\nSemáforo en rojo, en 30 segundos volverá a verde\n"

.text
.globl main

main:
    
    li $v0, 4
    la $a0, verde
    syscall

esperar_s:
    li $v0, 12
    syscall

    bne $v0, 's', esperar_s

    li $v0, 4
    la $a0, pulsado
    syscall

    li $a0, 20000      
    li $v0, 32
    syscall

    li $v0, 4
    la $a0, amarillo
    syscall

    li $a0, 10000    
    li $v0, 32
    syscall

    li $v0, 4
    la $a0, rojo
    syscall

    li $a0, 30000    
    li $v0, 32
    syscall

    j main
