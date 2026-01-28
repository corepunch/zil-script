; Test file for source mapping
; This file intentionally has errors to test traceback translation

<ROUTINE TEST-ROUTINE ()
  <PRINC "Starting test">
  <UNKNOWN-FUNCTION>  ; This should cause an error
  <PRINC "Done">
>

<ROUTINE ANOTHER-ROUTINE ()
  <PRINC "Another routine">
  <TEST-ROUTINE>
>
