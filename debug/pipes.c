/* Copyright (c) 2015 John Franklin <jfranklin9000@gmail.com> */

// NOTE: this file uses TABS

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

// invoke like this if NON_BLOCKING is 0
// (./server &) ; (./client)
#define NON_BLOCKING 1
// opening for write and non-blocking while nothing is reading:
// "Device not configured (errno = 6)" - fix me

// mkfifo SERVER_RD
// mkfifo SERVER_WR
#define SERVER_RD		"/Users/jmf/URBIT/SERVER_RD"		// server reads from, client writes to
#define SERVER_WR		"/Users/jmf/URBIT/SERVER_WR"		// server writes to, client reads from

// open() so we can specify O_NONBLOCK
static int server_rd_fd;
static int server_wr_fd;

// fdopen() so we can use stream interface
static FILE *server_rd_fp;
static FILE *server_wr_fp;

int open_pipes(int is_server)
{
	int server_rd_flag, server_wr_flag;
	const char *server_rd_mode, *server_wr_mode;

	if (is_server)
	{
		server_rd_flag = O_RDONLY;
		server_wr_flag = O_WRONLY;
		server_rd_mode = "r";
		server_wr_mode = "w";
	}
	else
	{
		server_rd_flag = O_WRONLY;
		server_wr_flag = O_RDONLY;
		server_rd_mode = "w";
		server_wr_mode = "r";
	}

	if (NON_BLOCKING)
	{
		// only for O_RDONLY - fix me

		if (is_server)
			server_rd_flag |= O_NONBLOCK;
		else
			server_wr_flag |= O_NONBLOCK;
	}

	if ((server_rd_fd = open(SERVER_RD, server_rd_flag)) == -1)
	{
		fprintf(stderr, "open(%s, 0x%04x) failed: %s (errno = %d)\n", SERVER_RD, server_rd_flag, strerror(errno), errno);
		exit(1);
	}

	if ((server_rd_fp = fdopen(server_rd_fd, server_rd_mode)) == NULL)
	{
		fprintf(stderr, "fdopen(server_rd_fd, %s) failed: %s (errno = %d)\n", server_rd_mode, strerror(errno), errno);
		exit(1);
	}

	if (setlinebuf(server_rd_fp) == -1)
	{
		fprintf(stderr, "setlinebuf(server_rd_fp) failed: %s (errno = %d)\n", strerror(errno), errno);
		exit(1);
	}

	if ((server_wr_fd = open(SERVER_WR, server_wr_flag)) == -1)
	{
		fprintf(stderr, "open(%s, 0x%04x) failed: %s (errno = %d)\n", SERVER_WR, server_wr_flag, strerror(errno), errno);
		exit(1);
	}

	if ((server_wr_fp = fdopen(server_wr_fd, server_wr_mode)) == NULL)
	{
		fprintf(stderr, "fdopen(server_wr_fd, %s) failed: %s (errno = %d)\n", server_wr_mode, strerror(errno), errno);
		exit(1);
	}

	if (setlinebuf(server_wr_fp) == -1)
	{
		fprintf(stderr, "setlinebuf(server_wr_fp) failed: %s (errno = %d)\n", strerror(errno), errno);
		exit(1);
	}

	return 0;
}

int send_pipe(int is_server, const char *format, ...)
{
	va_list ap;
	int retval;

	va_start(ap, format);
	retval = vfprintf(is_server ? server_wr_fp : server_rd_fp, format, ap);
	va_end(ap);

	return retval;
}

int recv_pipe(int is_server, const char *format, ...)
{
	va_list ap;
	int retval;

	va_start(ap, format);
	retval = vfscanf(is_server ? server_rd_fp : server_wr_fp, format, ap);
	va_end(ap);

	return retval;
}
