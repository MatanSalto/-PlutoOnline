section .data
trueStr db 'true', 0
falseStr db 'false', 0
newline db 0ah
currentIndex dq buff
buff resb 8192
section .stack
stack_size equ 8192
stack_space db 0 dup(stack_size)

section .text

global _start

ConvertNumToString:
    push rbp
    mov rbp, rsp
    
    push rbx
   
    mov rax, [rbp+16]
    push qword [currentIndex]
    mov rsi, [currentIndex]

    cmp rax, 0
    jg cont
    je zero
    mov byte [rsi], '-'
    inc rsi
    inc qword [currentIndex]
    neg rax
    mov [rbp+16], rax

    cont:
        mov rcx, 0
        mov rbx, 10
        loop2:
            cmp rax, 0
            je end_loop2
            inc rcx
            mov rdx, 0
            div rbx
            jmp loop2
            
       
    end_loop2:
        mov rax, [rbp+16]
        mov byte [rsi + rcx], 0
        add qword [currentIndex], rcx
        add qword [currentIndex], 1
        loop3:
            cmp rax, 0
            je end_loop3
            mov rdx, 0
            div rbx
            add rdx, '0'
            mov [rsi + rcx - 1], dl
            dec rcx
            jmp loop3
    zero:
        mov byte [rsi], '0'
        mov byte [rsi+1], 0
        add qword [currentIndex], 2
    end_loop3:
        pop rax
        pop rbx
        pop rbp
        ret 8
        
ConvertCharToString:
    push rbp
    mov rbp, rsp
   
    mov rax, [rbp+16]
    push qword [currentIndex]
    mov rsi, [currentIndex]
    mov [rsi], al
    mov byte [rsi+1], 0
    add qword [currentIndex], 2
    pop rax
    pop rbp
    ret 8
    
ConvertBoolToString:
    push rbp
    mov rbp, rsp
    
    mov rax, [rbp+16]
    cmp rax, 0
    je false_label
    mov rax, trueStr
    jmp end_function
    false_label:
    mov rax, falseStr
    end_function:
        pop rbp
        ret 8
    
    
AddStrings:
    push rbp
    mov rbp, rsp
    
    push rbx
    push rcx
    push rsi
    
    mov rax, [rbp+24]
    mov rbx, [rbp+16]
    
    push qword [currentIndex]
    mov rsi, [currentIndex]
    
    loop4:
        mov cl, [rax]
        cmp cl, 0
        je loop5
        mov [rsi], cl
        inc rsi
        inc rax
        jmp loop4
        
    loop5:
        mov cl, [rbx]
        cmp cl, 0
        je end_loop5
        mov [rsi], cl
        inc rsi
        inc rbx
        jmp loop5
        
    end_loop5:
        mov byte [rsi], 0
        inc rsi
        mov qword [currentIndex], rsi
        
        pop rax
        pop rsi
        pop rcx
        pop rbx
        
        pop rbp
        ret 16
        

StringsCompare:
    push rbp
    mov rbp, rsp
    
    mov rax, [rbp+16]
    mov rbx, [rbp+24]
    
    loop6:
        mov ch, [rax]
        mov cl, [rbx]
        cmp cl, 0
        je end_str
        cmp cl, ch
        jne not_equal
        inc rax
        inc rbx
        jmp loop6
        
    end_str:
        cmp ch, 0
        je equal
        jmp not_equal
        
    equal:
        mov rax, 1
        jmp end_function1
        
    not_equal:
        mov rax, 0
        jmp end_function1
        
    end_function1:
        pop rbp
        ret 16

PrintString:
    push rbp
    mov rbp, rsp
   
    mov rbx, [rbp+16]
   
    loop1:
        Mov cl, byte [rbx]
        cmp cl, 0
        je end_loop
        mov rax, 1
        mov rdi, 1
        mov rsi, rbx
        mov rdx, 1
        syscall
        inc rbx
        jmp loop1
       
    end_loop:
        mov rsi, newline
        syscall
        pop rbp
        ret 8
; Function declaration
_fact:
PUSH rbp
MOV rbp, rsp
PUSH rbp
; If statement
; Binary expression
; Factor
; Literal
MOV rax, 0
PUSH rax
; Factor
PUSH rbp
MOV rax, [rbp+16]
POP rbp
CMP [rsp], rax
MOV rax, 0
MOV rbx, 1
CMOVZ rax, rbx
POP rbx
CMP rax, 0
JNZ _label1
JMP _label2
_label1:
PUSH rbp
MOV rbp, rsp
PUSH rbp
; Return statement
; Factor
; Literal
MOV rax, 1
MOV rsp, [rbp-8]
MOV rbp, [rbp]
ADD rsp, 8
JMP _label0
MOV rsp, [rbp-8]
MOV rbp, [rbp]
ADD rsp, 8
_label2:
; Return statement
; Binary expression
; Factor
; Function call
; Binary expression
; Factor
; Literal
MOV rax, 1
PUSH rax
; Factor
PUSH rbp
MOV rax, [rbp+16]
POP rbp
SUB rax, qword [rsp]
POP rbx
PUSH rax
CALL _fact
PUSH rax
; Factor
PUSH rbp
MOV rax, [rbp+16]
POP rbp
IMUL qword [rsp]
POP rbx
JMP _label0
_label0:
MOV rsp, [rbp-8]
Mov rbp, [rbp]
ADD rsp, 8
RET 8
_start:
MOV rsp, stack_space + stack_size
MOV rbp, rsp
; Print statement
; Binary expression
; Factor
; Function call
; Factor
; Literal
MOV rax, 6
PUSH rax
CALL _fact
PUSH rax
; Factor
; Literal
MOV rax, [currentIndex]
MOV rsi, rax
MOV byte [rsi], 'f'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], 'a'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], 'c'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], 't'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], '('
INC qword [currentIndex]
INC rsi
MOV byte [rsi], '6'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], ')'
INC qword [currentIndex]
INC rsi
MOV byte [rsi], ' '
INC qword [currentIndex]
INC rsi
MOV byte [rsi], '='
INC qword [currentIndex]
INC rsi
MOV byte [rsi], ' '
INC qword [currentIndex]
INC rsi
MOV byte [rsi], 0
INC qword [currentIndex]
MOV rbx, rax
PUSH qword [rsp]
CALL ConvertNumToString
PUSH rbx
PUSH rax
CALL AddStrings
POP rbx
PUSH rax
CALL PrintString
