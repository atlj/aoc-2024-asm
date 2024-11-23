.global _main
.align 4

_main:
  adrp x0, hellostr@page ; Start address of the string
  mov x1, #12; Length of the string
  bl _print

exit:
  mov x0, 0 ; status
  mov x16, 1 ; exit
  svc #0x80

.data
hellostr: .ascii "hello mom!\n"
