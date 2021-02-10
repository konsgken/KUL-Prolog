:- use_module(library(clpfd)).
clock_round(N,Sum, Xs):-
    listlength(Xs_temp, N),
    Xs_temp ins 1..N,
    all_different(Xs_temp),
    subarray(Xs_temp, Sum),
    findall(Xs_temp, labeling([], Xs_temp), Xs).

listlength([], 0).
listlength([_|Tail], Count):-
    listlength(Tail, PartialCount),
    Count is PartialCount + 1.


subarray([El1,El2,El3|[]], Sum):-
    El1+El2+El3#<Sum.
subarray([El1,El2,El3|Tail], Sum):-
    El1+El2+El3 #<Sum,
    subarray([El2,El3|Tail], Sum), !.