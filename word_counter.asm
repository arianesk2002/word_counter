org 100h

.Stack 100h


.Data

LF equ 0ah
CR equ 0dh
MAX_LENGTH equ 100
words_count dw ?
is_space db 1
input_guide_str db "please enter: $"
output_guide_str db "words count: $"
input_str db MAX_LENGTH dup(?)


.Code

; get input ---------------------------------------------------------------

; print input_guide_str
lea dx, input_guide_str
call print_string

; reset registers
call reset_registers

input:
    ; check if input length is lower than
    ; MAX_LENGTH
    cmp bx, MAX_LENGTH
    je end_input

    ; get character input
    mov ah, 01h
    int 21h

    ; check if entered character is
    ; carriage return [ENTER]
    cmp al, CR
    je end_input

    ; set entered character in input_str
    mov byte input_str[bx], al
    inc bx
    jmp input

end_input:
    ; set $ to end of input
    mov byte input_str[bx], '$'
    call print_newline


; count words -------------------------------------------------------------

; reset registers
call reset_registers

check:
    ; if character is endpoint
    cmp input_str[bx], '$'
    je check_last_word

    ; if character is whitespace
    cmp input_str[bx], ' '
    je check_word

    ; set flag to false
    mov is_space, 0
    
    ; increment the pointer
    inc bx

    jmp check


check_word:
    ; if flag is flase
    cmp is_space, 0
    je check_word_true
    
    ; increment the pointer
    inc bx

    jmp check

check_word_true:
    ; set flag to true
    mov is_space, 1
    
    ; increment the count
    inc cx
    
    ; increment the pointer
    inc bx

    jmp check

check_last_word:
    ; if flag is flase
    cmp is_space, 0
    je check_last_word_true

    jmp check_end

check_last_word_true:
    ; increment the count
    inc cx

check_end:
    ; set words_count variable
    mov words_count, cx


; print result ------------------------------------------------------------

; print output_guide_str
lea dx, output_guide_str
call print_string

; reset registers
call reset_registers

; move words_count to ax
mov ax, words_count
convert_to_decimal:
    ; if ax is zero
    cmp ax, 0
    je print_decimal

    ; initialize bx to 10
    mov bx, 10

    ; extract the last digit
    div bx

    ; push it in the stack
    push dx

    ; increment the count
    inc cx

    ; set dx to 0
    mov dx, 0
    jmp convert_to_decimal

print_decimal:
    ; check if count is greater than zero
    cmp cx, 0
    je exit

    ; pop the top of stack
    pop dx

    ; add 48 so that it represents the ASCII
    ; value of digits
    add dx, 48
    call print_character

    ; decrease the count
    dec cx
    jmp print_decimal

exit:
    ret


; print string
; mov string address in dx
print_string proc
    mov ah, 09h
    int 21h
    ret
print_string endp


; print character
; mov character in dx
print_character proc
    mov ah, 02h
    int 21h
    ret
print_character endp


; print newline
print_newline proc
    ; print line feed
    mov dx, LF
    call print_character

    ; print carriage return
    mov dx, CR
    call print_character

    ret
print_newline endp


; reset register values to zero
reset_registers proc
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
    mov si, 0
    mov di, 0
    ret
reset_registers endp


end