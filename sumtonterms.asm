section .bss
num1: resw 1
num2:resw 1
sum: resb 1
sum1: resb 1
sum2: resb 1
sum3:resw 1
section .text
global _start
_start:
mov eax,3
mov ebx,0
mov ecx,num1
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,num2
mov edx,1
int 80h
sub word[num1],30h
sub word[num2],30h
sub word[sum],30h
mov ax,word[num1]
mov bx,10
mul bx
mov bx,word[num2]
add ax,bx
mov word[num1],ax
mov ax,0
loop:
cmp word[num1],0
je exit
add ax,word[num1]
dec word[num1]
jmp loop
exit:
mov bl,10
div bl
sub byte[sum],30h
sub byte[sum1],30h
sub byte[sum2],30h
sub word[sum3],30h
mov byte[sum],ah
add byte[sum],30h
xor ah,ah
mov bl,10
div bl
mov byte[sum1],ah
add byte[sum1],30h
xor ah,ah
mov bl,10
div bl
mov byte[sum2],ah
add byte[sum2],30h
mov word[sum3],ax
add word[sum3],30h
mov eax,4
mov ebx,1
mov ecx,sum3
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,sum2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,sum1
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,sum
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h