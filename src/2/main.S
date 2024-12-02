.equ ELEM_SIZE, 64; Each element in the array will be this long
.equ ELEM_COUNT, 8000; Let's allocate 1k elems
.equ ROWS, 520

; Go through the rows
; Detect all increasing or decreasing rows
; Make sure each level differs at least 1 and at most 3
; x0 [rows]
; x1 [lengths]
; x2 [total number of rows]
; Returns
; x0 the total points
_calculate_points:
  mov x3, #0; Total points
  mov w4, #0

calculate_outer_loop:
  mov x13, #2; We have a joker per row

  # increment rows by remaining items so we account for skipped vals
  mov x12, #8
  madd x0, x4, x12, x0

  ldrb w4, [x1], #1; Load the current length
  sub w4, w4, #1; We will do n-1, like a sorting algo

  mov x7, #0; ENUM 0 = not specified, 1 = up, 2 = down

calculate_loop:
  ldr x5, [x0], #8; Load the current number
  ldr x6, [x0]; Load the next number

calculate_loop_with_custom_vals:

  subs x8, x6, x5; Get the difference between two numbers, and set the condition flags
  b.EQ calculate_skip_row_with_joker; There has to always be a difference

  neg x9, x8
  cmp x8, #0
  csel x8, x8, x9, GT; Select the positive value
break:

  cmp x8, #3
  b.GT calculate_skip_row_with_joker; If the difference is larger than 3, just skip the row, we don't have to check for zero since we did it already

  ; Let's calculate the direction now

  mov x9, #1; Incrementing enum
  mov x10, #2; Decrementing enum

  subs x8, x6, x5; Get the difference between two numbers again, and set the condition flags
  csel x11, x9, x10, PL; Get the current enum

  cmp x7, #0; Check for not specified enum first
  b.EQ calculate_skip_val; Just skip the current val since this was the first iteration

  cmp x7, x11
  b.ne calculate_skip_row_with_joker; Enums should always be the same since we skipped zero

calculate_skip_val:
  mov x7, x11; Update the enum for next iteration

  subs w4, w4, #1
  b.ne calculate_loop

  add x3, x3, #1; Increment the total score since we came here without skipping
  add x0, x0, #8; We skip the last item

calculate_skip_row:

  ; Set the next val
  subs x2, x2, #1
  b.ne calculate_outer_loop

  mov x0, x3
  ret

calculate_skip_row_with_joker:
  cmp x13, #2
  b.eq calculate_increment_second
calculate_increment_first:
  ldr x5, [x0, #-8]
  ldr x6, [x0, #8]
  b calculate_increment_continue
calculate_increment_second:
  ldr x5, [x0, #-16]
  ldr x6, [x0]
calculate_increment_continue:

  ; Set custom values for current and next vals
  mov x6, x6
  ; If we have a joker, then we loop back
  subs x13, x13, #1
  b.pl calculate_loop_with_custom_vals; Give it another go if we hit a joker
  b calculate_skip_row; We cannot save it from here

_main:
  mov x0, ELEM_COUNT
  mov x1, ELEM_SIZE
  bl _calloc
  mov x19, x0; x19 will have list of numbers with rows

  mov x0, ROWS
  bl _malloc
  mov x20, x0; x20 will have list of lentgths of rows

  mov x0, #0xfffff
  bl _malloc
  mov x21, x0; x21 will have the start addr of stdin
  bl _readStdIn
  mov x22, x0; x22 will have the length of input

  mov x0, x21; stdin
  mov x1, x19; rows
  mov x2, x20; lengths
  mov x3, x22; char count in stdin
  bl _generate_lists
  mov x23, x0; row count

  mov x0, x19; rows
  mov x1, x20; lenghts
  mov x2, x23; row count
  bl _calculate_points

print:
  str x0, [sp, #-16]!
  adr x0, val_burak
  bl _printf
  add sp, sp, #16

exit:
  mov x0, 0 ; status
  bl _exit

.include "list.S"
.include "read.S"
.include "point.S"
.global _main
.align 4

val_burak: .asciz "Result is: %d\n"
val_burak_2: .asciz "123456"
