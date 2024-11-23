.global _uppercase

// X0, address of the memory to the starting of the text
// X1, Length of the text aka how many bytes of data do we have to convert.
// Returns the same memory address with the data mutated
_uppercase:
  ; X2, current operated char/byte
  ; X3, Read address
  ; X4, Write address
  mov x3, x0 ; load the head for reading
  mov x4, x0 ; load the head for writing
loop:
  ldrb w2, [x3], #1 ; load w2, then increment the read head

  ; Make sure we operate on underscore chars
  cmp w2, #0x61 ; Make sure we're above 'a'
  b.LT continue
  cmp w2, #0x7A ; Make sure we're below 'z'
  b.GT continue

  sub w2, w2, #('a'-'A') ; Do the actual operation

continue:
  strb w2, [x4], #1 ; Store the current char and increment writing head

  subs x1, x1, #1 ; Decrement the length
  b.NE loop ; Loop again if length isn't 0 yet

  ret
