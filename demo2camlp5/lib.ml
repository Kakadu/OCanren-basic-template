open OCanren

module Lam = struct
  let () = ();;
  @type nonrec ('varname, 'self) t =
    | V of 'varname
    | App of 'self * 'self
    | Abs of 'varname * 'self
  with show, gmap
;;
  @type ground = (GT.string, ground) t with show
  @type logic = (GT.string OCanren.logic, logic) t OCanren.logic with show
  type injected = (ground, logic) OCanren.injected

  module D = Fmap2(struct type nonrec ('a,'b) t = ('a,'b) t let fmap eta = GT.gmap t eta end)
  let v name = inj @@ D.distrib (V name)
  let app f x = inj @@ D.distrib (App (f,x))
  let abs f x = inj @@ D.distrib (Abs (f,x))

  let rec reify eta = D.reify OCanren.reify reify eta

  let varX = !!"x"
  let varY = !!"y"
  let varF = !!"f"
end
