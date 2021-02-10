decode(N, List, Res) :-
	splitNlists(N,List,Res),
	checkalldiff(Res),  
    checknotprefix(Res), % Check prefix for one direction
    reverse(Res, [RHead|RTail]), % Use your own implementation of reverse.
    checknotprefix([RHead|RTail]). % Check prefix for the opposite direction.

% Split the sequence into individual codes.
splitNlists(1,L2, [L2]).
splitNlists(N,List,[L1 | Res1]) :- 
  append(L1, L2, List),
    L1 = [_|_],
    L2 = [_|_],
    N1 is N - 1,
    splitNlists(N1, L2, Res1).

% Check if all individual codes are different.
checkalldiff([]).
checkalldiff([Head|Tail]):-
    \+ (member(Head,Tail)),
    checkalldiff(Tail).

% Check if all individual codes have different prefixes. 
checknotprefix([]).
checknotprefix([Head|Tail]):-
    checkdiff(Head, Tail),
    checknotprefix(Tail).

% Takes the head of the list and checks if it has different prefixes with the tail.
checkdiff(_Head1,[]).
checkdiff(Head1, [Head2|Tail2]):-
    findall(Res,mPrefix(Head2,Res), List),
    \+ (member(Head1, List)),
    checkdiff(Head1, Tail2).

% Constructs all possible prefixes of a list
mPrefix(_, []).
mPrefix([H|T], [H|NT]):-
  mPrefix(T, NT).

% ?- decode(3, [1,1,0,1,0], ListWithIndividualEncodings).
% Answer: ListWithIndividualEncodings = [[1, 1], [0], [1, 0]]
% ?- decode(4, [0,0,0,1,1,1,0,1,0], ListWithIndividualEncodings).
%ListWithIndividualEncodings = [[0, 0], [0, 1], [1, 1, 0], [1, 0]]
%ListWithIndividualEncodings = [[0, 0], [0, 1, 1], [1], [0, 1, 0]]