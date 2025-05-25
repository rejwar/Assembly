section .text
global keccak_permute

keccak_permute:
    mov eax, [rdi]     ; Load state
    xor eax, ebx       ; XOR with round constant
    rol eax, 7         ; Rotate left (Theta step)
    mov [rdi], eax     ; Store back

    ; Exit
    ret
