mov r0, #0x38
ldr r1,[r0]
mov r0,#0x3c
ldr r2,[r0]
add r0,r1,r2
mov r1,#0x40
str r0,[r1]
ldr r2,[r1]
cmp r0,r1
bl 0x60
mov r4,#1

mov r3 ,#1
bx r14