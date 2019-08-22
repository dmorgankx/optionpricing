OSFLAG :=
MS :=

ifeq ($(shell uname),Linux)
 LNK     = -lrt
 OSFLAG  = l
 OSXOPTS:=
else ifeq ($(shell uname),Darwin)
 OSFLAG  = m
 LNK:=
 OSXOPTS = -undefined dynamic_lookup  -mmacosx-version-min=10.12
endif

MS             = $(shell getconf LONG_BIT)

QARCH = $(OSFLAG)$(MS)
Q     = $(QHOME)/$(QARCH) 

all: rand.so ndist.so

rand.so: rand.o mt19937arcok.o SobolSeq16384N.o
	gcc -shared -o rand.so rand.o mt19937arcok.o SobolSeq16384N.o

rand.o: rand.c
	gcc -DKXVER=3 -fPIC -c rand.c -o rand.o

mt19937arcok.o: mt19937arcok.c
	gcc -fPIC -c mt19937arcok.c -o mt19937arcok.o

SobolSeq16384N.o: SobolSeq16384N.c
	gcc -fPIC -c SobolSeq16384N.c -o SobolSeq16384N.o

ndist.so: ndist.o NDist.o
	gcc -shared -o ndist.so ndist.o NDist.o

ndist.o: ndist.c
	gcc -DKXVER=3 -fPIC -c ndist.c -o ndist.o

NDist.o: NDist.c
	gcc -fPIC -c NDist.c -o NDist.o

install:
	mv ndist.o NDist.o rand.o mt19937arcok.o SobolSeq16384N.o rand.so ndist.so $(Q)

clean:
	rm -f ndist.o NDist.o rand.o mt19937arcok.o SobolSeq16384N.o rand.so ndist.so
