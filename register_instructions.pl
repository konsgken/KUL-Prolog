register(1,a). % First position a
register(2,b). % Second position b
register(3,a). % Third position a
register(4,d). % Fourth position d

nth_element(1, [H|_Tail],H).
nth_element(N,[_H|Tail], E):- N>1, N1 is N-1,
    nth_element(N1, Tail, E).

replace([_|T], 1, X, [X|T]):-!.
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

copy(I, GivenList, ResultList):-
    nth_element(I, GivenList, Element),
    Next is I+1,
    replace(GivenList, Next, Element, ResultList).

swap(I,G, GivenList, ResultList):-
    nth_element(I, GivenList, ElementI),
    nth_element(G, GivenList, ElementG),
    TempI=ElementI,
    TempG=ElementG,
    replace(GivenList,I, TempG, TempList),
    replace(TempList,G, TempI, ResultList).

seqInstructions(C1,C2,S1,S2,S3,S4):-
    findall(Register,register(_,Register),RegisterList),
    copy(C1,RegisterList,P),
    writeln(P),
    copy(C2,P,P2),
    writeln(P2),
    swap(S1,S2,P2,P3),
    writeln(P3),
    swap(S3,S4,P3,P4),
    writeln(P4).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* execute the Program:-
?-seqInstructions(2,1,2,3,2,4).
OUTPUT:
[a, b, b, d]
[a, a, b, d]
[a, b, a, d]
[a, d, a, b]
*/