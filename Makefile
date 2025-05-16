# Compilers
CC = gcc
PHOTONS ?= 524288
N_THREADS ?= 8

# Flags
CFLAGS_0 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DUSE_OPT=0 -DPHOTONS=$(PHOTONS)
CFLAGS_1 = -std=c11 -Wall -Wextra -O3 -march=native -ftree-vectorize -ffast-math -falign-functions=32 -falign-loops=32 -flto -DUSE_OPT=1 -DPHOTONS=$(PHOTONS)
CFLAGS_2_BASE = -std=c11 -Wall -Wextra -g -O3 -march=native -ftree-vectorize -ffast-math -fopenmp -falign-functions=32 -falign-loops=32 -flto -DUSE_OPT=2 -DPHOTONS=$(PHOTONS) -DN_THREADS=$(N_THREADS)

TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = case_* head_*

# Detect Intel compiler
IS_ICX := $(shell $(CC) --version | grep -qi 'icx' && echo 1 || echo 0)

ifeq ($(IS_ICX),1)
    CFLAGS_2 := $(subst -fopenmp,-fiopenmp,$(CFLAGS_2_BASE))
else
    CFLAGS_2 := $(CFLAGS_2_BASE)
endif


# Files
C_SOURCES = wtime.c photon_lab1.c 
C_SOURCES1 = wtime.c photon_vect.c 
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

case_2: CFLAGS = $(CFLAGS_2)
case_2: tiny_mc.o $(C_OBJS1)
	$(CC) $(CFLAGS_2) -o $@ $^ $(TINY_LDFLAGS) 

head_0: CFLAGS = $(CFLAGS_0)
head_0: cg_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_0) -o $@ $^ $(CG_LDFLAGS)

head_1: CFLAGS = $(CFLAGS_1)
head_1: cg_mc.o $(C_OBJS1)
	$(CC) $(CFLAGS_1) -o $@ $^ $(CG_LDFLAGS)

head_2: CFLAGS = $(CFLAGS_2_BASE)
head_2: cg_mc.o $(C_OBJS1)
	$(CC) $(CFLAGS_2_BASE) -o $@ $^ $(CG_LDFLAGS)

clean:
	rm -f $(TARGETS) *.o
