; Reads std in to the given address
_readStdIn:
  str lr, [SP, #-16]!
  stp x19, x20, [SP, #-16]!
  mov x19, x0
  mov x20, x0
read_again:
  mov x0, #0 ;File Descriptor is 0 which is stdin
  mov x1, x19 ;Pass the address to the read call
  mov x2, #256 ;Read 256 bytes at once. This is an arbitrary value
  bl _read

  add x19, x19, x0 ;Increment the address

  cmp x0, #0
  b.NE read_again

  mov x0, x20 ;Write the return address
  ldp x19, x20, [SP], #16 ;Restore x19
  ldr lr, [SP], #16 ;Restore x19
  ret
