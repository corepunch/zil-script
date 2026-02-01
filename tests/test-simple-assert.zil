<CONSTANT RELEASEID 1>

<ROUTINE TEST-SIMPLE ()
    <TELL "Testing ASSERT functions..." CR>
    <ASSERT-TRUE T "Test 1: True is true">
    <ASSERT-FALSE <> "Test 2: False is false">
    <TELL "Tests complete!" CR>
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-SIMPLE>>
