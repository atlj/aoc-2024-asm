.include "fileio.S"
.global _main
.align 4

.equ BUFFER_LENGTH, 0x100000
.equ END_OF_FILE, 0
.equ READ_AMOUNT, 256

_main:
  adrp x20, input@page ;Set the read address
  mov x19, #0 ;Set the initial read length

read_again:
  read_stdin x20, READ_AMOUNT ;read an arbitrary amount of data, IDK the max size yet
  add x20, x20, x0 ;Increment the read address
  add x19, x19, x0 ;Increment the total len
  cmp x0, END_OF_FILE
  b.NE read_again ;Read again if we'rent the EOF yet.

  mov x0, x19 ;set the loop count
  adrp x1, input@page ;set the initial read head
  adrp x2, output@page ;set the initial write head
loop:
  ldrb w3, [x1], #1 ;Get the current char

  cmp w3, 'a'
  b.LT continue
  cmp w3, 'z'
  b.GT continue

  add w3, w3, #('A'-'a')

continue:
  strb w3, [x2], #1 ;Store the current char
  subs x0, x0, #1
  b.NE loop ;Keep looping until we read everything.

burak:
  print output@page, x19

exit:
  mov x0, 0 ; status
custom_exit:
  mov x16, 1 ; exit
  svc #0x80

.data
input: .fill BUFFER_LENGTH + 1, 1, 0
output: .fill BUFFER_LENGTH + 1, 1, 0
