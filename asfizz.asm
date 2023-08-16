section .data
    fizz db "Fizz", 0
    buzz db "Buzz", 0
    newline db 10

section .text
    global _start

_start:
    mov ecx, 1

loop:
    cmp ecx, 101
    jg exit

    push ecx
    push newline

    mov eax, ecx
    xor edx, edx
    mov ebx, 3
    div ebx

    cmp edx, 0
    je fizz_label

    mov eax, ecx
    xor edx, edx
    mov ebx, 5
    div ebx

    cmp edx, 0
    je buzz_label

    mov eax, ecx
    push eax
    call print_number
    add esp, 4

    jmp next_iteration

fizz_label:
    push fizz
    call print_string
    add esp, 4

    jmp next_iteration

buzz_label:
    push buzz
    call print_string
    add esp, 4

    jmp next_iteration

next_iteration:
    add ecx, 1
    jmp loop

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_string:
    mov edx, eax
    mov ecx, esp
    mov ebx, 1
    mov eax, 4
    int 0x80
    ret

print_number:
    mov edi, 10
    xor esi, esi

convert_digit:
    xor edx, edx
    div edi
    add dl, '0'
    push edx
    inc esi
    test eax, eax
    jnz convert_digit

print_digit:
    pop edx
    mov [ecx], dl
    inc ecx
    loop print_digit

    mov [ecx], byte 0
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret

