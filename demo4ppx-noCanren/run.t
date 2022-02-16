  $ ./main.exe
  fun q -> Nat.add Nat.zero Nat.one q, 1 answer {
  q=S (O);
  }
  fun q -> fun r -> Nat.add q r (let open Nat in s @@ (s @@ (s @@ one))), 5 answers {
  q=O; r=S (S (S (S (O))));
  q=S (O); r=S (S (S (O)));
  q=S (S (O)); r=S (S (O));
  q=S (S (S (O))); r=S (O);
  q=S (S (S (S (O)))); r=O;
  }
