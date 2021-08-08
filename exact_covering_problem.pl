iscovered(I, [H|_T], H):-  member(I, H).
iscovered(I, [_H|T], O):-  iscovered(I, T, O).

remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X, T, T1).

remove_list([], List, List).
remove_list([H|T], List, Res):- remove(H, List, R1), remove_all(T, R1, Res).

residual(I, Is, O, Os, RemainingI, RemainingO):- remove(I, Is, RemainingI), remove(O, Os, RemainingO).

all_different([]).
all_different([H|T]):- \+ member(H, T), all_different(T).

subset([],[]).
subset([First|Rest], [First|Sub]):- subset(Rest, Sub).
subset([_First|Rest], Sub):- subset(Rest, Sub).

contains([], _).
contains([H|T], List):- member(H, List), contains(T, List).

findexactcovering(Options, Res):- subset(Options, Res), flatten(Res, Flat), contains([a,b,c,d,e,f,g], Flat), all_different(Flat).
