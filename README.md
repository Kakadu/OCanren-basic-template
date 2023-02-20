[![OCanren-basic-template][1]][2]

[1]:  https://github.com/Kakadu/OCanren-basic-template/actions/workflows/master.yml/badge.svg
[2]:  https://github.com/Kakadu/OCanren-basic-template/actions


##### OCanren basic project

There you can find starting projects for [OCanren](https://github.com/PLTools/OCanren) hacking:

* The dune+PPX-based project is in `demo1ppx` directory.
  * This demo works with js_of_ocaml too

      ```
      $ dune b demo1ppx/appendo.bc.js
      $ node _build/default/demo1ppx/appendo.bc.js
      fun q -> fun r -> appendo q r (list (!!) [1; 2; 3; 4]), all answers {
      q=[]; r=[1; 2; 3; 4];
      q=[1]; r=[2; 3; 4];
      q=[1; 2]; r=[3; 4];
      q=[1; 2; 3]; r=[4];
      q=[1; 2; 3; 4]; r=[];
      }
      ```

* The dune+Camlp5-based -- `demo2camlp5`
* The Camlp5+Makefile -- `demo3make`.
* The dune+noCanren -- `demo4ppx-noCanren`.
* The Camlp5+PPX+noCanren+make -- `demo5`.

##### Dependencies

* dune (>= 2.7) -- a build system
* GT (>= 0.4.2)
* OCanren (> 0.3.0)
* noCanren (>= 0.3.0)


##### TODO
