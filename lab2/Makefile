# Compilers
CC = gcc
PHOTONS ?= 524288

# Flags
CFLAGS_0 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DPHOTONS=$(PHOTONS)
CFLAGS_1 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DUSE_OPT=1 -DPHOTONS=$(PHOTONS)
TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = case_* head_*

# Files
C_SOURCES = wtime.c photon_lab1.c  pcg_basic.c
C_SOURCES1 = wtime.c photon_vect.c pcg_basic.c
C_OBJS = $(patsubst %.c, %.o, $(C_SOURCES))
C_OBJS1 = $(patsubst %.c, %.o, $(C_SOURCES1))


#Caso 0: lab 1
case_0: CFLAGS = $(CFLAGS_0)
case_0: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_0) -o $@ $^ $(TINY_LDFLAGS)

#Caso 1: vectorizacion de codigo
case_1: CFLAGS = $(CFLAGS_1)
case_1: tiny_mc.o $(C_OBJS1)
	$(CC) $(CFLAGS_1) -o $@ $^ $(TINY_LDFLAGS) 

head_0: CFLAGS = $(CFLAGS_0)
head_0: cg_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_0) -o $@ $^ $(CG_LDFLAGS)


head_1: CFLAGS = $(CFLAGS_1)
head_1: cg_mc.o $(C_OBJS1)
	$(CC) $(CFLAGS_1) -o $@ $^ $(CG_LDFLAGS)

clean:
	rm -f $(TARGETS) *.o
