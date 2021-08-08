remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X, T, T1).

remove_list([], List, List).
remove_list([H|T], List, Res):- remove(H, List, R1), remove_list(T, R1, Res).

bad([East, West, _]):- member(farmer, West), member(goat, East), member(wolf, East).
bad([East, West, _]):- member(farmer, East), member(goat, West), member(cabbage, West).
bad([East, West, _]):- member(farmer, East), member(goat, West), member(wolf, West).
bad([East, West, _]):- member(farmer, West), member(goat, East), member(cabbage, East).

initial([[cabbage, farmer, goat, wolf], [], east]).
final([[], [ cabbage, farmer, goat, wolf], west]).

path([[], Final1, west], Path, [[[], Final1, west]|Path]):- final([[], FinalW, west]) ,permutation(FinalW, Final1).
path(Initial , Path , Sol):-  move(Initial, Node), not(bad(Node)), not(member(Node, Path)), path(Node, [Initial|Path], Sol).

boat(M):- member(M, [[farmer], [farmer, goat], [farmer, wolf], [farmer, cabbage]]).
move([East1, West1, east], [East2, West2, west]):-
    boat(M),    
    remove_list(M, East1, East2),
    append(M, West1, West2X), sort(West2X, West2).

move([East1, West1, west], [East2, West2, east]):-
	boat(M), 
    remove_list(M, West1, West2),
    append(M, East1, East2X), sort(East2X, East2).

sol(Sol):- initial(Initial), path(Initial, [], Sol).
