; File Name: addition.asm

section .data
    num1 db 5          ; Define the first number as 5
    num2 db 3          ; Define the second number as 3
    result db 0        ; Storage for the result

section .text
    global _start

_start:
    mov al, [num1]      ; Load num1 into the AL register
    add al, [num2]      ; Add num2 to AL
    mov [result], al    ; Store the result in 'result'

exit_program:           ; Meaningful name for the exit sequence
    mov eax, 60         ; syscall: exit
    xor edi, edi        ; status: 0
    syscall
