# Compilers
CC = gcc
PHOTONS ?= 524288

# Flags
CFLAGS_0 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DPHOTONS=$(PHOTONS)
CFLAGS_1 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DUSE_OPT=1 -DPHOTONS=$(PHOTONS)
TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = case_0 case_1 case_2 head

# Files
C_SOURCES = wtime.c photon_lab1.c  pcg_basic.c
C_SOURCES12 = wtime.c photon_vect.c pcg_basic.c
C_OBJS = $(patsubst %.c, %.o, $(C_SOURCES))
C_OBJS12 = $(patsubst %.c, %.o, $(C_SOURCES12))


#Caso 0: lab 1
case_0: CFLAGS = $(CFLAGS_0)
case_0: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_0) -o $@ $^ $(TINY_LDFLAGS)

#Caso 1: vectorizacion de codigo
case_1: CFLAGS = $(CFLAGS_1)
case_1: tiny_mc.o $(C_OBJS12)
	$(CC) $(CFLAGS_1) -o $@ $^ $(TINY_LDFLAGS) 

clean:
	rm -f $(TARGETS) *.o
