# Compilers
CC = gcc

# Flags
CFLAGS_01 = -std=c11 -Wall -Wextra
CFLAGS_2 = -std=c11 -Wall -Wextra -O3 -march=native -msse2 -DHAVE_SSE2 -DSFMT_MEXP=607 -fopt-info
TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = headless_0 headless_1 headless_2 head 

# Files
C_SOURCES = wtime.c photon.c 
C_SOURCES12 = wtime.c photon_opt.c SFMT.c pcg_basic.c
C_OBJS = $(patsubst %.c, %.o, $(C_SOURCES))
C_OBJS12 = $(patsubst %.c, %.o, $(C_SOURCES12))


#Caso 0: sin modificaciones
headless_0: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_01) -o $@ $^ $(TINY_LDFLAGS)

#Caso 1: optimizaciones del código
headless_1: tiny_mc.o $(C_OBJS12)
	$(CC) $(CFLAGS_01) -o $@ $^ $(TINY_LDFLAGS) 

#Caso 2: optimizaciones de código + compilador
headless_2: tiny_mc.o $(C_OBJS12)
	$(CC) $(CFLAGS_2) -o $@ $^ $(TINY_LDFLAGS) 

head: cg_mc.o $(C_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(CG_LDFLAGS)

clean:
	rm -f $(TARGETS) *.o



