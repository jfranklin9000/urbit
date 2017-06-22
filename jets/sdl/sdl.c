#include <SDL.h>
#include "all.h"

u3_noun
sdl_init(u3_noun cor)
{
  u3_noun flags;

  flags = u3r_at(u3x_sam, cor);
  // printf("\nflags = 0x%08x\n", flags);

  return SDL_Init(flags);
}

u3_noun
sdl_quit(u3_noun cor)
{
  // printf("\nSDL_Quit()\n");

  return SDL_Quit(), 0;
}

//u3_noun sdl_create_window(u3_noun, u3_noun, u3_noun, u3_noun, u3_noun, u3_noun);

u3_noun
sdl_create_window(u3_noun cor)
{
  return u3k(999);                         // XX
}
