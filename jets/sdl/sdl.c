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
  printf("\n\rinit: flags = 0x%08x\n\r", flags);

  return int2pats(SDL_Init(flags));
}

u3_noun
sdl_quit(u3_noun cor)
{
  // printf("\n\rSDL_Quit()\n\r");

  return SDL_Quit(), 0;
}

u3_noun
sdl_create_window(u3_noun cor)
{
  u3_noun title, x, y, w, h, flags;
  char ttl[5] = {0}; // 4 characters + '\0'
  SDL_Window *win;

  u3x_hext(u3r_at(u3x_sam_1, cor), &title, &x, &y, &w, &h, &flags);

  strncpy(ttl, (char *) &title, 4);

  x = pats2int(x); y = pats2int(y); w = pats2int(w); h = pats2int(h);

  printf("\n\rcreate-window: title = %s, x = %d, y = %d, w = %d, h = %d, flags = 0x%08x\n\r",
    ttl, x, y, w, h, flags);

  win = SDL_CreateWindow(ttl, x, y, w, h, flags);

  printf("\n\rcreate-window: win = %p\n\r", win);

  return u3i_chubs(1, (c3_d *) &win);
}

u3_noun
sdl_destroy_window(u3_noun cor)
{
  u3_noun window;
  SDL_Window *win;

  window = u3r_at(u3x_sam_1, cor);
  win = (SDL_Window *) u3r_chub(0, window);

  printf("\n\rdestroy-window: win = %p\n", win);

  return SDL_DestroyWindow(win), 0;
}

u3_noun
sdl_create_renderer(u3_noun cor)
{
  u3_noun window, index, flags;
  SDL_Window *win;
  SDL_Renderer *ren;

  u3x_trel(u3r_at(u3x_sam, cor), &window, &index, &flags);

  win = (SDL_Window *) u3r_chub(0, window);

  index = pats2int(index);

  printf("\n\rcreate-renderer: win = %p, index = %d, flags = 0x%08x\n", win, index, flags);

  ren = SDL_CreateRenderer(win, index, flags);

  printf("\n\rcreate-renderer: ren = %p\n\r", ren);

  return u3i_chubs(1, (c3_d *) &ren);
}

u3_noun
sdl_destroy_renderer(u3_noun cor)
{
  u3_noun renderer;
  SDL_Renderer *ren;

  renderer = u3r_at(u3x_sam_1, cor);
  ren = (SDL_Renderer *) u3r_chub(0, renderer);

  printf("\n\rdestroy-renderer: ren = %p\n", ren);

SDL_Delay(5000);

  return SDL_DestroyRenderer(ren), 0;
}

u3_noun
sdl_set_render_draw_color(u3_noun cor)
{
  u3_noun renderer, r, g, b, a;
  SDL_Renderer *ren;

//u3_noun retval;

  u3x_quil(u3r_at(u3x_sam, cor), &renderer, &r, &g, &b, &a);

  ren = (SDL_Renderer *) u3r_chub(0, renderer);

  printf("\n\rset-render-draw-color: ren = %p, r = 0x%02x, g = 0x%02x, b = 0x%02x, a = 0x%02x\n\r",
    ren, r, g, b, a);

/*
retval = int2pats(SDL_SetRenderDrawColor(ren, r, g, b, a));
SDL_RenderClear(ren);
SDL_RenderPresent(ren);

  return retval; // int2pats(SDL_SetRenderDrawColor(ren, r, g, b, a));
*/
  return int2pats(SDL_SetRenderDrawColor(ren, r, g, b, a));
}

u3_noun
sdl_render_clear(u3_noun cor)
{
  u3_noun renderer;
  SDL_Renderer *ren;

u3_noun retval;

  renderer = u3r_at(u3x_sam_1, cor);
  ren = (SDL_Renderer *) u3r_chub(0, renderer);

  printf("\n\rrender-clear: ren = %p\n", ren);

retval = int2pats(SDL_RenderClear(ren));
SDL_RenderPresent(ren);

  return retval; // int2pats(SDL_RenderClear(ren));
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
