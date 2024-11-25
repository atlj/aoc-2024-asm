.equ OPEN_READONLY, 0
.equ OPEN_WRITEONLY, 1
.equ OPEN_CREATE, 0x00000200
.equ PERMISSION_READ_WRITE, 0666

.equ SYS_READ, 3
.equ SYS_WRITE, 4
.equ STDIN_FILE_DESCRIPTOR, 0
.equ STDOUT_FILE_DESCRIPTOR, 1

.macro read_stdin address, length
  mov x0, #0
  mov x1, \address
  mov x2, \length
  mov x16, SYS_READ
  svc #0x80 ; call supervisor
.endm

.macro print address, length
  mov x0, #1 ; file descriptor = stdout
  adrp x1, \address
  mov x2, \length
  mov x16, SYS_WRITE ; write syscall code
  svc #0x80 ; call supervisor
.endm
