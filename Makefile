CC = clang
CFLAGS = -std=gnu11 -Wall -Wextra -pthread -fno-omit-frame-pointer -g

all: build build/malloc.so build/standards build/functional

build:
	mkdir -p build

build/malloc.so: src/malloc.c src/malloc.h
	$(CC) $(CFLAGS) src/malloc.c -o build/malloc.so -fPIC -shared

build/standards: test/standards.c src/malloc.c src/malloc.h
	$(CC) $(CFLAGS) test/standards.c src/malloc.c -o build/standards -lrt -lm

build/functional: test/functional.c src/malloc.c src/malloc.h
	$(CC) $(CFLAGS) test/functional.c src/malloc.c -o build/functional -lrt -lm

test: all
	./build/standards && ./build/functional

clean:
	rm -rf build
