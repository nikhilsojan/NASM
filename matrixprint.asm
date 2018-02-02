section .data
space:db ' '
newline:db 10
section .bss
nod: resb 1
num: resw 1
temp: resb 1
m: resw 1
n: resw 1
i: resw 1
j: resw 1
matrix: resw 1
section .text
global _start
_start:
mov ecx,0
call read_num
mov cx,word[num]
mov word[m],cx
mov ecx,0
call read_num
mov cx,word[num]
mov word[n],cx
mov eax,0
mov ebx,matrix
mov word[i],0
mov word[j],0
i_loop:
mov word[j],0
j_loop:
call read_num
mov dx,word[num]
mov word[ebx+2*eax],dx
inc eax
inc word[j]
mov cx,word[n]
cmp word[j],cx
jb j_loop
inc word[i]
mov cx,word[m]
cmp word[i],cx
jb i_loop
mov eax,0
mov ebx,matrix
mov word[i],0
mov word[j],0
i_loop1:
mov word[j],0
j_loop1:
mov dx,word[ebx+2*eax]
mov word[num],dx
call print_num
pusha
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h
popa
inc eax
inc word[j]
mov cx,word[n]
cmp word[j],cx
jb j_loop1
pusha
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa
inc word[i]
mov cx,word[m]
cmp word[i],cx
jb i_loop1
mov eax,1
mov ebx,0
int 80h
read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:
popa
ret
print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no
end_print:
popa
ret