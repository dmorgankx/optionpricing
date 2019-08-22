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

clean:
	rm -f ndist.o NDist.o rand.o mt19937arcok.o SobolSeq16384N.o rand.so ndist.so
