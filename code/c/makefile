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

all: rand.so norm.so

rand.so: rand.o mt19937arcok.o SobolSeq1024.o
	gcc -shared -o rand.so rand.o mt19937arcok.o SobolSeq1024.o

rand.o: rand.c
	gcc -DKXVER=3 -fPIC -c rand.c -o rand.o

mt19937arcok.o: mt19937arcok.c
	gcc -fPIC -c mt19937arcok.c -o mt19937arcok.o

SobolSeq1024.o: SobolSeq1024.c
	gcc -fPIC -c SobolSeq1024.c -o SobolSeq1024.o

norm.so: norm.o ndist.o
	gcc -shared -o norm.so norm.o ndist.o

norm.o: norm.c
	gcc -DKXVER=3 -fPIC -c norm.c -o norm.o

ndist.o: ndist.c
	gcc -fPIC -c ndist.c -o ndist.o

install:
	mv rand.so norm.so $(Q)

clean:
	rm -f norm.o ndist.o rand.o mt19937arcok.o SobolSeq1024.o rand.so norm.so
