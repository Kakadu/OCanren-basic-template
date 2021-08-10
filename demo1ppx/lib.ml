open OCanren

module Lam = struct
  [%%distrib
  type nonrec ('varname, 'self) t =
    | V of 'varname
    | App of 'self * 'self
    | Abs of 'varname * 'self

  type ground = (GT.string, ground) t]

  let varX = !!"x"
  let varY = !!"y"
  let varF = !!"f"
end
