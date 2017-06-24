::  ~dirwex-dosrev

::  ~dirwex-dosrev

::::
::::  http://wiki.libsdl.org
::::

::  @uxG is used for pointers

~%  %sdl  ..is  ~                                       :: jetted, no ~& output

|%

::::
::::  http://wiki.libsdl.org/CategoryInit
::::

::  int SDL_Init(Uint32 flags)
::
++  init
  ~/  %init
  |=  flags/@uxF
  ^-  @s
  ~&  [%init flags]
  --0  :: non-jet: success

::  void SDL_Quit(void)
::
++  quit
  ~/  %quit
  |=  $~
  ^-  $~
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
  |=  {title/@ta x/@s y/@s w/@s h/@s flags/@uxF}
  ^-  @uxG
  ::  ~&  [%create-window title x y w h flags]
  0x0  :: non-jet: fail

::  void SDL_DestroyWindow(SDL_Window* window)
::
++  destroy-window
  ~/  %destroy-window
  |=  window/@uxG
  ^-  $~
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
  |=  {window/@uxG index/@s flags/@uxF}
  ^-  @uxG
  ~&  [%create-renderer window index flags]
  0x0  :: non-jet: fail

::  void SDL_DestroyRenderer(SDL_Renderer* renderer)
::
++  destroy-renderer
  ~/  %destroy-renderer
  |=  renderer/@uxG
  ^-  $~
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
  |=  {renderer/@uxG r/@uxD g/@uxD b/@uxD a/@uxD}
  ^-  @s
  ~&  [%set-render-draw-color renderer r g b a]
  --0  :: non-jet: success

::  int SDL_RenderClear(SDL_Renderer* renderer)
::
++  render-clear
  ~/  %render-clear
  |=  renderer/@uxG
  ^-  @s
  ~&  [%render-clear renderer]
  --0  :: non-jet: success


::  int SDL_RenderFillRect(SDL_Renderer*   renderer,
::                         const SDL_Rect* rect)
::
++  render-fill-rect
  ~/  %render-fill-rect
  |=  {renderer/@uxG rect/{x/@s y/@s w/@s h/@s}}  ::
  ^-  @s
  ~&  [%render-fill-rect renderer rect]
  --0  :: non-jet: success


::  void SDL_RenderPresent(SDL_Renderer* renderer)
::
++  render-present
  ~/  %render-present
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1

::  DELAY

--
