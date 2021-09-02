TOPFILE = peano
SOURCES = lib.ml main.ml
OCAMLC = ocamlfind c
OCAMLOPT = ocamlfind opt
OCAMLDEP = ocamlfind dep
OUTB = $(TOPFILE).byte
OUTO = $(TOPFILE).opt
PREPROCESSOR=pp.exe
CAMLP5 = -syntax camlp5o -package OCanren.syntax,GT.syntax,GT.syntax.all
PXFLAGS = -pp ./$(PREPROCESSOR)
# add flag -i to BFLAGS to show in the terminal the type signature of the program
# add flag -dsource to BFLAG to dispaly in the terminal the source code after syntax expansion
BFLAGS = -rectypes -g -package OCanren,OCanren.tester
OFLAGS = $(BFLAGS)
CLEAN = $(wildcard *.cm[iox] *.annot *.o *.d) $(OUTB) $(OUTO) $(PREPROCESSOR)

.PHONY : all clean celan

all: $(OUTO)

# mkcamlp5.opt gives an error but shouldn't
$(PREPROCESSOR):
	mkcamlp5.opt -package camlp5,camlp5.pa_o,camlp5.macro,camlp5.pr_dump,logger.syntax,OCanren.syntax,GT-p5,GT.syntax.all -linkall -o $@

.depend: $(SOURCES)
	$(OCAMLDEP) $(PXFLAGS) *.ml > .depend

$(OUTO): $(SOURCES:.ml=.cmx)
	$(OCAMLOPT) -o $(OUTO) $(OFLAGS) $(LIBS:.cma=.cmxa) -linkpkg $(SOURCES:.ml=.cmx)

$(OUTB): $(SOURCES:.ml=.cmo)
	$(OCAMLC) -o $(OUTB) $(BFLAGS) $(LIBS) -linkpkg $(SOURCES:.ml=.cmo)

celan: clean
clean:
	$(RM) $(CLEAN)

# generic rules

###############
%.cmi: %.mli
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

# Note: cmi <- mli should go first
%.cmi: %.ml $(PREPROCESSOR)
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.cmo: %.ml $(PREPROCESSOR)
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.o: %.ml
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

%.cmx: %.ml $(PREPROCESSOR)
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

%.d: %.ml $(PREPROCESSOR)
	$(OCAMLDEP) $(PXFLAGS) $< > $@

# http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
# super link about explanation how to setup dependecy generation
ifneq ($(MAKECMDGOALS),clean)
include $(SOURCES:.ml=.d)
endif
