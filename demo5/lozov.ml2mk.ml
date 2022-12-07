

type ('a, 'b) stream = Nil | Cons of 'a * 'b

let rec append xs ys = match xs,ys with
  | Nil, ys -> ys
  | Cons (h, tl), ys -> Cons (h, append tl ys)
