
unames := $(shell uname -s)
ifeq ($(unames), Darwin)
	CC = clang
	sdlflags = -framework SDL2 -F sdl2 -rpath @executable_path/sdl2
else
	CC = gcc
	sdlflags = `sdl2-config --cflags --libs`
endif

CFLAGS = -O3 -I ./snes

execname = lakesnes

cfiles = snes/spc.c snes/dsp.c snes/apu.c snes/cpu.c snes/dma.c snes/ppu.c snes/cart.c snes/input.c snes/snes.c snes/snes_other.c main.c
hfiles = snes/spc.h snes/dsp.h snes/apu.h snes/cpu.h snes/dma.h snes/ppu.h snes/cart.h snes/input.h snes/snes.h

.PHONY: all clean

all: $(execname)

$(execname): $(cfiles) $(hfiles)
	$(CC) $(CFLAGS) -o $@ $(cfiles) $(sdlflags)

clean:
	rm -f $(execname)
