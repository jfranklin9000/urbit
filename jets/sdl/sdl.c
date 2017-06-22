#include <SDL.h>
#include "all.h"

u3_noun
sdl_init(u3_noun cor)
{
  u3_noun flags;

  flags = u3r_at(u3x_sam_1, cor);
  // printf("\n\rflags = 0x%08x\n", flags);

  return SDL_Init(flags);
}

u3_noun
sdl_quit(u3_noun cor)
{
  // printf("\n\rSDL_Quit()\n");

  return SDL_Quit(), 0;
}

u3_noun
sdl_create_window(u3_noun cor)
{
  u3_noun title, x, y, w, h, flags;

/*
  title = u3r_at(u3x_sam_2, cor);
  x     = u3r_at(u3x_sam_6, cor);
  y     = u3r_at(u3x_sam_7, cor);
*/
  u3r_mean(cor, u3x_sam_1, &title, u3x_sam_2, &x, u3x_sam_3, &y, 0);
  u3r_mean(cor, u3x_sam_4, &w, u3x_sam_5, &h, u3x_sam_6, &flags, 0);

  printf("\n\rtitle = %d, x = %d, y = %d, w = %d, h = %d, flags = 0x%08x\n",
    title, x, y, w, h, flags);

  return -1;
}

u3_noun
sdl_destroy_window(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_create_renderer(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_destroy_renderer(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_set_render_draw_color(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_render_clear(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_render_fill_rect(u3_noun cor)
{
  return -1;
}

u3_noun
sdl_render_present(u3_noun cor)
{
  return -1;
}
