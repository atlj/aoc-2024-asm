.global _main
.align 4

; x4, start addr
_main:
  adrp x4, hellostr@page
  mov x5, #10 ; we don't care about other chars
  ldrb w6, [x4]
loop:
  ; we will check between
  cmp w6, #0x61
  b.LT continue
  cmp w6, #0x7A
  b.GT continue
  sub w6, w6, #('a'-'A')
  strb w6, [x4]
continue:
  ldrb w6, [x4, #1]!
  subs x5, x5, #1
  b.NE loop
print: ; Prints [x1]
  mov x0, #1 ; file descriptor
  adrp x1, hellostr@page ; addr
  mov x2, #12 ; len
  mov x16, #4 ; write
  svc #0x80

exit:
  mov x0, 0 ; status
  mov x16, 1 ; exit
  svc #0x80

.data
hellostr: .ascii "hello mom!\n"
