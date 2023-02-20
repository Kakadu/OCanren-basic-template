open OCanren
open OCanren.Std

let rec appendo a b ab =
  conde
    [ a === nil () &&& (b === ab)
    ; fresh (h t ab') (a === h % t) (h % ab' === ab) (appendo t b ab')
    ]
;;

open Tester

let run_exn eta =
  run_r (Std.List.prj_exn OCanren.prj_exn) (GT.show Std.List.ground (GT.show GT.int)) eta
;;

let _ = run_exn (-1) qr qrh (REPR (fun q r -> appendo q r (list ( !! ) [ 1; 2; 3; 4 ])))
