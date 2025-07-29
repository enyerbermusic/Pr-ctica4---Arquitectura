.data
buffer:        .space 1024     
buffer_tam:    .word 1024      
cabecera:      .word 0        
cola:          .word 0       
tiempo:        .word 20000     

fin_tiempo:    .asciiz "\nTiempo completado. Contenido del buffer:\n"
otra_linea:    .asciiz "\n"

.text
.globl main

main:
    la $s0, buffer         
    lw $s1, buffer_tam     
    sw $zero, cabecera         
    sw $zero, cola         
    lw $s4, tiempo       
    
contar:    
    li $v0, 30
    syscall
    move $t0, $a0           
    
entrada:   
    li $v0, 30
    syscall
    sub $t1, $a0, $t0
    bge $t1, $s4, imprimir_buffer
    
    li $v0, 12              
    syscall
    blez $v0, entrada    
    
    move $t2, $v0           
    
    beq $t2, '\n', entrada  
    beq $t2, '\r', entrada  
    
    
    lw $t3, cabecera            
    add $t4, $s0, $t3       
    sb $t2, 0($t4)         
    
    addi $t3, $t3, 1
    blt $t3, $s1, actualizar_cabecera
    li $t3, 0
actualizar_cabecera:
    sw $t3, cabecera          
    
    j entrada
    
imprimir_buffer:
    li $v0, 4
    la $a0, fin_tiempo
    syscall
    
imprimir_ciclo:
    lw $t3, cola
    lw $t4, cabecera
    beq $t3, $t4, fin_imprimir
    
    add $t5, $s0, $t3       
    lb $a0, 0($t5)          
     
    li $v0, 11
    syscall
        
    addi $t3, $t3, 1
    blt $t3, $s1, actualizar_cola
    li $t3, 0
actualizar_cola:
    sw $t3, cola
    
    j imprimir_ciclo
    
fin_imprimir:
    li $v0, 4
    la $a0, otra_linea
    syscall
    
    j contar
