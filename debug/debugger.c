/* Copyright (c) 2015 John Franklin <jfranklin9000@gmail.com> */

// NOTE: this file uses TABS

#include "all.h"

// invoke like this until O_NONBLOCK works
// (./server &) ; (./client)

// yes, we're the server
#define IS_SERVER 1

#define USE_CONSOLE

#ifdef USE_CONSOLE
#define console(unused, ...) console(unused, __VA_ARGS__)
#else
#define console(unused, ...)
#endif

static int initialized = 0;					// debugger initialized?
static int paused = 0;						// urbit paused?

static void process(const char *command)
{
	if (*command == '\0')									// NO COMMAND
	{
		console(0, "no command\n");
	}
	else if (!strcmp(command, "r"))							// RUN OR RESUME
	{
		paused = 0;
	}
	else if (!strcmp(command, "p"))							// PAUSE
	{
		// throw out any input to urbit (console/webtalk) while paused -- fix me
		paused = 1;
	}
	else if (0)
	{
	}
	else													// UNKNOWN COMMAND
	{
		console(0, "unknown command: %s\n", command);
	}
}

void debugger(void)
{
	char command[256];		// should be enough

	if (!initialized)
	{
		console(0, "initializing the debugger ... ");
		open_pipes(IS_SERVER);
		initialized = 1;
		console(0, "done\n");
	}

	do
	{
		// check for command from client
		if (recv_pipe(IS_SERVER, "%s", command) != -1)				// ' ' is like '\n' (fix me)
			process(command);
	}
	while (paused);
}
