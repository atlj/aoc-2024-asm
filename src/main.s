.include "fileio.S"
.global _main
.align 4

.equ BUFFER_LENGTH, 16

_main:
  read_stdin mem@page, BUFFER_LENGTH
  print mem@page, BUFFER_LENGTH

exit:
  mov x0, 0 ; status
  mov x16, 1 ; exit
  svc #0x80

.data
mem: .fill BUFFER_LENGTH + 1, 1, 0
hellostr: .ascii "hello mom!\n"
infile: .ascii "hello6.txt"
