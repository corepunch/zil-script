;"Test for local variable naming conflicts"

<ROUTINE PROB (N)
  <TELL "PROB function called with " .N CR>>

<ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X)
  <SET X 10>
  <SET N 20>
  <COND (<OR <NOT .PROB> <PROB .PROB>>
    <TELL "Test passed!" CR>)
    (ELSE <TELL "Test failed!" CR>)>>
