; Filename: sum_decrementing64bit.asm
; Description:
; Calculates the sum of 25 down to 15 using a decrementing loop and prints the result (220).
; Architecture: x86_64, Linux.

section .data
    ; Buffer for the ASCII number (max 3 digits + newline)
    output_buffer db '000', 0ah
    BUFFER_SIZE equ $ - output_buffer

section .text
    global _start
    ; Function to convert a 64-bit number (in RBX) to ASCII and print it.
print_rbx:
    push rax
    push rbx
    push rdi
    mov rax, rbx
    mov r8, 10
    mov rcx, output_buffer + BUFFER_SIZE - 2
.digit_loop:
    xor rdx, rdx
    div r8
    add dl, '0'
    mov [rcx], dl
    dec rcx
    cmp rax, 0
    jnz .digit_loop
    inc rcx
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, rcx        ; start address
    mov rdx, output_buffer + BUFFER_SIZE
    sub rdx, rcx        ; length
    syscall
    pop rdi
    pop rbx
    pop rax
    ret

_start:
    ; --- 1. Program Logic: Summing 25 down to 15 ---
    xor rbx, rbx        ; rbx = Sum accumulator (0)
    mov r8, 25          ; r8 = Start value (25)
    mov r9, 15          ; r9 = Minimum value for the range

.sum_loop_dec:
    ; Check if the current number (r8) has gone below the minimum value (15)
    cmp r8, r9
    jl .print_result    ; Jump Less Than: If r8 < 15, jump to print

    add rbx, r8         ; Add the current number (r8) to the sum (rbx)
    dec r8              ; Decrement the current number (r8--)
    jmp .sum_loop_dec   ; Continue the loop

.print_result:
    call print_rbx      ; Call function to print the result (220) from RBX

    ; --- 2. Program Termination ---
    mov rax, 60         ; Syscall number for 'exit'
    xor rdi, rdi        ; Exit status 0
    syscall             ; Terminate the program
