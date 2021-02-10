%(a) Define a data structure that represents a domino and a data struc- ture that represents such a con guration of 4 dominoes.


% a domino is represented by the Prolog term bl(L,R) where the value
% of L and R are the number of spots on the resp. the lhs and the rhs.

% a configuration is represented by the Prolog term conf(B1,B2,B3,B4)
% where B1,B2,B3, and B4 are Prolog terms respresenting dominoes:
%        B1_L     B1_R     B2_L
%        B4_R              B2_R
%        B4_L     B3_R     B3_L
%

%(b) Write a predicate that checks whether a given configuration is a good one.
/*
goodconf(conf(B1,B2,B3,B4)):-
	test(B1,B2), test(B2,B3), test(B3,B4), test(B4,B1).
% sum of the spots of the row/column should be three
test(bl(X1,Y1), bl(X2,_Y2) ):-
       3 is X1 + Y1 +X2.

*/
%(c) Write a predicate that succeeds when two given con gurations are variants. Note that if we turn the con guration of Figure 1 over for example 180 degrees we get its variant in Figure 2. These kinds of variants should be recognised. Note that you can also turn over 90 and 270 degrees.

/*
is_variant(S1, S2) :-
	S1 =.. [ conf | S1s],         % S1s is the list of dominoes of S1
	S2 =.. [ conf | S2s],
	append(P1, P2, S1s),
	P1 \== [], P2 \== [],
	append(P2,P1, S2s).
*/

% generate one solution: building partial solutions
%                        and checking them (diff/2 and test/2).

sol(conf(B1,B2,B3,B4)) :-
	mblock(B1),
	mblock(B2),
	diff(B2,B1),
	test(B1,B2),           % upper row sum equals 3
	mblock(B3),
	diff(B3,B2), diff(B3,B1),
	test(B2,B3),           % rhs column sum equals 3
	mblock(B4),
	diff(B4,B3), diff(B4,B2), diff(B4,B1),
	test(B3,B4),           % lower row sum equals 3
	test(B4,B1).           % lhs column sum equals 3


% generate a domino  (taking into account that the  number of spots <= 3)
mblock( bl(X,Y)) :-
	val(X), val(Y),
	X + Y < 4 .

val(0).
val(1).
val(2).
val(3).


% checking whether we have 2 different dominoes.
diff(bl(X1,Y1), bl(X2,Y2)):-
	realdiff(X1,Y1, X2,Y2),
	realdiff(X1,Y1, Y2,X2).

realdiff(X1,Y1,X2,Y2):-
	X1 \== X2, !
	; 
	Y1 \== Y2.


% sum of the spots of the row/column should be three
test(bl(X1,Y1), bl(X2,_Y2) ):-
	3 is X1 + Y1 +X2.

% dealing with variants
remove_variants( [], []).
remove_variants( [ X | T], R) :-
	exists_a_variant(X,T),!,     % there still is a variant of X in T 
	remove_variants(T,R).
remove_variants([ X | T], [X |R] ) :-  % no variant exists anymore: keep it 
	remove_variants(T,R).


exists_a_variant(X , [Y | _T]) :-
	is_variant(X,Y), !.
exists_a_variant(X , [_Y | T]) :-
	exists_a_variant(X ,T).

is_variant(S1, S2) :-
	S1 =.. [ conf | S1s],         % S1s is the list of dominoes of S1
	S2 =.. [ conf | S2s],
	append(P1, P2, S1s),
	P1 \== [], P2 \== [],
	append(P2,P1, S2s).

%   some more utility predicates

append([], X,X).
append([X|U], V, [X|W]) :- append(U,V,W).


% just writing the number of spots!!!
mwrite([]).
mwrite([conf(B1,B2,B3,B4)| L]) :-
       mwrite_block(B1), mwrite_block(B2),
       mwrite_block(B3), mwrite_block(B4),nl,
       mwrite(L).    
mwrite_block(bl(X,Y)) :- write(X), write(' '), write(Y), write(' ').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calling the program

% time(G) measures the execution time for the goal G.
time(G):-
	statistics(runtime,_),
	G,
        statistics(runtime,[_,Time]),
        write('tijd: '),write(Time),nl.

% finding and writing out the solutions...
q(C):- sol(C), mwrite([C]).


% timing the search for  all the solutions...
qall(Res) :-
	time(findall(C, sol(C), L)),
				% using findall to collect all the solutions
	remove_variants(L, Res),
	mwrite(Res).
/* ?- qall(Res).
tijd: 30
1 2 0 3 0 2 1 1 
2 0 1 1 1 2 0 1 
2 0 1 2 0 3 0 1 
2 1 0 2 1 1 1 0 
2 1 0 3 0 2 1 0 
3 0 0 1 2 1 0 0 
3 0 0 2 1 2 0 0 
R = [conf(bl(1,2),bl(0,3),bl(0,2),bl(1,1)),conf(bl(2,0),bl(1,1),bl(1,2),bl(0,1)),conf(bl(2,0),bl(1,2),bl(0,3),bl(0,1)),conf(bl(2,1),bl(0,2),bl(1,1),bl(1,0)),conf(bl(2,1),bl(0,3),bl(0,2),bl(1,0)),conf(bl(3,0),bl(0,1),bl(2,1),bl(0,0)),conf(bl(3,0),bl(0,2),bl(1,2),bl(0,0))] ?  ;
no
| ?- 
*/
