section .bss
digit1: resb 1
digit2: resb 1
digit3: resb 1
digit4: resb 1
digit5: resb 1
digit6: resb 1
digit7: resb 1
digit8: resb 1
num1: resw 1
num2: resw 1
num3: resw 1
num4: resw 1
ans1: resb 1
ans2: resw 1
section .text
global _start
_start:
mov eax,3
mov ebx,0
mov ecx,digit1
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,digit2
mov edx,2
int 80h
mov eax,3
mov ebx,0
mov ecx,digit3
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,digit4
mov edx,2
int 80h
mov eax,3
mov ebx,0
mov ecx,digit5
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,digit6
mov edx,2
int 80h
mov eax,3
mov ebx,0
mov ecx,digit7
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,digit8
mov edx,2
int 80h
sub byte[digit1],30h
sub byte[digit2],30h
sub byte[digit3],30h
sub byte[digit4],30h
sub byte[digit5],30h
sub byte[digit6],30h
sub byte[digit7],30h
sub byte[digit8],30h
movzx ax,byte[digit1]
mov bx,10
mul bx
movzx bx,byte[digit2]
add ax,bx
mov word[num1],ax
movzx ax,byte[digit3]
mov bx,10
mul bx
movzx bx,byte[digit4]
add ax,bx
mov word[num2],ax
movzx ax,byte[digit5]
mov bx,10
mul bx
movzx bx,byte[digit6]
add ax,bx
mov word[num3],ax
movzx ax,byte[digit7]
mov bx,10
mul bx
movzx bx,byte[digit8]
add ax,bx
mov word[num4],ax
movzx eax,word[num1]
movzx ebx,word[num2]
movzx ecx,word[num3]
movzx edx,word[num4]
cmp eax,ebx
jg a
cmp ecx,ebx
jg b
cmp edx,ebx
jg print4
mov ax,word[num2]
mov bl,10
div bl
mov byte[ans1],ah
add byte[ans1],30h
mov word[ans2],ax
add word[ans2],30h
mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h
print3:
mov ax,word[num3]
mov bl,10
div bl
mov byte[ans1],ah
add byte[ans1],30h
mov word[ans2],ax
add word[ans2],30h
mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h
print4:
mov ax,word[num4]
mov bl,10
div bl
mov byte[ans1],ah
add byte[ans1],30h
mov word[ans2],ax
add word[ans2],30h
mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h
a:
cmp eax,ecx
jl b
cmp eax,edx
jl print4
mov ax,word[num1]
mov bl,10
div bl
mov byte[ans1],ah
add byte[ans1],30h
mov word[ans2],ax
add word[ans2],30h
mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h
b:
cmp edx,ecx
jl print3
mov ax,word[num4]
mov bl,10
div bl
mov byte[ans1],ah
add byte[ans1],30h
mov word[ans2],ax
add word[ans2],30h
mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h