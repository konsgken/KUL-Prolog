%listlength, listsum, listaverage.
% remove,index_remove, replace, reverse.
% nth_element, permList, range.
% append, member, split, flatten, subset.

subset([],[]).
subset([First|Rest], [First|Sub]):-subset(Rest, Sub).
subset([_First|Rest], Sub):- subset(Rest, Sub).

%Flattening the list

flatten([], []).
flatten(X, [X]) :- 
	atomic(X), X  \== [].
flatten([H|T], L3) :-
	flatten(H, L1), flatten(T, L2), append(L1, L2, L3).


% Find the length of the list.
listlength([], 0).
listlength([_|Tail], Count):-
    listlength(Tail, PartialCount),
    Count is PartialCount + 1.
% Replace([1,2,3], 2, 1000, Res)
replace([_|T], 1, X, [X|T]):-!.
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

index_remove(1, [_H|T], T):-!.
index_remove(Index, [Head|Tail], [Head|Tail1]):-
    Index > 0,
    TempIndex is Index -1,
    index_remove(TempIndex, Tail, Tail1).


% Given a list of numbers, calculate the sum of these numbers.
listsum([], 0).
listsum([Head|Tail], Sum):-
    listsum(Tail, PartialSum),
    Sum is PartialSum + Head.

% Given a list of numbers, calculate the average of these numbers.
listaverage([], 0).
listaverage([Head|Tail], Average):-
    listsum([Head|Tail], Sum),
    listlength([Head|Tail], Length),
    Average is Sum / Length.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Makes all possible permutations
remove(X,[X|T],T).
remove(X,[F|T],[F|T1]) :- remove(X,T,T1).

permList([],[]).
permList([X|Y],Z) :- permList(Y,W), remove(X,Z,W).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nth_element(1, [H|_Tail],H).
nth_element(N,[_H|Tail], E):- N>1, N1 is N-1,
    nth_element(N1, Tail, E).

% Split List into equal sublists L=list, N= number of elements in list, Res
part([], _, []).
part(L, N, [DL|DLTail]) :-
   length(DL, N),
   append(DL, LTail, L),
   part(LTail, N, DLTail), !.

%%%%%%%%%% Solution to clock_round problem %%%%%%%%%%%%%
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
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g_append( [], X, X).                                
g_append( [X | Y], Z, [X | W]) :- append( Y, Z, W).   

g_member(X,[X|_T]).
g_member(X,[_|T]):- g_member(X,T).

range(Low, Low, _High).
range(Out,Low,High) :- NewLow is Low+1, NewLow =< High, range(Out, NewLow, High).


listsumlength([], 0, 0).
listsumlength([Head|Tail], Length, Sum):-
    listsumlength(Tail, PartialLength, PartialSum),
    Sum is PartialSum + Head,
    Length is PartialLength + 1.

% Find first element of a list
first(X, [X|_]).

% Find last element of a list.
last(X,[X]).
last(X, [_|Tail]):-
    last(X, Tail).

% Remove one element from list.
remove(_, [], []). % remove(El, List, NewList).
remove(El,[El|Tail], Tail). % Head of the list is the element we are searching for and we stop.
remove(El, [Head|Tail], [Head|Tail2]):-
    not(El = Head), % Check if El is not the head of the list, not huge deal if you dont have it
    remove(El, Tail, Tail2).

% Remove all elements El from a list.
remove_all(_, [], []).
remove_all(El, [El|Tail], Tail2):-
    remove_all(El, Tail, Tail2).
remove_all(El, [Head|Tail], [Head|Tail2]):-
    not(El=Head),
    remove_all(El, Tail, Tail2).

% Remove all elements smaller than or equal to N
smaller(_, [], []).
smaller(N, [M|Tail], Tail2):-
    M=<N,
    smaller(N, Tail, Tail2).
smaller(N, [M|Tail], [M|Tail2]):-
    M > N,
    smaller(N, Tail, Tail2).

% Switch first two elements
switch_first_two([X,Y| Tail],[Y,X|Tail]).

% Switch every pair elements
switch_every_two([], []).
switch_every_two([X],[X]).
switch_every_two([X,Y|Tail],[Y,X|Tail2]):-
    switch_every_two(Tail, Tail2).

% For a given positive integer N and a given list L, returns the Nth element in the list L, as El.
% indexing in Prolog
%nth(1,[Head|_], Head).
%nth(N, [Head|Tail], El):-
%    N >1,
%    N1 is N - 1,
%    nth(N1, Tail, El).

% Triple - Example of returning a result having processed all elements 1st way of processing 
triple([],[]).
triple([H1|T1],[H2|T2]):-
    H2 is 3*H1,
    triple(T1,T2).

range(High, High, [High]):-!.
range(Low, High, [Head|Tail]):-
    Head = Low,
    NewLow is Low + 1,
    range(NewLow,High, Tail).
	
% Reverse elements of a list - Example of returning a result having processed all elements 2nd way of processing. 
% Using a simple Accumulator.
reverse([], Res, Res).
reverse([Head1|Tail1], Acc, Res):-
    reverse(Tail1, [Head1|Acc], Res).

% Switch ONLY the first 2 elements for which the 1st is larger than the second!!!!
switch_unsorted([],[]).
switch_unsorted([X], [X]).
switch_unsorted([X,Y|List],[Y,X|List]):-
    X > Y.
switch_unsorted([X,Y|List],[X|RList]):-
    X =< Y,
    switch_unsorted([Y|List], RList).

%APPLY switch_unsorted 10 TIMES, USING A HELPER PREDICATE
ten_times_2(List1,List2):-
    switch_n_times(List1,List2, 10).
% Base case : 0 times
switch_n_times(L,L,0).
%recursive case N>0 times
switch_n_times(L1,L2,N):-
    N>0,
    switch_unsorted(L1,Tmp),
    Next is N-1,
    switch_n_times(Tmp,L2,Next).

% Given a list of numbers, calculate the average of these numbers while_ traversing the list only once.
listaveragev2([], 0).
listaveragev2([Head|Tail], Avg):-
    listsumlength([Head|Tail], Length, Sum), % Helper predicate
    Avg is Sum/Length.

