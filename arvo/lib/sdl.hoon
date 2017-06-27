::  ~dirwex-dosrev

::::
::::  http://wiki.libsdl.org
::::

::  C types in Hoon
/-  c                                                   :: /hoon/c/sur

~%  %sdl  ..is  ~                                       :: jetted, no ~& output

|%

::::
::::  http://wiki.libsdl.org/CategoryInit
::::

::  int SDL_Init(Uint32 flags)
::
++  init
  ~/  %init
  |=  flags/u32:c
  ^-  int:c
  ~&  [%init flags]
  --0  :: non-jet: success

::  void SDL_Quit(void)
::
++  quit
  ~/  %quit
  |=  void:c
  ^-  void:c
  ~&  [%quit ~]
  ~  :: non-jet: void

::::
::::  http://wiki.libsdl.org/CategoryVideo
::::

::  SDL_Window* SDL_CreateWindow(const char* title,
::                               int         x,
::                               int         y,
::                               int         w,
::                               int         h,
::                               Uint32      flags)
::
++  create-window
  ~/  %create-window
  |=  {title/@ta x/int:c y/int:c w/int:c h/int:c flags/u32:c}
  ^-  ptr:c
  ~&  [%create-window title x y w h flags]
  0x0  :: non-jet: fail

::  void SDL_DestroyWindow(SDL_Window* window)
::
++  destroy-window
  ~/  %destroy-window
  |=  window/ptr:c
  ^-  void:c
  ~&  [%destroy-window window]
  ~  :: non-jet: void

::::
::::  http://wiki.libsdl.org/CategoryRender
::::

::  SDL_Renderer* SDL_CreateRenderer(SDL_Window* window,
::                                   int         index,
::                                   Uint32      flags)
::
++  create-renderer
  ~/  %create-renderer
  |=  {window/ptr:c index/int:c flags/u32:c}
  ^-  ptr:c
  ~&  [%create-renderer window index flags]
  0x0  :: non-jet: fail

::  void SDL_DestroyRenderer(SDL_Renderer* renderer)
::
++  destroy-renderer
  ~/  %destroy-renderer
  |=  renderer/ptr:c
  ^-  void:c
  ~&  [%destroy-renderer renderer]
  ~  :: non-jet: void

::  int SDL_SetRenderDrawColor(SDL_Renderer* renderer,
::                             Uint8         r,
::                             Uint8         g,
::                             Uint8         b,
::                             Uint8         a)
::
++  set-render-draw-color
  ~/  %set-render-draw-color
  |=  {renderer/ptr:c r/u8:c g/u8:c b/u8:c a/u8:c}
  ^-  int:c
  ~&  [%set-render-draw-color renderer r g b a]
  --0  :: non-jet: success

::  int SDL_RenderClear(SDL_Renderer* renderer)
::
++  render-clear
  ~/  %render-clear
  |=  renderer/ptr:c
  ^-  int:c
  ~&  [%render-clear renderer]
  --0  :: non-jet: success

::  int SDL_RenderFillRect(SDL_Renderer*   renderer,
::                         const SDL_Rect* rect)
::
++  render-fill-rect
  ~/  %render-fill-rect
  |=  {renderer/ptr:c rect/{x/int:c y/int:c w/int:c h/int:c}}
  ^-  int:c
  ~&  [%render-fill-rect renderer rect]
  --0  :: non-jet: success

::  void SDL_RenderPresent(SDL_Renderer* renderer)
::
++  render-present
  ~/  %render-present
  |=  renderer/ptr:c
  ~&  [%render-present renderer]
  ~  :: non-jet: void

::::
::::  http://wiki.libsdl.org/CategoryTimer
::::

::  void SDL_Delay(Uint32 ms)
::
++  delay
  ~/  %delay
  |=  ms/u32:c
  ^-  void:c
  ~&  [%delay ms]
  ~  :: non-jet: void

--
