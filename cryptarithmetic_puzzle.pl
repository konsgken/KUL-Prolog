:- use_module(library(clpfd)).
solve:-
    Vars = [G, R, E, N, V, I, O, L, T, D],
    Vars ins 1..10,
    all_different(Vars),
    100000*V + 10000*I + 1000*O + 100*L + 10*E + T +
               10000*G + 1000*R + 100*E + 10*E + N #=
    100000*I + 10000*N + 1000*D + 100*I + 10*G + O,
    labeling([], Vars),
    write(Vars).