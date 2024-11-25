.include "fileio.S"
.global _main
.align 4

.equ BUFFER_LENGTH, 0x100000
.equ END_OF_FILE, 0

_main:
read_again:
  read_stdin input@page, BUFFER_LENGTH
  print output@page, x0

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80

.data
input: .fill BUFFER_LENGTH + 1, 1, 0
output: .fill BUFFER_LENGTH + 1, 1, 0
hellostr: .ascii "hello mom!\n"
infile: .ascii "hello6.txt"
