::  ~dirwex-dosrev

::  SDL_INIT_VIDEO           0x20
::  SDL_WINDOW_SHOWN         0x4
::  SDL_WINDOWPOS_UNDEFINED  536.805.376

::  %proggy
::  :sdl-test [%init 0x20]
::  :sdl-test [%create-window %sdl --536.805.376 --536.805.376 --640 --480 0x4]
::  :sdl-test [%create-renderer <window> -1 0x0]
::  :sdl-test [%set-render-draw-color <renderer> 0x80 0x80 0x80 0xff]
::  :sdl-test [%render-clear <renderer>]
::  :sdl-test [%set-render-draw-color <renderer> 0xff 0x8c 0x69 0xff]
::  :sdl-test [%render-fill-rect <renderer> [--120 --100 --200 --200]]
::  :sdl-test [%set-render-draw-color <renderer> 0x54 0xff 0x9f 0xff]
::  :sdl-test [%render-fill-rect <renderer> [--220 --150 --200 --200]]
::  :sdl-test [%set-render-draw-color <renderer> 0xad 0xd8 0xe6 0xff]
::  :sdl-test [%render-fill-rect <renderer> [--320 --200 --200 --200]]
::  :sdl-test [%render-present <renderer>]

::  delay

::  :sdl-test [%destroy-renderer <renderer>]
::  :sdl-test [%destroy-window <window>]
::  :sdl-test [%quit ~]

/+  sdl                                                 :: /hoon/sdl/lib

!:                                                      :: enable stack traces

|%                                                      :: app molds

::  app state
++  state  $~

::  app commands
++  command
  $%  {$init flags/@uxF}
      {$quit $~}
      {$create-window title/@ta x/@s y/@s w/@s h/@s flags/@uxF}
      {$destroy-window window/@uxG}
      {$create-renderer window/@uxG index/@s flags/@uxF}
      {$destroy-renderer renderer/@uxG}
      {$set-render-draw-color renderer/@uxG r/@uxD g/@uxD b/@uxD a/@uxD}
      {$render-clear renderer/@uxG}
      {$render-fill-rect renderer/@uxG rect/{x/@s y/@s w/@s h/@s}}
      {$render-present renderer/@uxG}
      ::
      {$proggy $~}
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
  {$set-render-draw-color *}
    =+  result=(set-render-draw-color:sdl renderer.command r.command g.command b.command a.command)
    ~&  [%result result]
    [~ +>.$]
  {$render-clear *}
    =+  result=(render-clear:sdl renderer.command)
    ~&  [%result result]
    [~ +>.$]
  {$render-fill-rect *}
    =+  result=(render-fill-rect:sdl renderer.command rect.command)
    ~&  [%result result]
    [~ +>.$]
  {$render-present *}
    =+  result=(render-present:sdl renderer.command)
    ~&  [%result result]
    [~ +>.$]
  ::
  {$proggy $~}
    :: init sdl
    =+  result=(init:sdl 0x20)           :: combine..
    ?:  !=(result --0)                   :: ..with this?
      ~&  [%sdl-init-error result]
      [~ +>.$]
    ::
    ::  if we fail any of these we don't properly cleanup
    ::  like the proggy in main() does..
    ::
    :: create window (title should be 4 characters or less please)
    =+  win=(create-window:sdl %prog --536.805.376 --536.805.376 --640 --480 0x4)
    ?:  =(win 0x0)
      ~&  [%sdl-create-window-error win]
      [~ +>.$]
    =+  ren=(create-renderer:sdl win -1 0x0)

    ::  how to reuse result?
    =+  result2=(set-render-draw-color:sdl ren 0x80 0x80 0x80 0xff)
    ?:  !=(result2 --0)
      ~&  [%sdl-set-render-draw-color-error result2]
      [~ +>.$]

    ::  reuse result, again
    =+  result3=(render-clear:sdl ren)
    ?:  !=(result3 --0)
      ~&  [%sdl-render-clear-error result3]
      [~ +>.$]

    ::  reuse result, again
    =+  result4=(set-render-draw-color:sdl ren 0xff 0x8c 0x69 0xff)
    ?:  !=(result4 --0)
      ~&  [%sdl-set-render-draw-color-error result4]
      [~ +>.$]

    ::  reuse result, again
    =+  result5=(render-fill-rect:sdl ren [--120 --100 --200 --200])
    ?:  !=(result5 --0)
      ~&  [%sdl-render-fill-rect-error result5]
      [~ +>.$]

    ::  reuse result, again
    =+  result6=(set-render-draw-color:sdl ren 0x54 0xff 0x9f 0xff)
    ?:  !=(result6 --0)
      ~&  [%sdl-set-render-draw-color-error result6]
      [~ +>.$]

    ::  reuse result, again
    =+  result7=(render-fill-rect:sdl ren [--220 --150 --200 --200])
    ?:  !=(result7 --0)
      ~&  [%sdl-render-fill-rect-error result7]
      [~ +>.$]

    ::  reuse result, again
    =+  result8=(set-render-draw-color:sdl ren 0xad 0xd8 0xe6 0xff)
    ?:  !=(result8 --0)
      ~&  [%sdl-set-render-draw-color-error result8]
      [~ +>.$]

    ::  reuse result, again
    =+  result9=(render-fill-rect:sdl ren [--320 --200 --200 --200])
    ?:  !=(result9 --0)
      ~&  [%sdl-render-fill-rect-error result9]
      [~ +>.$]

    ::  what's a better way to do these?
    ~&  [%render-present (render-present:sdl ren)]
    ~&  [%destroy-renderer (destroy-renderer:sdl ren)]
    ~&  [%destroy-window (destroy-window:sdl win)]
    ~&  [%quit (quit:sdl ~)]

    [~ +>.$]
  ==

--                                                      :: end core
