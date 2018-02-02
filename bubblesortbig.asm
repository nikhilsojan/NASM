section .data
space: db ' '
section .bss
nod : resb 1
temp : resb 1
num : resw 1
array: resw 50
size: resw 10
i: resw 10
j: resw 10
section .txt
global _start
_start:
call read_num
mov dx,word[num]
mov word[size],dx
mov word[i],0
mov eax,0
mov ebx,array
read_array:
call read_num
mov dx,word[num]
movzx eax,word[i]
mov word[ebx +2*eax],dx
inc word[i]
mov dx,word[size]
cmp word[i],dx
jb read_array
mov word[i],0
mov eax,0
mov word[j],0
mov ebx,array
i_loop:
mov word[j],0
j_loop:
mov ebx,array
mov dx,word[size]
sub dx,word[i]
sub dx,1
cmp word[j],dx
je exit1
movzx eax,word[j]
mov cx,word[ebx + 2*eax]
inc word[j]
movzx eax,word[j]
mov dx,word[ebx + 2*eax]
cmp cx,dx
jg swap
jmp j_loop
swap:
movzx eax,word[j]
mov word[ebx +2*eax],cx
dec word[j]
movzx eax,word[j]
mov word[ebx +2*eax],dx
inc word[j]
jmp j_loop
exit1:
inc word[i]
mov dx,word[size]
cmp word[i],dx
jb i_loop
mov word[i],0
mov eax,0
print_array:
mov ebx,array
movzx eax,word[i]
mov dx,word[ebx + 2*eax]
mov word[num],dx
call print_num
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
inc word[i]
mov dx,word[size]
cmp word[i],dx
jb print_array
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
extract_no:
mov ax,word[num]
mov dx,0
mov bx,10
div bx
push dx
inc byte[nod]
mov word[num],ax
cmp ax,0
jne extract_no
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