.global _main
.align 4

// x0 for syscall
// x1 for syscall
// x2 for syscall
// x3 register to print
// x4 for addr to write
// x5 current index of char in the register
// x6 current val
// x7 next val to convert
_main:
  ; fill the x3 register with some data
  mov x3, #0xb00b
  movk x3, #0xf00d, lsl #16
  movk x3, #0xd00d, lsl #32
  movk x3, #0x6969, lsl #48

  adrp x4, hexstr@page
  add x4, x4, #17

  mov x5, #0
loopstart:
  cmp x5, #16
  B.EQ endloop

  ; grab 4 bits and put them to x6
  and x6, x3, 0xF
  lsr x3, x3, #4 ; move the next 4 bits to right

  ; Do conversion to x6
  cmp x6, #10
  b.GE letter
  ;number
  add x6, x6, #'0'
  b end
letter: add x6, x6, #('A'-10)
end:
  ; write to mem
  strb w6, [x4]
  sub x4, x4, #1

  ; do loop stuff
  add x5, x5, #1
  b loopstart
endloop:
print: ; Prints [x1]
  mov x0, #1 ; file descriptor
  adrp x1, hexstr@page ; addr
  mov x2, #19 ; len
  mov x16, #4 ; write
  svc #0x80

exit:
  mov x0, 0 ; status
  mov x16, 1 ; exit
  svc #0x80

.data
hexstr: .ascii "0x123456789ABCDEFG\n"
