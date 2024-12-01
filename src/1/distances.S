; x0 [list a]
; x1 [list b]
; x2 length
; Returns
; x0 sum of differences
_distances:
  mov x5, 0

distances_loop:
  ldr x3, [x0], #8
  ldr x4, [x1], #8

  sub x6, x3, x4
  neg x7, x6
  cmp x6, #0
  csel x6, x6, x7, GT
  add x5, x5, x6
  ; Add the absolute difference between two

  subs x2, x2, #1
  b.NE distances_loop

  mov x0, x5
  ret
