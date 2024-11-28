.equ NOT_SET, 11

; x0 is the start address
; x1 is the length
_iterate_chars:
  stp x19, x20, [sp, #-16]!
  stp x21, x22, [sp, #-16]!
  str x23,  [sp, #-16]!
  mov x23, #10 ;Multiplier
  mov x20, #0
  mov x21, NOT_SET

get_lines:
  ldrb w19, [x0], #1

  cmp w19, #'\n'
  b.NE skip_clearing

  madd x20, x21, x23, x20 ;Add the first digit
  add x20, x20, x22 ;Add the last digit

  mov x21, NOT_SET
skip_clearing:

  ; We don't care about non int chars
  cmp w19, #'0'
  b.LT continue_iteration
  cmp w19, #'9'
  b.GT continue_iteration

  cmp x21, NOT_SET 
  b.NE set_last_char
  sub w21, w19, #'0'
set_last_char:
  sub w22, w19, #'0'

continue_iteration:
  subs x1, x1, #1
  b.NE get_lines

  mov x0, x20
  ldr x23, [sp], 16
  ldp x21, x22, [sp], 16
  ldp x19, x20, [sp], 16
  ret

_main:
  mov x0, 0xfffff
  bl _malloc
  mov x21, x0

  bl _readStdIn
  mov x1, x0
  mov x0, x21
  bl _iterate_chars

  str x0, [SP, #-16]!
  adr x0, val_burak
  bl _printf
  add sp, sp, #16

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80

.include "read.S"
.global _main
.align 4

val_burak: .asciz "Result is: %d\n"
