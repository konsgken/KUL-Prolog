shifts(danny, 3, 7).
shifts(jef, 2, 2).
shifts(ann, 2, 4).

bet(X, _Y, El):- X=El.
bet(X, Y, El):- X<Y, NewX is X + 1, bet(NewX, Y, El).

possible(Worker1, Worker2, NumberShifts, ShiftsWorker1, ShiftsWorker2):- 
    shifts(Worker1, MinWorker1, MaxWorker1),
    shifts(Worker2, MinWorker2, MaxWorker2), 
    bet(MinWorker1, MaxWorker1, ShiftsWorker1),
    bet(MinWorker2, MaxWorker2, ShiftsWorker2),
    NumberShifts is ShiftsWorker1 + ShiftsWorker2,
    ((ShiftsWorker1 - ShiftsWorker2 =< 1, ShiftsWorker1 - ShiftsWorker2 >=0 ); (ShiftsWorker2 - ShiftsWorker1 =< 1, ShiftsWorker2 - ShiftsWorker1 >= 0)), !.
