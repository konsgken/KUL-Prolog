noattack([]).
noattack([H|T]):- nt(H, T), noattack(T). 

nt(_, []).
nt(X1/Y1, [X2/Y2 | T]):- Y1 \== Y2, Y2-Y1 =\= X2- X1, Y2 - Y1 =\= X1 - X2, nt(X1/Y1, T).  

generate_x(0, []).
generate_x(N, [N/_Y|T]):- N>0, N1 is N-1, generate_x(N1, T). 

collect_y([], []).
collect_y([_X/Y | T], [Y|T1]):- collect_y(T, T1).

range(High, High, [High]).
range(Low, High, [Low|T]):- Low < High, NewLow is Low + 1, range(NewLow, High, T).

nqueens(N, Sol):- 
    generate_x(N, RSol),
	collect_y(RSol, Ys),
    range(1, N, Range),
    permutation(Ys, Range),
    noattack(RSol),
    reverse(RSol, Sol).
