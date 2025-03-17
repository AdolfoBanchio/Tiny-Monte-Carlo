# Compilers
CC = gcc

# Flags
CFLAGS = -std=c11 -Wall -Wextra 
CFLAGSOPT = -std=c11 -Wall -Wextra -O3 -march=native
TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = headless head

# Files
C_SOURCES = wtime.c photon.c
C_OBJS = $(patsubst %.c, %.o, $(C_SOURCES))

headless: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(TINY_LDFLAGS)

headlessopt: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGSOPT) -o $@ $^ $(TINY_LDFLAGS)

head: cg_mc.o $(C_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(CG_LDFLAGS)

clean:
	rm -f $(TARGETS) *.o

