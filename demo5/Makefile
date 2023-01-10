TOPFILE = demo5
SOURCES = lib.ml main.ml
OCAMLC = ocamlfind c
OCAMLOPT = ocamlfind opt
OCAMLDEP = ocamlfind dep
OUTB = $(TOPFILE).byte
OUTO = $(TOPFILE).exe
P5PP_EXE = pp5.exe
LIBS=
PPX_EXE=ppx.exe
PPX_MAIN=ppx_rewriter_main.ml
CAMLP5 = -syntax camlp5o -package OCanren.syntax,GT.syntax,GT.syntax.all
PXFLAGS = -pp "./$(PPX_EXE) -pp ./$(P5PP_EXE)"
# add flag -i to BFLAGS to show in the terminal the type signature of the program
# add flag -dsource to BFLAG to dispaly in the terminal the source code after syntax expansion
BFLAGS = -rectypes -g -package OCanren,OCanren.tester
OFLAGS = $(BFLAGS)
CLEAN = $(wildcard *.cm[iox] *.annot *.o *.d) $(OUTB) $(OUTO) $(P5PP_EXE) $(PPX_EXE) lozov.ml

.PHONY : all clean celan

all: $(OUTO)
.SUFFIXES: .ml .ml2mk.ml

lib.ml: lozov.ml2mk.ml
	noCanren -rectypes -useGT -distribs $^ -o $@

lib.cmo lib.cmx lib.cmi: $(PPX_EXE)

ppx.exe:
	@echo "let () = Ppxlib.Driver.standalone ()" > $(PPX_MAIN)
	@ocamlfind opt $(PPX_MAIN) -o $@ \
		-predicates custom_ppx -predicates ppx_driver \
		-package GT.ppx,GT.ppx_all,OCanren-ppx.ppx_distrib,OCanren-ppx.ppx_deriving_reify,OCanren-ppx.ppx_fresh \
		-package ppxlib.runner \
		-linkpkg -linkall
	@$(RM) $(PPX_MAIN)

# mkcamlp5.opt gives an error but shouldn't
$(P5PP_EXE):
	mkcamlp5.opt -package camlp5,camlp5.pa_o,camlp5.macro,camlp5.pr_dump,logger.syntax,OCanren.syntax,GT.syntax,GT.syntax.all -linkall -o $@

main.cm[iox]: $(OFLAGS) += -dsource
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
%.cmi: %.ml $(P5PP_EXE) $(PPX_EXE)
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.cmo: %.ml $(P5PP_EXE) $(PPX_EXE)
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.o: %.ml
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

%.cmx: %.ml $(P5PP_EXE) $(PPX_EXE)
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

%.d: %.ml $(P5PP_EXE) $(PPX_EXE)
	$(OCAMLDEP) $(PXFLAGS) $< > $@

# http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
# super link about explanation how to setup dependecy generation
ifneq ($(MAKECMDGOALS),clean)
include $(SOURCES:.ml=.d)
endif
