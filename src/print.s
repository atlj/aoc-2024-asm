.global _print

; x0, print address
; x1, length
_print:
  mov x2, x1 ; len
  mov x1, x0 ; start addr
  mov x0, #1 ; file descriptor = stdout
  mov x16, #4 ; write syscall code
  svc #0x80 ; call supervisor
  ret
