open GT
open OCanren
open OCanren.Std
module Stream = struct [%%distrib type nonrec ('a, 'b) t =
                                    | Nil 
                                    | Cons of 'a * 'b [@@deriving gt ~options:{ show; fmt; gmap }]
                         type ('a, 'b) ground = ('a, 'b) t] end
let nil = Stream.nil
let cons = Stream.cons
let rec append_o xs_o ys_o q12 =
  fresh (q4 q0 q1) (q4 === (pair q0 q1)) (xs_o q0) (ys_o q1)
    ((fresh (ys) (q4 === (pair (nil ()) ys)) (ys === q12)) |||
       (fresh (h tl ys q6 q7) (q4 === (pair (cons h tl) ys)) (q12 === (cons q6 q7)) (h === q6) (append_o (fun q10 -> tl === q10) (fun q11 -> ys === q11) q7)))
let append q15 q14 q13 = append_o ((===) q15) ((===) q14) q13