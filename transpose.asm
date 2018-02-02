section .data
space : db ' '
newline : db 10
section .bss
matrix: resw 100
i: resw 2
j: resw 2
m: resw 2
n: resw 2
num: resw 10
counter2: resd 2
temp: resb 2
nod: resb 2
counter1: resd 2
section .txt
global _start
_start:
call read_num
mov dx,word[num]
mov word[m],dx
call read_num
mov dx,word[num]
mov word[n],dx
mov word[i],0
mov word[j],0
mov eax,0
read_matrix:
mov ebx,matrix
call read_num
mov dx,word[num]
mov word[ebx + 2*eax],dx
inc eax
inc word[j]
mov dx,word[n]
cmp word[j],dx
jb read_matrix
inc word[i]
mov word[j],0
mov dx,word[m]
cmp word[i],dx
jb read_matrix
mov eax,0
mov word[i],0
mov word[j],0
mov dword[counter1],0
mov dword[counter2],0
i_loop:
mov ebx,matrix
mov eax,dword[counter1]
mov dx,word[ebx +2*eax]
mov word[num],dx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa
movzx eax,word[n]
add dword[counter1],eax
inc word[i]
mov dx,word[m]
cmp word[i],dx
jb i_loop
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
mov word[i],0
inc word[j]
inc dword[counter2]
mov eax,dword[counter2]
mov dword[counter1],eax
mov dx,word[n]
cmp word[j],dx
jb i_loop
mov eax,1
mov ebx,0
int 80h
read_num:
pusha
mov word[num],0
loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_read
mov ax,word[num]
mov bx,10
mul bx
sub byte[temp],30h
movzx bx,byte[temp]
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret
print_num:
pusha
mov byte[nod],0
extract_num:
mov ax,word[num]
mov bx,10
mov dx,0
div bx
push dx
inc byte[nod]
mov word[num],ax
cmp ax,0
jne extract_num
print_no:
cmp byte[nod],0
je end_print
pop dx
dec byte[nod]
mov byte[temp],dl
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print_no
end_print:
popa
ret