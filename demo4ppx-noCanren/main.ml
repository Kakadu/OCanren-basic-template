open OCanren
open Tester

module Nat = struct
  include Nat

  [%%distrib
  type nonrec 'a0 t = 'a0 gnat =
    | O
    | S of 'a0
  [@@deriving gt ~options:{ show; gmap }]

  type ground = ground t]

  let one : injected = s (o ())
  let zero : injected = o ()
end

open Tester

let runL n = run_r Nat.reify ([%show: Nat.logic] ()) n
let run_exn eta = run_r Nat.prj_exn ([%show: Nat.ground] ()) eta
let _ = run_exn 1 q qh (REPR (fun q -> Nat.add Nat.zero Nat.one q))
let _withFree = runL 5 qr qrh (REPR (fun q r -> Nat.add q r Nat.(s @@ s @@ s @@ one)))
