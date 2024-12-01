; x0 [list]
; x1 length
_bubble_sort:
  mov x6, x0
  mov x5, x1
bubble_outer_loop:
  sub x5, x5, #1

  mov x1, x5; Set the count for inner loop
  mov x0, x6; Set the initial memory address
bubble_loop:
  ldr x2, [x0]; Current val
  ldr x3, [x0, #8]; Next val

  cmp x2, x3
  b.LE bubble_continue

  mov x4, x2
  mov x2, x3
  mov x3, x4

  str x2, [x0]

bubble_continue:
  str x3, [x0, #8]!

  subs x1, x1, #1
  b.NE bubble_loop
  cmp x5, #1
  b.NE bubble_outer_loop

  ret
