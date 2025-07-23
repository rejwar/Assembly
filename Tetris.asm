; Tetris-like game in 8086 assembly for DOS
; Simplified: 10x20 text-based grid, single-cell piece
; Compile with NASM, run in DOSBox

section .data
    board times 200 db 0    ; 10x20 grid (0=empty, 1=occupied)
    pieceX db 5             ; Piece x-coordinate
    pieceY db 0             ; Piece y-coordinate
    gameOver db 0           ; Game over flag
    symbol db '#'           ; Piece symbol
    empty db ' '            ; Empty cell symbol

section .text
    org 0x100               ; COM file origin

start:
    mov ax, 0x0003          ; Set text mode (80x25)
    int 0x10

init_game:
    mov si, board           ; Clear board
    mov cx, 200
    xor al, al
    rep stosb
    mov byte [pieceX], 5    ; Start piece at (5,0)
    mov byte [pieceY], 0
    mov byte [gameOver], 0

game_loop:
    cmp byte [gameOver], 1
    je end_game
    call draw_board
    call move_down
    call delay              ; Simple delay for timing
    jmp game_loop

move_down:
    mov al, [pieceY]
    inc al                  ; Try moving down
    cmp al, 20              ; Check bottom boundary
    jge place_piece
    mov bl, al
    mov bh, 0
    mov al, [pieceX]
    mov ah, 0
    mov di, bx
    imul di, 10
    add di, ax              ; Calculate board[pieceX][pieceY+1]
    cmp byte [board + di], 1
    je place_piece
    mov [pieceY], bl        ; Update pieceY
    ret

place_piece:
    mov al, [pieceX]
    mov bl, [pieceY]
    mov bh, 0
    mov di, bx
    imul di, 10
    add di, ax              ; Calculate board[pieceX][pieceY]
    mov byte [board + di], 1
    call check_lines
    mov byte [pieceX], 5    ; Reset piece
    mov byte [pieceY], 0
    cmp byte [board + 5], 1 ; Check collision at spawn
    je set_game_over
    ret

set_game_over:
    mov byte [gameOver], 1
    ret

check_lines:
    mov cx, 20              ; Check 20 rows
    mov si, board
check_row:
    mov bx, 10
    xor dx, dx              ; Count occupied cells
check_cell:
    cmp byte [si], 1
    jne skip_count
    inc dx
skip_count:
    inc si
    dec bx
    jnz check_cell
    cmp dx, 10              ; Full row?
    je clear_line
    loop check_row
    ret
clear_line:
    mov di, si
    sub di, 10              ; Move to start of row
    mov cx, 10
    mov al, 0
    rep stosb               ; Clear row
    ret                     ; Simplified: no shifting

draw_board:
    mov ax, 0x0003          ; Clear screen
    int 0x10
    mov si, board
    mov cx, 20              ; 20 rows
    mov dx, 0               ; Row counter
print_row:
    mov bx, 10              ; 10 columns
    push dx
    mov dx, 0x0000          ; Set cursor (row=dx, col=0)
    mov ah, 0x02
    int 0x10
print_cell:
    lodsb                   ; Load board cell
    mov ah, 0x0E            ; Print char
    cmp al, 1
    je print_piece
    mov al, [empty]
    jmp print_char
print_piece:
    mov al, [symbol]
print_char:
    int 0x10
    dec bx
    jnz print_cell
    pop dx
    inc dx
    loop print_row
    ret

delay:
    mov cx, 0xFFFF          ; Simple delay loop
delay_loop:
    loop delay_loop
    ret

end_game:
    mov ax, 0x0003          ; Clear screen
    int 0x10
    mov ah, 0x4C            ; Exit to DOS
    int 0x21
