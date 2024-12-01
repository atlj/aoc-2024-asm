; x0 [list a]
; x1 [list b]
; x2 length
; Returns
; x0 total similiarity score
_similiarity:
  mov x5, x1; Backup the listb's start address
  mov x7, #0; Return value
  mov x8, x2; Backup the len for listb
similiarity_outer_loop:
  mov x6, #0; Current amount
  mov x9, x8; Reset inner loop
  mov x1, x5; Reset list b address to zero
  ldr x3, [x0], #8

similiarity_loop:
  ldr x4, [x1], #8
  cmp x3, x4
  cinc x6, x6, EQ

  subs x9, x9, #1
  b.NE similiarity_loop

  madd x7, x3, x6, x7

  subs x2, x2, #1
  b.NE similiarity_outer_loop

  mov x0, x7
  ret
