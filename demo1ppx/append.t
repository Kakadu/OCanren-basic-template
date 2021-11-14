  $ ./append.exe
  fun xs -> fun ys -> appendo xs ys (Std.list (!!) [1; 2; 3]), all answers {
  q=[]; r=[1; 2; 3];
  q=[1]; r=[2; 3];
  q=[1; 2]; r=[3];
  q=[1; 2; 3]; r=[];
  }
  Reverso: recursive call before appedo 
  fun xs -> reverso (Std.list (!!) [1; 2; 3]) xs, 1 answer {
  q=[3; 2; 1];
  }
  fun xs -> reverso (Std.list (!!) [1; 2; 3]) xs, all answers {
  q=[3; 2; 1];
  }
  fun xs -> reverso xs (Std.list (!!) [1; 2; 3]), 1 answer {
  q=[3; 2; 1];
  }
  Another implementation of reverso: appendo before recursive call
  fun xs -> reverso (Std.list (!!) [1; 2; 3]) xs, 1 answer {
  q=[3; 2; 1];
  }
  fun xs -> reverso xs (Std.list (!!) [1; 2; 3]), 1 answer {
  q=[3; 2; 1];
  }
  fun xs -> reverso xs (Std.list (!!) [1; 2; 3]), all answers {
  q=[3; 2; 1];
  }
