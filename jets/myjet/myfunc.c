/*
**
*/
#include "all.h"


static u3_noun
_myfunc(u3_atom a, u3_atom b, u3_atom c)
{
  if ( _(u3a_is_cat(a)) && _(u3a_is_cat(b)) && _(u3a_is_cat(c)) ) {
//    c3_w d = a * b + c;
    c3_w d = a + b * c;			// deliberately wrong for testing

    return u3i_words(1, &d);
  } else {
    return u3k(777);                         // XX
  }
}

u3_noun
myfunc(u3_noun cor)
{
  u3_noun a, b, c;

  fprintf(stderr, "\r\n\njets/myjet/myfunc.c:myfunc(0x%08x)\n\n", cor);

  if ( c3n == u3r_mean(cor, u3x_sam_2, &a, u3x_sam_6, &b, u3x_sam_7, &c, 0) ||
       c3n == u3ud(a) ||
       c3n == u3ud(b) ||
       c3n == u3ud(c) )
    {
//      return u3m_bail(c3__exit);
      return _myfunc(1, 2, 3);               // XX
    }
    else {
      return _myfunc(a, b, c);
    }
}
