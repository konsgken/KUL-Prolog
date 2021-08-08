distance(heverlee, leuven-city-center, 10).
distance(leuven-station, leuven-city-center, 8).
distance(a, b, 2).
distance(c, b, 4).

stop(heverlee, 4).
stop(leuven-station, 10).
stop(leuven-city-center, 10).
stop(a, 1).
stop(c, 1).

dist(A, B, Dist):- distance(A, B, Dist).
dist(A, B, Dist):- distance(B, A, Dist).

costBus(Final, Final, Path, [Final|Path], 0).
costBus(Initial, Final, Path, Sol, Distance):- 
    dist(Initial, Node, DistanceNode),
    \+ member(Node, Path),
    costBus(Node, Final, [Initial|Path], Sol, PartialDistance),
    Distance is PartialDistance + DistanceNode.

% ?- costBus(leuven-station, heverlee, [], Sol, Distance)
