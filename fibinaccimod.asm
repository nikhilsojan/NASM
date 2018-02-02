section .data
space:db ' '
len:equ $-space
section .bss
fib1: resb 1
fib2: resb 1
fib3: resw 1
fib4: resw 1
fib5: resb 1
fib6: resw 1
fib7: resb 1
counter: resb 1
section .text
global_start:
_start:
mov byte[fib1],0
add byte[fib1],30h
mov byte[fib2],1
add byte[fib2],30h
mov eax,4
mov ebx,1
mov ecx,fib1
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,space
mov edx,len
int 80h
sub byte[counter],30h
mov byte[counter],1
sub word[fib3],30h
sub word[fib4],30h
mov ax,0
mov bx,1
loop:
cmp byte[counter],17
je exit
inc byte[counter]
mov word[fib4],ax
add ax,bx
mov word[fib6],ax
mov bl,10
div bl
mov byte[fib5],ah
add byte[fib5],30h
xor ah,ah
mov bl,10
div bl
mov byte[fib7],ah
add byte[fib7],30h
mov word[fib3],ax
add word[fib3],30h
mov eax,4
mov ebx,1
mov ecx,fib3
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,fib7
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,fib5
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,space
mov edx,len
int 80h
mov ax,word[fib6]
mov bx,word[fib4]
jmp loop
exit:
mov eax,1
mov ebx,0
int 80h