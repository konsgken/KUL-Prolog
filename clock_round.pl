:- use_module(library(clpfd)). 
clock_round(N, Sum, Xs):-
    length(Xs, N),
    Xs ins 1..N,
    all_different(Xs),
    check(Xs, Sum), labeling([], Xs).

check([_H1, _H2], _).
check([H1, H2, H3|T], Sum):-
    H1 + H2 + H3 #< Sum,
    check([H2, H3|T], Sum).
