section .data
msg1: db 'multiple',10
len1: equ $-msg1
msg2: db 'not multiple',10
len2: equ $-msg2
section .bss
num1: resw 1
num2: resw 1
num3: resw 1
num4: resw 1
ans1: resw 2
ans2: resw 2
section .text
global _start
start:
mov eax,3
mov ebx,0
mov ecx,num1
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,num2
mov edx,2
int 80h
mov eax,3
mov ebx,0
mov ecx,num3
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,num4
mov edx,2
int 80h
sub byte[num1],30h
sub byte[num2],30h
sub byte[num3],30h
sub byte[num4],30h
sub word[ans1],30h
sub word[ans2],30h
movzx ax,byte[num1]
mov bx,10
mul bx
movzx bx,byte[num2]
add ax,bx
mov word[ans1],ax
movzx ax,byte[num3]
mov bx,10
mul bx
movzx bx,byte[num4]
add ax,bx
mov word[ans2],ax
mov ax,word[ans1]
mov bx,word[ans2]
div bx
cmp dx,0
je exit
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
mov eax,1
mov ebx,0
int 80h
exit:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov eax,1
mov ebx,0
int 80h