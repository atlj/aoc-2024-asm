.global _main
.align 4

_main:
  mov x0, #1 ; stdout
  adr x1, helloworld
  mov x2, #13
  mov x16, #4 ; write
  svc #0x80
  mov x0, #0 ; all good
  mov x16, #1 ; exit
  svc #0x80
.data:
helloworld: .ascii "Hello World\n"
