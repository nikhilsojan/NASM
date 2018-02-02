section .data
space: db ' '
newline: db 10
section .bss
nod : resb 1
temp : resb 1
num : resw 1
matrix1: resw 1000
size: resw 10
product: resw 1
i: resw 10
j: resw 10
k: resw 10
m: resw 10
n: resw 10
x: resw 10
y: resw 10
ans1: resw 10
ans2: resw 10
matrix2: resw 1000
matrix3: resw 1000
counter: resw 10
counter1: resw 10
counter2: resw 10
counter4: resw 10
counter3: resw 10
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
mov ebx,matrix1
read_matrix1:
call read_num
mov dx,word[num]
mov word[ebx +2*eax],dx
inc eax
inc word[j]
mov dx,word[n]
cmp word[j],dx
jb read_matrix1
inc word[i]
mov word[j],0
mov dx,word[m]
cmp word[i],dx
jb read_matrix1
call read_num
mov dx,word[num]
mov word[x],dx
call read_num
mov dx,word[num]
mov word[y],dx
mov eax,0
mov word[i],0
mov word[j],0
mov ebx,matrix2
read_matrix2:
call read_num
mov dx,word[num]
mov word[ebx +2*eax],dx
inc eax
inc word[j]
mov dx,word[y]
cmp word[j],dx
jb read_matrix2
inc word[i]
mov word[j],0
mov dx,word[x]
cmp word[i],dx
jb read_matrix2
mov dword[counter],0
mov dword[counter3],0
mov dword[counter1],0
mov dword[counter2],0
mov dword[counter4],0
mov word[product],0
mov word[k],0
mov word[j],0
mov word[i],0
mov ebx,matrix1
mov esi,matrix2
mov edi,matrix3
i_loop:
mov eax,dword[counter1]

mov cx,word[ebx +2*eax]
mov word[ans1],cx
mov eax,dword[counter2]

mov cx,word[esi +2*eax]
mov word[ans2],cx
mov ax,word[ans1]
mov cx,word[ans2]
mul cx
add word[product],ax
movzx eax,word[y]
add dword[counter2],eax
inc dword[counter1]
inc word[j]
mov cx,word[n]
cmp word[j],cx
jb i_loop
mov cx,word[product]
mov word[num],cx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa
mov word[product],0
inc dword[counter4]
inc dword[counter3]
mov eax,dword[counter3]
mov dword[counter2],eax
mov eax,dword[counter]
mov dword[counter1],eax
mov word[j],0
inc word[i]
mov cx,word[y]
cmp word[i],cx
jne i_loop
exit1:
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
inc word[k]
mov cx,word[m]
cmp word[k],cx
je exit2
movzx eax,word[n]
add eax,dword[counter]
mov dword[counter],eax
mov dword[counter1],eax
mov dword[counter2],0
mov dword[counter3],0
mov word[i],0
mov word[j],0
jmp i_loop
exit2:
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