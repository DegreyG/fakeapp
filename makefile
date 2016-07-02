all: build

build:
	./build.sh

run: build
	./bin/fakeapp TestApp
