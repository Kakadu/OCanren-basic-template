open OCanren
open Tester
open Lib
open Lam

let rec substo l x a l' =
  let open Lam in
  conde
    [ fresh y (l === v y) (y === x) (l' === a)
    ; fresh
        (m n m' n')
        (l === app m n)
        (l' === app m' n')
        (substo m x a m')
        (substo n x a n')
    ; fresh
        (v b)
        (l === abs v b)
        (conde [ x === v &&& (l' === l); fresh b' (l' === abs v b') (substo b x a b') ])
    ]
;;

let rec evalo m n =
  conde
    [ fresh x (m === v x) (n === m)
    ; fresh (x l) (m === abs x l) (n === m)
    ; fresh
        (f a f' a')
        (m === app f a)
        (evalo f f')
        (evalo a a')
        (conde
           [ fresh (x l l') (f' === abs x l) (substo l x a' l') (evalo l' n)
           ; fresh (p q) (f' === app p q) (n === app f' a')
           ; fresh x (f' === v x) (n === app f' a')
           ])
    ]
;;

let a_la_quine q r s = ?&[ evalo (app q r) s; evalo (app r s) q; evalo (app s q) r ]

open Tester

let runL n = runR Lam.reify (GT.show Lam.ground) (GT.show Lam.logic) n

let _ =
  run_exn (GT.show Lam.ground) 1 q qh (REPR (fun q -> substo (v varX) varX (v varY) q));
  run_exn (GT.show Lam.ground) 1 q qh (REPR (fun q -> evalo (abs varX (v varX)) q));
  run_exn (GT.show Lam.ground) 2 q qh (REPR (fun q -> evalo (abs varX (v varX)) q));
  run_exn
    (GT.show Lam.ground)
    1
    q
    qh
    (REPR (fun q -> evalo (app (abs varX (v varX)) (v varY)) q));
  run_exn
    (GT.show Lam.ground)
    1
    q
    qh
    (REPR (fun q -> evalo (app (abs varX (v varX)) q) (v varY)));
  run_exn
    (GT.show Lam.ground)
    1
    q
    qh
    (REPR (fun q -> evalo (app (abs varX q) (v varY)) (v varY)));
  run_exn (GT.show Lam.ground) 1 q qh (REPR (fun q -> evalo (app (v varX) (v varX)) q));
  run_exn (GT.show Lam.ground) 1 q qh (REPR (fun q -> evalo (v varX) q))
;;

let _withFree =
  runL 1 q qh (REPR (fun q -> evalo (app q (v varX)) (v varX)));
  runL 1 qr qrh (REPR (fun q r -> evalo (app r q) (v varX)));
  runL 2 qrs qrsh (REPR (fun q r s -> a_la_quine q r s))
;;
