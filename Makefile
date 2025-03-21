# Compilers
CC = gcc

# Flags
CFLAGS_0 = -std=c11 -Wall -Wextra
CFLAGS_1 = -std=c11 -Wall -Wextra -USE_OPT
CFLAGS_2 = -std=c11 -Wall -Wextra -O3 -march=native -USE_OPT
TINY_LDFLAGS = -lm
CG_LDFLAGS = -lm -lglfw -lGL -lGLEW

TARGETS = case_0 case_1 case_2 head

# Files
C_SOURCES = wtime.c photon.c 
C_SOURCES12 = wtime.c photon_opt.c pcg_basic.c
C_OBJS = $(patsubst %.c, %.o, $(C_SOURCES))
C_OBJS12 = $(patsubst %.c, %.o, $(C_SOURCES12))


#Caso 0: sin modificaciones
case_0: tiny_mc.o $(C_OBJS)
	$(CC) $(CFLAGS_0) -o $@ $^ $(TINY_LDFLAGS)

#Caso 1: optimizaciones del código
case_1: tiny_mc.o $(C_OBJS12)
	$(CC) $(CFLAGS_1) -o $@ $^ $(TINY_LDFLAGS) 

#Caso 2: optimizaciones de código + compilador
case_2: CFLAGS = $(CFLAGS_2)
case_2: tiny_mc.o $(C_OBJS12)
	$(CC) $(CFLAGS) -o $@ $^ $(TINY_LDFLAGS) 

head: cg_mc.o $(C_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(CG_LDFLAGS)

clean:
	rm -f $(TARGETS) *.o
