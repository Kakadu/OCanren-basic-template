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
  (OCanren
   (>= 0.3.0~))
  (noCanren
   (>= 0.3.0~))
  (OCanren-ppx
   (>= 0.3.0~))
  ; After adding dependencies to 'dune' files and the same dependecies here too
  ))
