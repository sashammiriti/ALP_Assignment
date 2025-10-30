; Filename: assembly_factorial.asm
; Description: Calculates the factorial of an integer provided in RDI,
; and returns the result in RAX (x64 Linux ABI calling convention).

section .text
    global factorial    ; Makes the function visible to the C linker

; long long factorial(int n)
; RDI: input n
; RAX: return value (n!)
factorial:
    ; Prologue: Save C calling convention required registers
    push rbp
    mov rbp, rsp        ; Set up stack frame (optional but good practice)

    ; Check for base case: n = 0 or n = 1 -> return 1
    cmp rdi, 1
    jle .return_one     ; If n <= 1, jump to return 1

    ; --- Recursive Call Setup ---
    ; Note: Factorial calculation uses the recursive definition: N! = N * (N-1)!

    ; Set up the stack for the function call
    ; 1. Store the current value of n (RDI) for multiplication later
    push rdi

    ; 2. Calculate the argument for the next call: (n - 1)
    dec rdi             ; RDI now holds (n - 1)

    ; 3. Recursively call factorial(n - 1)
    call factorial

    ; --- Recursive Return ---
    ; RAX now holds (n - 1)!
    ; 4. Retrieve the saved n value
    pop rcx             ; *** CORRECTED: Should be RCX, not rrcx ***
                        ; Use RCX temporarily to retrieve the original n
                        ; (We use RCX instead of RDI or RSI to keep them clear)

    ; 5. Multiply: result = (n - 1)! * n
    imul rax, rcx       ; RAX = RAX * RCX (RAX = (n-1)! * n)

    jmp .end_function   ; Jump to the common epilogue

.return_one:
    mov rax, 1          ; Base case: return 1! or 0! = 1

.end_function:
    ; Epilogue: Restore stack and return
    mov rsp, rbp
    pop rbp
    ret                 ; Return to the C caller
