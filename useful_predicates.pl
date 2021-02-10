remove(X, [X|Tail], Tail).
remove(X, [Head|Tail], [Head|Tail1]):-
    remove(X, Tail, Tail1).

remove_all(_,[],[]):-!.
remove_all(X, [X|Tail], List):- remove_all(X, Tail, List),!.
remove_all(X, [Head|Tail], [Head|Tail1]):- remove_all(X, Tail, Tail1).

remove_list([], Res, Res).
remove_list([Head|Tail], List, Result):-
    remove_all(Head, List, R1),
    remove_list(Tail, R1, Result).

reverse([], Res, Res).
reverse([Head|Tail], Acc, Res):-
    reverse(Tail, [Head|Acc], Res).

replace([_H|T], 1, N, [N|T]).
replace([H|T], Index, N, [H|R]):-
    Index>0, TempIndex is Index -1,
    replace(T, TempIndex, N, R).

nth_element(1, [El|_Tail], El).
nth_element(Index, [_Head|Tail], El):-
    Index > 0 , TempIndex is Index - 1,
    nth_element(TempIndex, Tail, El).

remove_index(1, [_X|Tail], Tail).
remove_index(Index, [Head|Tail], [Head|Tail1]):-
    Index >0 , TempIndex is Index -1,
    remove_index(TempIndex , Tail, Tail1).

gappend([], List, List).
gappend([X|Y], List, [X|Z]):- gappend(Y, List, Z).

gmember(X, [X|_T]).
gmember(X, [_H|T]):- gmember(X, T).

permList([],[]).
permList([X|Y], Z):- permList(Y, W), remove(X, Z, W).

subset([],[]).
subset([First|Rest], [First|Sub]):- subset(Rest,Sub).
subset([_First|Rest], Sub):- subset(Rest, Sub).

flatten([],[]).
flatten(X,[X]):- atomic(X), X\==[].
flatten([H|T], L3):- flatten(H,L1), flatten(T,L2), append(L1,L2,L3).

listlength([], 0).
listlength([_Head|Tail], Length):-
    listlength(Tail, PartialLength),
    Length is PartialLength + 1.

split([], _, []).
split(L, N, [DL|DLTail]):-
	listlength(DL, N),
    gappend(DL, LTail, L),
    split(LTail, N , DLTail),!.

range(High, High,[High]):-!.
range(Low, High, [Head|Tail]):-
    Head =Low,
    NewLow is Low + 1,
    range(NewLow, High, Tail).