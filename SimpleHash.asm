section .data
    data db "Pay 10", 0
    hash dd 0

section .text
    global _start
_start:
    mov al, [data]    ; প্রথম অক্ষর ("P")
    xor al, [data+1]  ; দ্বিতীয় অক্ষর ("a") দিয়ে XOR
    mov [hash], al    ; হ্যাশ সেভ করা
    mov eax, 1
    int 0x80
