<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room for clock system testing.")
      (FLAGS RLANDBIT ONBIT)>

<ROUTINE TEST-INTERRUPT ()
  <TELL "Interrupt fired!" CR>
  T>

<ROUTINE TEST-DEMON ()
  <TELL "Demon fired!" CR>
  T>
