#ifndef DEBUG_CONSOLE
#define DEBUG_CONSOLE

// put defines here

int
console_init(const char* pipe);

int
console(int unused, const char* format, ...);

void
emit_str(const char* str);

void
emit_noun(u3_noun noun);

void
emit_noun_tree(u3_noun noun);

#endif
