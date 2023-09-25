# checkers
Implementations of Pierce checkers for use with TAPL-based course

## Implementation details

This repository comprises a collection of working implementations (typecheckers and simple interpreters) for some of the calculi covered in the Pierce's textbook. These implementations offer an environment for experimenting with the examples in the book and testing solutions to exercises. They have also been polished for readability and modifiability and have been used successfully by students in Pierce's courses as the basis of both small implementation exercises and larger course projects.
The implementations are written in OCaml. The OCaml compiler is available at no cost through http://caml.inria.fr and installs easily on a variety of platforms.

Once you have downloaded the files for a particular checker and installed the OCaml compiler on your machine, you can build a running checker in two ways:

If your system provides the make program (e.g., if you are running on any kind of Unix, or on a Windows system with the Cygwin package installed), simply type make on the command line to build an executable checker, or make test to build the checker and immediately use it to process the input file test.f. 
If you do not have make, you can build and execute the checker manually by issuing the following commands:
```
  ocamllex lexer.mll
  ocamlyacc -v parser.mly
  ocamlc -c support.mli
  ocamlc -c support.ml
  ocamlc -c syntax.mli
  ocamlc -c syntax.ml
  ocamlc -c core.mli
  ocamlc -c core.ml
  ocamlc -c parser.mli
  ocamlc -c parser.ml
  ocamlc -c lexer.ml
  ocamlc -c main.ml
  ocamlc -o f support.cmo syntax.cmo core.cmo parser.cmo lexer.cmo main.cmo
```
Whichever way you chose to build the checker, you can now use it to process an input file test.f by typing ./f test.f at the command line.

## License
These checkers were originally developed by Pierce and apparently released to the public domain.  
The text on this page is mainly copied from Pierce's textbook resources page: https://www.cis.upenn.edu/~bcpierce/tapl/resources.html
The changes done by Boyland are similarly unrestricted.

