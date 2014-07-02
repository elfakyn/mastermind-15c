section .text
global _start

_start:

fisher_yates:
    mov rcx, 9
fisher_yates_loop:
    mov rdx, 0
    push rcx
    rdrand rax
    div rcx
    pop rcx
    mov al, [arr + rcx]
    mov bl, [arr + rdx]
    mov [arr + rdx], al
    mov [arr + rcx], bl
    loop fisher_yates_loop

main_loop:
    call read
    mov word [status + 16], "00"
    mov rcx, 4
    mov rdx, 16
main_loop_loop:
    push rcx
    call compare
    pop rcx
    mov rdx, 17
    mov eax, dword [arr]
    ror eax, 8
    mov dword [arr], eax
    loop main_loop_loop
    cmp word [status + 16], "40"
    je won
    inc byte [status + 6]
    cmp byte [status + 6], ":"
    je lost
    call write
    jmp main_loop

compare:
    mov rcx, 4
compare_loop:
    dec rcx
    mov al, [status + 9 + rcx]
    cmp al, [arr + rcx]
    jne compare_skip_inc
    inc byte [status + rdx]
compare_skip_inc:
    inc rcx
    loop compare_loop
    ret

read:
    mov rax, 0
    mov rdx, 4
    mov rdi, 0
    mov rsi, status + 9
    syscall
    ret

write:
    mov rax, 1
    mov rdx, 19
    mov rdi, 1
    mov rsi, status
    syscall
    ret

won:
    mov rax, 1
    mov rdx, 16
    mov rdi, 1
    mov rsi, win_msg
    syscall
    jmp exit

lost:
    mov rax, 1
    mov rdx, 23
    mov rdi, 1
    mov rsi, lose_msg
    syscall
    mov rax, 1
    mov rdx, 4
    mov rdi, 1
    mov rsi, arr
    syscall
    mov rax, 1
    mov rdx, 2
    mov rdi, 1
    mov rsi, lose_msg_cont
    syscall
    jmp exit
    

exit:
    mov rax, 60
    mov rdi, 0
    syscall

section .data

arr             db "1234567890"
status          db 10, "Try #0: 0000 - 00", 10
win_msg         db 10, "You're winner!", 10
lose_msg        db 10, "Lose, correct answer: "
lose_msg_cont   db "!", 10
