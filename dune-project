(lang dune 2.7)

(cram enable)

(generate_opam_files true)

(license MIT)

(authors "<author>")

(package
 (name OCanren-base-example) ; FIXME and regenerate .opam file using 'dune build @install'
 (synopsis "OCanren demo projects")
 (version 0.1)
 (maintainers "<empty>")
 (depends
  (dune
   (>= 2.8))
  (OCanren (or (>= 0.3.0) (>= 0.3.0~alpha1)))
  (OCanren-ppx (or (>= 0.3.0) (>= 0.3.0~alpha1)))
  ; After adding dependencies to 'dune' files and the same dependecies here too
  ))
