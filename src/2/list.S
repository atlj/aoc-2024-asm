; Parse stdin to generate rows and lenghts
; x0 [stdin]
; x1 [rows]
; x2 [lengths]
; x3 char count in stdin
; Returns
; x0 total count of rows
_generate_lists:
  stp lr, x19, [SP, #-16]!
  stp x20, x21, [SP, #-16]!
  stp x22, x23, [SP, #-16]!
  stp x24, x25, [SP, #-16]!
  stp x26, x27, [SP, #-16]!

  mov x19, x0; stdin
  mov x20, x1; rows
  mov x21, x2; lengths
  mov x22, x3; char count in stdin
  mov w25, #0; Current number of chars in row
  mov x26, #0; Total row count

  mov x0, #64; Allocate 64 bits, we can hold 8 chars.
  bl _malloc
  mov x23, x0; Buffer for writing the current chars
  mov x24, x0; We will keep the start addr to reset properly

generate_lists_loop:
  ldrb w0, [x19], #1; Current char

  cmp w0, #' '
  b.EQ lists_space
  cmp w0, #'\n'
  b.EQ lists_new_line

  strb w0, [x23], #1; Write the current char to temp buffer
  b lists_continue

lists_new_line:

  add x26, x26, #1; Increment the total row count
  strb w25, [x21], #1; Write the current count
  mov w25, #0; Zero the current count

  b lists_continue

lists_space:
  add w25, w25, #1; Increment the current count

  mov x0, x24; Pass the addr of temp buffer
  bl _atoi; Convert temp buffer to int
  str x0, [x20], #8; Store the int in the rows addr

  str xzr, [x24]; Zero out the temp buffer
  mov x23, x24; Reset the temp buffer addr to start

lists_continue:

  subs x22, x22, #1
  b.NE generate_lists_loop

  add x0, x26, #0; Return the total number of rows

  ldp x26, x27, [SP], #16
  ldp x24, x25, [SP], #16
  ldp x22, x23, [SP], #16
  ldp x20, x21, [SP], #16
  ldp lr, x19, [SP], #16
  ret
