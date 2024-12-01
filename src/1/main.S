.equ ELEM_SIZE, 64; Each element in the array will be this long
.equ ELEM_COUNT, 1000; Let's allocate 1k elems

_main:
  mov x0, ELEM_COUNT
  mov x1, ELEM_SIZE
  bl _calloc
  mov x19, x0; x19 will have list a

  mov x0, ELEM_COUNT
  mov x1, ELEM_SIZE
  bl _calloc
  mov x20, x0; x20 will have list b
  ; Allocate mem for list a

  mov x0, #0xfffff
  bl _malloc
  mov x21, x0; x21 will have the start addr of stdin
  bl _readStdIn
  mov x22, x0; x22 will have the length of input

  mov x0, x19
  mov x1, x20
  mov x2, x21
  mov x3, x22
  bl _parse_list_strings

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80

.include "lists.S"
.include "read.S"
.global _main
.align 4

val_burak: .asciz "Result is: %d\n"
val_burak_2: .asciz "123456"
