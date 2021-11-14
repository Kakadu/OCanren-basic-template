open OCanren
open OCanren.Std
open Tester

let rec appendo xs ys xys =
  fresh
    (h tl xytl)
    (conde
       [ xs === Std.nil () &&& (ys === xys)
       ; xs === h % tl &&& (xys === List.cons h xytl) &&& appendo tl ys xytl
       ])
;;

let show_listl = GT.show List.logic (GT.show logic @@ GT.show GT.int)
let list_reify eta = List.reify OCanren.reify eta
let run_list eta = runR list_reify (GT.show List.ground @@ GT.show GT.int) show_listl eta

let _ =
  run_list (-1) qr qrh (REPR (fun xs ys -> appendo xs ys (Std.list ( !! ) [ 1; 2; 3 ])))
;;

let () = print_endline "Reverso: recursive call before appedo "

let rec reverso xs ys =
  fresh
    (h tl)
    (conde
       [ xs === Std.nil () &&& (xs === ys)
       ; fresh temp (xs === List.cons h tl) (reverso tl temp) (appendo temp !<h ys)
       ])
;;

(* works  *)
let _ = run_list 1 q qh (REPR (fun xs -> reverso (Std.list ( !! ) [ 1; 2; 3 ]) xs))

(* works *)
let _ = run_list (-1) q qh (REPR (fun xs -> reverso (Std.list ( !! ) [ 1; 2; 3 ]) xs))

(* works *)
let _ = run_list 1 q qh (REPR (fun xs -> reverso xs (Std.list ( !! ) [ 1; 2; 3 ])))

(*  hangs *)
let __ _ = run_list (-1) q qh (REPR (fun xs -> reverso xs (Std.list ( !! ) [ 1; 2; 3 ])))
let () = print_endline "Another implementation of reverso: appendo before recursive call"

let rec reverso xs ys =
  fresh
    (h tl temp)
    (conde
       [ xs === Std.nil () &&& (xs === ys)
       ; xs === List.cons h tl &&& appendo temp !<h ys &&& reverso tl temp
       ])
;;

(* works *)
let _ = run_list 1 q qh (REPR (fun xs -> reverso (Std.list ( !! ) [ 1; 2; 3 ]) xs))

(* started to hang *)
let _ = run_list (-1) q qh (REPR (fun xs -> reverso (Std.list ( !! ) [ 1; 2; 3 ]) xs))

(* works as before *)
let _ = run_list 1 q qh (REPR (fun xs -> reverso xs (Std.list ( !! ) [ 1; 2; 3 ])))

(* started to work *)
let _ = run_list (-1) q qh (REPR (fun xs -> reverso xs (Std.list ( !! ) [ 1; 2; 3 ])))

module _ () = struct
  let flip f a b = f b a

  let rec appendo xs ys xys =
    fresh
      (h tl xytl)
      (debug_var
         (pair xs (pair ys xys))
         (flip @@ Pair.reify list_reify (Pair.reify list_reify list_reify))
         (function
           | [ Value (xs, Value (ys, xys)) ] ->
             Format.printf
               "appendo: %s %s %s\n%!"
               (show_listl xs)
               (show_listl ys)
               (show_listl xys);
             success
           | _ -> assert false))
      (conde
         [ xs === Std.nil () &&& (ys === xys)
         ; xs === h % tl &&& (xys === List.cons h xytl) &&& appendo tl ys xytl
         ])
  ;;

  let rec reverso xs ys =
    fresh
      (h tl)
      (debug_var
         (pair xs ys)
         (fun a b -> Pair.reify list_reify list_reify b a)
         (function
           | [ Value (xs, ys) ] ->
             Format.printf "reverso: %s %s\n%!" (show_listl xs) (show_listl ys);
             success
           | _ -> assert false))
      (conde
         [ xs === Std.nil () &&& (xs === ys)
         ; fresh temp (xs === List.cons h tl) (reverso tl temp) (appendo temp !<h ys)
         ])
  ;;

  (* started to hang *)
  let _ = run_list (-1) q qh (REPR (fun xs -> reverso xs (Std.list ( !! ) [ 1; 2; 3 ])))
end
