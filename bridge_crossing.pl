initial([0,left,[a,b,c,d],[]]).
final([17, right, [], [a,b,c,d]]).

remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X, T, T1).

time(a, 1).
time(b, 2).
time(c, 5).
time(d, 10).

flashlight(left, right).
flashlight(right, left).

take([X], List, Res):- remove(X, List, Res).
take([X1, X2], List, Res):- remove(X1, List, L1), remove(X2, L1, Res).

compute_time([], 0).
compute_time([H|T], Time):- compute_time(T, PartialTime), time(H, TimeInd), Time is max(PartialTime, TimeInd).
    
move([Time1, left, L1, R1], [Time2, right, L2, R2]):-
    take(Remaining, L1, L2),
    append(Remaining, R1, R2),
    compute_time(Remaining, RemainingTime),
    Time2 is Time1 + RemainingTime.

move([Time1, right, L1, R1], [Time2, left, L2, R2]):-
    take(Remaining, R1, R2),
    append(Remaining, L1, L2),
    compute_time(Remaining, RemainingTime),
    Time2 is Time1 + RemainingTime.

path(Final , Path, [Final|Path]):- final(Final).
path(Initial, Path , Sol):- move(Initial , Next), Next = [Time, _,_,_], Time =< 17, \+ member(Next, Path),  path(Next, [Initial|Path], Sol).

start(Sol):- initial(Initial), path(Initial, [] , Sol1), reverse(Sol1, Sol).
