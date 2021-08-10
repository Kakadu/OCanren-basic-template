(lang dune 2.7)

(cram enable)

(generate_opam_files true)

(license MIT)

(authors "FIXME Vasy Pupkin")

(package
 (name OCanren-base-example) ; FIXME and regenerate .opam file using 'dune build @install'
 (synopsis "FIXME An interpreter for language")
 (description
  "FIXME. A longer description, for example, which are the most interesing features being supported, etc.")
 (version 0.1)
 (depends
  (dune
   (>= 2.8))
  angstrom
  (ppx_inline_test :with-test)
  ppx_expect
  (odoc :with-doc)
  (ocamlformat :build)
  base
  ; After adding dependencies to 'dune' files and the same dependecies here too
  ))
