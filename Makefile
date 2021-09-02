.PHONY: all all ppx camlp5 watch test

all: ppx camlp5


ppx:
	dune build demo1ppx/main.exe --display=quiet && dune exec demo1ppx/main.exe --display=quiet

camlp5:
	dune build demo2camlp5/main.exe --display=quiet && dune exec demo2camlp5/main.exe --display=quiet

watch:
	dune build -w

test:
	dune test

clean:
	@dune clean
	$(MAKE) -C demo3make clean
