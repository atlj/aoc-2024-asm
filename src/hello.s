.global _main
.align 4

_main:
  MOV x0, #0
  MOV x16, #1
  SVC #0x80

