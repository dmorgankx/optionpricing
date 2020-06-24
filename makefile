OSFLAG :=
MS :=

ifeq ($(shell uname),Linux)
 LNK     = -lrt
 OSFLAG  = l
 LDFLAGS = -shared -fPIC
 OSXOPTS:=
else ifeq ($(shell uname),Darwin)
 OSFLAG  = m
 LNK:=
 LDFLAGS = -undefined dynamic_lookup
endif

MS             = $(shell getconf LONG_BIT)

QARCH = $(OSFLAG)$(MS)
Q     = $(QHOME)/$(QARCH) 

all: rand.so norm.so

rand.so: rand.o mt19937arcok.o SobolSeq1024.o
	$(CC) $(LDFLAGS) -o rand.so rand.o mt19937arcok.o SobolSeq1024.o

rand.o: src/rand.c
	$(CC) -DKXVER=3 -c src/rand.c -o rand.o

mt19937arcok.o: src/mt19937arcok.c
	$(CC) -c src/mt19937arcok.c -o mt19937arcok.o

SobolSeq1024.o: src/SobolSeq1024.c
	$(CC) -c src/SobolSeq1024.c -o SobolSeq1024.o

norm.so: norm.o ndist.o
	$(CC) $(LDFLAGS) -o norm.so norm.o ndist.o

norm.o: src/norm.c
	$(CC) -DKXVER=3 -c src/norm.c -o norm.o

ndist.o: src/ndist.c
	$(CC) -c src/ndist.c -o ndist.o

install:
	mv rand.so norm.so $(Q)

clean:
	rm -f norm.o ndist.o rand.o mt19937arcok.o SobolSeq1024.o rand.so norm.so
