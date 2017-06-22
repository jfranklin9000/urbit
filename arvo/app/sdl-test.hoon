::  ~dirwex-dosrev

::  SDL_INIT_VIDEO  0x00000020

/+  sdl                                                 :: hoon/sdl/lib

!:                                                      :: enable stack traces

|%                                                      :: app molds

::  app state
++  state  $~

::  app commands
++  command
  $%  {$init flags/@uF}
      {$quit $~}
      {$create-window title/@ta x/@s y/@s w/@s h/@s flags/@uF}
  ==

--                                                      :: end molds

|_  {bowl state/state}                                  :: app core

++  poke-noun
  |=  command/command
  ^-  {(list move) _+>.$}
  ~&  command
  ?-  command
  {$init *}
    =+  result=(init:sdl flags.command)
    ~&  [%result result]
    [~ +>.$]
  {$quit $~}
    =+  result=(quit:sdl ~)
    ~&  [%result result]
    [~ +>.$]
  {$create-window *}
    =+  result=(create-window:sdl title.command x.command y.command w.command h.command flags.command)
    ~&  [%result result]
    [~ +>.$]
  ==

--                                                      :: end core
