## NOTE: This branch MISUSES jets as an FFI and is only for exploration.

### No noun transfer/retain analysis has been done on the jets.
### Some jets probably leak memory.

#### Build

````
git clone https://github.com/jfranklin9000/urbit.git -b maint-SDL2 --single-branch urbit-maint-SDL2

cd urbit-maint-SDL2

make
````

#### Run

It's a good idea to use a comet for this.  The `Makefile` has a
useful rule that assumes `comet-maint-SDL2` is the comet
(see below).

````
bin/urbit -c comet-maint-SDL2
````

You will see a window with three rectangles pop up for 5 seconds
before Urbit boots.  This is not from the jets, it's a small SDL
program at the start of `main()`.

Mount the `%home` desk

````
|mount /=home=
````

#### Quit

````
^d
````

`Makefile` has target `copy-sdl-test-files` that copies
`arvo/lib/sdl.hoon` and `arvo/app/sdl-test.app` to `%home`.

````
make copy-sdl-test-files
````

#### Restart

````
bin/urbit comet-maint-SDL2
````

Start app and poke it

````
|start %sdl-test

:sdl-test [%proggy ~]
````

You will see a window with three rectangles pop up for 5 seconds.
