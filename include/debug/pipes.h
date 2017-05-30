/* Copyright (c) 2015 John Franklin <jfranklin9000@gmail.com> */

int open_pipes(int is_server);
int send_pipe(int is_server, const char *format, ...);
int recv_pipe(int is_server, const char *format, ...);
