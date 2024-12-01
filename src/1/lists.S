; Write the input to two lists as strings
; x0 [list a]
; x1 [list b]
; x2 [stdin]
; x3 length of input
; Returns
; x0 [length of lists]
_parse_list_strings:
  mov x6, #0

loop:
  ldrb w5, [x2], #1; w5 is the read head

  cmp w5, #','
  b.EQ swap_and_add
  cmp w5, #'\n'
  b.EQ swap

  strb w5, [x0], #1
  b continue

swap_and_add:
  add x6, x6, #1
swap:
  add x0, x0, #3; When we hit a swap, we also want to make sure our array is aligned to 8 bytes
  ; x0 is going to be the write head
  mov x4, x0
  mov x0, x1; Move x0 to x1
  mov x1, x4; Get the previous x1 val to x0
continue:
  subs x3, x3, #1
  b.NE loop

  mov x0, x6
  ret


; x0 is the start address for the list
; x1 is the length
_convert_string_list_to_int_list:
  stp lr, x19, [SP, #-16]!
  stp x20, x21, [SP, #-16]!

  mov x19, x0; Persist these so we can call c
  mov x20, x1
convert_loop:
  mov x0, x19
  bl _atoi

  ; rev x0, x0; Remove this possibly
  str x0, [x19], #8

  subs x20, x20, #1
  b.NE convert_loop

  ldp x20, x21, [SP], #16
  ldp lr, x19, [SP], #16
  ret

