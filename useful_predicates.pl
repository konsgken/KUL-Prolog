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

range(High, High, [High]).
range(Low, High, [Low|T]):- Low < High, NewLow is Low + 1, range(NewLow, High, T).

nextto1(X, Y, [X,Y|_]).
nextto1(X, Y, [_|Zs]) :-
    nextto(X, Y, Zs).
near(X, Y, List):- nextto1(X, Y, List) ; nextto1(Y, X, List).

intersection1([],_M,[]).
intersection1([X|Y], M, [X|Z]):- member(X, M), intersection1(Y, M, Z).
intersection1([X|Y], M, Z):- not(member(X, M)), intersection1(Y, M ,Z).

union1([], Z, Z).
union1([X|Y], M, Z):-  member(X, M), union1(Y, M ,Z).
union1([X|Y], M, [X|Z]):- not(member(X, M)), union1(Y, M, Z).

before(X,Y,L):-append(_,[X|T],L),member(Y,T).

bet(X, Y, L):- X=L.
bet(X, Y, L):- X < Y, NewX is X + 1, bet(NewX, Y, L).

% pack predicate
pack([], []).
pack(List, [H2|T2]):- transfer(List, H2, Remaining), pack(Remaining, T2).
    
contains(_, []).
contains(X, [X|T]):- contains(X, T).

transfer([X|T], R1, R2):- append(R1, R2, [X|T]), R1=[_|_], contains(X, R1), \+ member(X, R2).
