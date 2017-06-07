::                                                      :: comment - column 57
::
:: https://github.com/Fang-/Urbit-By-Doing/blob/master/talkbot/2.md
::
/+  myjet                                               :: lib/myjet/hoon
::
!:                                                      :: enable stack traces (not in docs)
|_  {bowl state/$~}
++  poke-noun
  |=  {a/@ b/@ c/@}
  ^-  {(list move) _+>.$}
  ~&  [%myjet-myfunc (myfunc:myjet a b c)]
  [~ +>.$]
--
