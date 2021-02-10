%wins(2,1).
%wins(1,3).
%wins(1,4).
%wins(3,2).
%wins(2,4).
%wins(3,4).

% Knowldge base , which player 1 always wins.
wins(1,2).
wins(3,4).
wins(5,6).
wins(7,8).
wins(1,3).
wins(5,7).
wins(1,5).


append([],X,X).
append([A|B],C,[A|D]):-append(B,C,D).

% It makes all the different permutations of a List with Length= Length. 
initSequence(Length,PermutatedList):-
	range(1, Length, Output),
	permList(Output,PermutatedList).

range(Head, Head, [Head]):-!.
range(Low, High, [Head|Tail]):-
    Head = Low, 
    NewLow is Low + 1,
    range(NewLow, High, Tail).

remove(X,[X|T],T).
remove(X,[F|T],[F|T1]) :- remove(X,T,T1).

permList([],[]).
permList([X|Y],Z) :- permList(Y,W), remove(X,Z,W).

%Checks for every pair who wins and returns the winners
oneMatch([],[]).
oneMatch([A,B|T],[A|Winners]):-
	wins(A,B),
	oneMatch(T,Winners).

oneMatch([A,B|T],[B|Winners]):-
	wins(B,A),
	oneMatch(T,Winners).

% Finds the winner of the tournament
winner([X],X):-!.
winner(Sequence, Winner):-
	oneMatch(Sequence, Winners),
	winner(Winners,Winner).

% Finds how many times a Player won for all the possible sequences (permutations)
numberWins(Player,NumberOfPlayers,Output):-
	findall(X,(initSequence(NumberOfPlayers,List),winner(List,X),X = Player),Output).
