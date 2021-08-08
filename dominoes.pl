bet(X, _Y, El):- X=El.
bet(X, Y, El):- X<Y, NewX is X + 1, bet(NewX, Y, El).

check([[H11, H12], [H13, H23], [H33, H32], [H31, H21]]):-
    3 is H11 + H12 + H13,
    3 is H31 + H32 + H33,  
    3 is H11 + H21 + H31,
    3 is H13 + H23 + H33.

%variant([[H11, H12], [H13, H23], [H33, H32], [H31, H21]], [[H31, H21], [H11, H12], [H13, H23], [H33, H32]]).
%variant([[H11, H12], [H13, H23], [H33, H32], [H31, H21]], [[H33, H32], [H31, H21], [H11, H12], [H13, H23]]).
%variant([[H11, H12], [H13, H23], [H33, H32], [H31, H21]], [[H13, H23], [H33, H32], [H31, H21], [H11, H12]]).

variant(List, Res):- append(L1, L2, List), L1 \==[], L2 \==[], append(L2, L1, Res).

generate(Sol):- 
    Sol = [[H11, H12], [H13, H23], [H33, H32], [H31, H21]],
    bet(0, 6, H11),
    bet(0, 6, H12),
    bet(0, 6, H13),
    bet(0, 6, H21),
    bet(0, 6, H23),
    bet(0, 6, H31),
    bet(0, 6, H32),
    bet(0, 6, H33).

sol(Sol):- findall(Res ,(generate(Res), check(Res)), Res), remove_variants(Res, Sol). 

remove_variants([], []).
remove_variants([H|T], T1):- exists_variant(H, T), !, remove_variants(T, T1).
remove_variants([H|T], [H|T1]):- remove_variants(T, T1). % No variants exist continue.
    
exists_variant(X, [H|_T]):- variant(X, H), !.
exists_variant(X, [_H|T]):- exists_variant(X, T).
    
