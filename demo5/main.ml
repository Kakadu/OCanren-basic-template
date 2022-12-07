open OCanren
open Tester

type 'a mystream = ('a, 'a mystream) Lib.Stream.t [@@deriving gt ~options:{show}]

let prj_exn_mystream ra = 
  let open Lib.Stream in
  let open Env.Monad in
  let open Env.Monad.Syntax in
  Reifier.fix (fun self ->
      OCanren.prj_exn <..> chain (fmapt ra self) )

let run_exn eta = run_r (prj_exn_mystream OCanren.prj_exn) ([%show: GT.int mystream] ()) eta

let _ =
  let open Lib.Stream in
  let xs = cons !!1 (cons !!2 (nil())) in
  let ys = cons !!30 (nil ()) in
  run_exn 1 q qh
    (REPR (fun q -> ocanren { Lib.append_o ((===)xs) ((===)ys) q } ))
