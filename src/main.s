.include "read.S"
.global _main
.align 4

_main:
  mov x0, 0xfffff
  bl _malloc
  mov x21, x0

  bl _readStdIn

  mov x0, x21
  bl _printf

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80
