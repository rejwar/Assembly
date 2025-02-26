section .data
    block_data db "Transaction1", 0  ; ডেটা
    prev_hash dd 0x12345678         ; আগের হ্যাশ
    curr_hash dd 0                  ; বর্তমান হ্যাশ

section .text
    global _start
_start:
    ; এখানে ব্লকের ডেটা প্রসেস করা হবে
    mov eax, 1
    int 0x80  ; প্রোগ্রাম শেষ
