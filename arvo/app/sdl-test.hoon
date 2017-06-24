::  ~dirwex-dosrev

::  SDL_INIT_VIDEO           0x20
::  SDL_WINDOW_SHOWN         0x4
::  SDL_WINDOWPOS_UNDEFINED  536.805.376

::  :sdl-test [%init 0x20]
::  :sdl-test [%create-window %sdl --536.805.376 --536.805.376 --640 --480 0x4]
::  :sdl-test [%create-renderer --777 -1 0]             :: window = --777 :: fix

::  :sdl-test [%destroy-renderer --888]                 :: renderer = --888 :: fix
::  :sdl-test [%destroy-window --777]                   :: window = --777 :: fix
::  :sdl-test [%quit ~]

/+  sdl                                                 :: /hoon/sdl/lib

!:                                                      :: enable stack traces

|%                                                      :: app molds

::  app state
++  state  $~

::  app commands
++  command
  $%  {$init flags/@uF}
      {$quit $~}
      {$create-window title/@ta x/@s y/@s w/@s h/@s flags/@uF}
      {$destroy-window window/@s}                       :: needs to be a pointer
      {$create-renderer window/@s index/@s flags/@uF}   :: window needs to be pointer
      {$destroy-renderer renderer/@s}                   :: needs to be a pointer
      ::
      {$proggy $~}
  ==

:: SDL_GetError ?

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
  {$destroy-window *}
    =+  result=(destroy-window:sdl window.command)
    ~&  [%result result]
    [~ +>.$]
  {$create-renderer *}
    =+  result=(create-renderer:sdl window.command index.command flags.command)
    ~&  [%result result]
    [~ +>.$]
  {$destroy-renderer *}
    =+  result=(destroy-renderer:sdl renderer.command)
    ~&  [%result result]
    [~ +>.$]
  ::
  {$proggy $~}
    :: init sdl
    =+  result=(init:sdl 0x20)           :: combine..
    ?:  !=(result --0)                   :: ..with this?
      ~&  [%sdl-init-error result]
      [~ +>.$]
    :: create window (title should be 4 characters or less please)
    =+  win=(create-window:sdl %prog --536.805.376 --536.805.376 --640 --480 0x4)     :: add /@u ?
    ?:  =(win 0x0)
      ~&  [%sdl-create-window-error win]
      [~ +>.$]
    [~ +>.$]
  ==

--                                                      :: end core
