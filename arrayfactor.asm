section .data
space: db ' '
newline: db 10

section .bss
array: resw 50
counter1: resd 1
counter2: resd 1
i: resw 1
j: resw 1
temp: resb 10
nod: resb 10
num: resw 10
k: resw 1
m: resw 2
n: resw 2
section .txt
global _start
_start:
call read_num
mov dx,word[num]
mov word[n],dx
mov eax,0
mov word[i],0
mov word[j],0
read_array:
mov ebx,array
call read_num
mov dx,word[num]
mov word[ebx + 2*eax],dx
inc eax
inc word[i]
mov dx,word[n]
cmp word[i],dx
jb read_array
mov word[i],0
mov word[j],1
mov eax,0
change:
mov ebx,array
movzx eax,word[i]
mov dx,word[ebx +2*eax]
movzx eax,word[j]
mov cx,word[ebx +2*eax] 
mov ax,word[j]
mov word[k],ax
cmp cx,dx
je change1
inc word[j]
mov dx,word[n]
cmp word[j],dx
jb change
inc word[i]
mov dx,word[i]
inc dx
mov word[j],dx
mov dx,word[n]
cmp word[i],dx
jb change
jmp a
change1:
inc word[k]
movzx eax,word[k]
mov cx,word[ebx + 2*eax]
dec word[k]
movzx eax,word[k]
mov word[ebx + 2*eax],cx
inc word[k]
mov dx,word[n]
cmp word[k],dx
jb change1
dec word[n]
jmp change
a:
mov word[i],0
mov word[j],0
mov eax,0
cmp word[n],1
je end
check1:
mov ebx,array
mov dx,word[j]
cmp dx,word[i]
je check2
movzx eax,word[j]
mov dx,word[ebx+2*eax]
movzx eax,word[i]
mov cx,word[ebx + 2*eax]
cmp cx,0
je change2
mov ax,dx
mov dx,0
div cx
cmp dx,0
je print
inc word[j]
mov dx,word[n]
cmp word[j],dx
jne check1
mov word[j],0
inc word[i]
cmp word[i],dx
jne check1
check2:
inc word[j]
mov dx,word[n]
cmp word[j],dx
jne check1
exit:
mov eax,1
mov ebx,0
int 80h
change2:
mov word[j],0
inc word[i]
mov dx,word[n]
cmp word[i],dx
jne check1
jmp exit
print:
movzx eax,word[i]
mov cx,word[ebx + 2*eax]
mov word[num],cx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa
inc word[i]
mov dx,word[n]
cmp word[i],dx
jne check1
jmp exit
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
mov bx,10
mov dx,0
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
end:
mov ebx,array
mov eax,0
mov dx,word[ebx + 2*eax]
mov word[num],dx
call print_num
mov eax,1
mov ebx,0
int 80h