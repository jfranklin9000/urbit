
// how much of this do i need?
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <setjmp.h>
#include <signal.h>
#include <gmp.h>
#include <stdint.h>
#include <errno.h>
/*
#include <uv.h>
#include <sigsegv.h>
#include <curses.h>
#include <termios.h>
#include <term.h>
#include <dirent.h>
*/

#define U3_GLOBAL
#define C3_GLOBAL
#include "all.h"
//#include "vere/vere.h"

// these should go in header file
#define USE_CONSOLE

// FP -> file pointer (fopen(), etc), FD -> file descriptor (open(), etc)
#define USE_FP

#ifdef USE_CONSOLE			// enclose whole file in this, no just protect console_init() and console()

// make static?
#ifdef USE_FP
FILE *console_fp = NULL;
#else // FD
int console_fd = -1;
#endif

// Something must be reading the pipe or the console blocks urbit.
// $ mkfifo /path/to/pipe
// $ tail -f /path/to/pipe

int
console_init(const char* pipe)
{
  // mkfifo CONSOLE

  if (pipe == NULL)
    pipe = "/Users/jmf/URBIT/CONSOLE";

#ifdef USE_FP

  console_fp = fopen(pipe, "w");

  if (console_fp == NULL)
  {
    fprintf(stderr, "could not fopen %s for writing, errno = %d\n", pipe, errno);
    exit(1);
  }

  // do not buffer the output
  setvbuf(console_fp, NULL, _IONBF, 0);

#else // FD

  // not recently tested........ (all FD stuff)

  console_fd = open(pipe, O_WRONLY);

  if (console_fd == -1)
  {
    fprintf(stderr, "could not open %s for writing, errno = %d\n", pipe, errno);
    exit(1);
  }

#endif

  console(0, "\n\n=====\nURBIT\n=====\n");

  return 0;
}

int
console(int unused, const char* format, ...)
{
  va_list ap;
  int retval;

  va_start(ap, format);

#ifdef USE_FP
  retval = vfprintf(console_fp, format, ap);
#else // FD
  // fix me
#endif

  va_end(ap);

  return retval;
}

/*
    does not emit a newline (unless part of str)
*/
void
emit_str(const char* str)
{
  console(0, "%s", str);
}

/*
    does not emit a newline
*/
void
emit_noun(u3_noun noun)
{
// use u3a_is_pug() and u3a_is_pom() (allocate.h) -- fix me

  if (!(noun & 0x80000000)) // direct atom
  {
    //console(0, "0x%08x <cat>", noun);
    // heuristic: assume is a number (what about negative integers?)
    console(0, "%d <d-atom>", noun);							// cat
  }
  else if (!(noun & 0x40000000)) // indirect atom
  {
    console(0, "0x%08x <i-atom>", noun & 0x3fffffff);			// pug
  }
  else // indirect cell
  {
    console(0, "0x%08x <i-cell>", noun & 0x3fffffff);			// pom
  }
}

int total_cells = 0;
int total_atoms = 0;

#undef PRINT_TREE

void
emit_noun_tree(u3_noun noun)
{
  static int indent = 0;

#ifdef PRINT_TREE
  int i;

  for (i = 0; i < indent; i++)
    console(0, " ");
#endif

  if (_(u3a_is_pom(noun)))				// indirect cell (pom)
  {
    u3a_cell* cell = (u3a_cell*) u3a_into(u3a_to_off(noun));

#ifdef PRINT_TREE
    console(0, "0x%08x <i-cell>\n", u3a_to_off(noun));
#endif
    total_cells++;

    indent++;
    emit_noun_tree(cell->hed);
    emit_noun_tree(cell->tel);
    indent--;
  }
  else if (_(u3a_is_pug(noun)))			// indirect atom (pug)
  {
    u3a_atom* atom = (u3a_atom*) u3a_into(u3a_to_off(noun));
    (void) atom;
#ifdef PRINT_TREE
    // console(0, "0x%08x <i-atom>\n", u3a_to_off(noun));
    console(0, "%s\n", atom->buf_w);
#endif
    total_atoms++;
  }
  else									// direct atom (cat)
  {
#ifdef PRINT_TREE
    // console(0, "%d <d-atom>\n", noun);
    console(0, "%d\n", noun);
#endif
    total_atoms++;
  }
}

#else

  // not using console

#endif
