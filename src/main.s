.include "fileio.S"
.global _main
.align 4

.equ BUFFER_LENGTH, 255

_main:
  read_stdin mem@page, BUFFER_LENGTH
  mov x19, x0

  cmp x0, #0
  mov x0, #1
  b.lt custom_exit

  print mem@page, x19

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80

.data
mem: .fill BUFFER_LENGTH + 1, 1, 0
hellostr: .ascii "hello mom!\n"
infile: .ascii "hello6.txt"
