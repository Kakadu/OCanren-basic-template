open OCanren

module Lam = struct
  @type nonrec ('varname, 'self) t =
    | V of 'varname
    | App of 'self * 'self
    | Abs of 'varname * 'self
  with show, gmap
;;
  @type ground = (GT.string, ground) t with show
  @type logic = (GT.string OCanren.logic, logic) t OCanren.logic with show
  type injected = (GT.string ilogic, injected) t OCanren.ilogic

  let v name = inj (V name)
  let app f x = inj (App (f,x))
  let abs f x = inj (Abs (f,x))

  let fmapt fa fb subj =
    let open Env.Monad in
    Env.Monad.return (GT.gmap t) <*> fa <*> fb <*> subj

  let (reify : (injected, logic) Reifier.t) =
    let open Env.Monad in
    Reifier.fix (fun self ->
        OCanren.reify <..> chain (Reifier.zed (Reifier.rework ~fv:(fmapt OCanren.reify self))))

  let (prj_exn : (injected, ground) Reifier.t) =
    let open Env.Monad in
    Reifier.fix (fun self ->
        OCanren.prj_exn <..> chain (fmapt OCanren.prj_exn self))

  let varX = !!"x"
  let varY = !!"y"
  let varF = !!"f"
end
