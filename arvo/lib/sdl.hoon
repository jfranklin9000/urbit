::  ~dirwex-dosrev

::::
::::  http://wiki.libsdl.org
::::

~%  %sdl  ..is  ~ 

|%

::::
::::  http://wiki.libsdl.org/CategoryInit
::::

::  int SDL_Init(Uint32 flags)
::
++  init
  ~/  %init
  |=  flags/@uF
  ^-  @s
  ::  ~&  [%init flags]
  -1

::  void SDL_Quit(void)
::
++  quit
  ~/  %quit
  |=  $~
  ^-  $~
  ::  ~&  [%quit ~]
  ~

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
  |=  {title/@ta x/@s y/@s w/@s h/@s flags/@uF}
  ^-  @s                                                :: needs to be a pointer
  ~&  [%create-window title x y w h flags]
  -1                                                   :: ibid

::  void SDL_DestroyWindow(SDL_Window* window)
::
++  destroy-window
  ~/  %destroy-window
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1

::::
::::  http://wiki.libsdl.org/CategoryRender
::::

::  SDL_Renderer* SDL_CreateRenderer(SDL_Window* window,
::                                   int         index,
::                                   Uint32      flags)
::
++  create-renderer
  ~/  %create-renderer
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1

::
::  XXX
::
++  destroy-renderer
  ~/  %destroy-renderer
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1


::
++  set-render-draw-color
  ~/  %set-render-draw-color
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1



++  render-clear
  ~/  %render-clear
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1

++  render-present
  ~/  %render-present
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1



++  render-fill-rect
  ~/  %render-fill-rect
  |=  flags/@u                                          :: mold is a stub
  ^-  @s
  -1

--
