#include <SDL.h>
#include "all.h"

/*
  ++  new  |=  {a/? b/@}                                ::  [sign value] to @s
           `@s`?:(a (mul 2 b) ?:(=(0 b) 0 +((mul 2 (dec b)))))
*/

static int tc(int n)    // two's complement
{
  return ~n + 1;
}

// there's probably already a function that does this
// (this function, and its callers, assume direct atoms)
static int
pats2int(u3_atom a)    // @s to int
{
  if (a == 0)
    return 0;
  else if (!(a & 1))    // no sign bit
    return a / 2;
  else
    return tc((a + 1) / 2);
}

// same as above
static u3_atom
int2pats(int i)    // int to @s
{
  if (i == 0)
    return 0;
  else if (!(i & 0x80000000))    // no sign bit
    return i * 2;
  else
    return 2 * (tc(i) - 1) + 1;
}

// do transfer/retain analysis

u3_noun
sdl_init(u3_noun cor)
{
  u3_noun flags;

  flags = u3r_at(u3x_sam, cor);
  // printf("\n\rflags = 0x%08x\n\r", flags);

  return int2pats(SDL_Init(flags));
}

u3_noun
sdl_quit(u3_noun cor)
{
  // printf("\n\rSDL_Quit()\n\r");

  return SDL_Quit(), 0;
}

u3_noun													// fix me
sdl_create_window(u3_noun cor)
{
  u3_noun title, x, y, w, h, flags;
  char ttl[5] = {0}; // 4 characters + '\0'
  SDL_Window *win;

  u3x_hext(u3r_at(u3x_sam_1, cor), &title, &x, &y, &w, &h, &flags);

  strncpy(ttl, (char *) &title, 4);

  x = pats2int(x); y = pats2int(y); w = pats2int(w); h = pats2int(h);

  printf("\n\rtitle = %s, x = %d, y = %d, w = %d, h = %d, flags = 0x%08x\n\r",
    ttl, x, y, w, h, flags);

  win = SDL_CreateWindow(ttl, x, y, w, h, flags);

  printf("win = %p\n\r", win);

//  SDL_DestroyWindow(win);

  return -1;
}

u3_noun													// fix me
sdl_destroy_window(u3_noun cor)
{
  u3_noun window;
  SDL_Window *win;

  window = u3r_at(u3x_sam_1, cor);
  win = (SDL_Window *) window;
  printf("\n\rwindow = %p\n", win);       // fix type (pointer)

return 0;  // until sdl_create_window() works (bail: oops)

  return SDL_DestroyWindow(win), 0;       // and here
}

u3_noun													// fix me
sdl_create_renderer(u3_noun cor)
{
  u3_noun window, index, flags;

  u3r_mean(cor, u3x_sam_2, &window, u3x_sam_6, &index, u3x_sam_7, &flags, 0);

  printf("\n\rwindow = %p, index = %d, flags = 0x%08x\n", window, index, flags);

  return -1;
}

u3_noun													// fix me
sdl_destroy_renderer(u3_noun cor)
{
  u3_noun renderer;
  SDL_Renderer *ren;

  renderer = u3r_at(u3x_sam_1, cor);
  ren = (SDL_Renderer *) renderer;
  printf("\n\rrenderer = %p\n", ren);       // fix type (pointer)

return 0;  // until sdl_create_renderer() works (bail: oops)

  return SDL_DestroyRenderer(ren), 0;       // and here
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
