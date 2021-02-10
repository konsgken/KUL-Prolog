% Facts
worker(danny,3,7).
worker(jeff,2,2).
worker(ann,2,4).

member(X,[X|_T]).
member(X,[_|T]):- member(X,T).

range(High, High, [High]):-!.
range(Low, High, [Head|Tail]):-
    Head = Low,
    NewLow is Low + 1,
    range(NewLow,High, Tail).

create_range(Min1,Max1,Min2,Max2, R1, R2):-
    range(Min1, Max1, R1),
    range(Min2, Max2, R2).
    
check(NumberOfShifts,Range1,Range2):-
	Res is NumberOfShifts//2,
	M is Res,
	P is NumberOfShifts-Res,
    member(M,Range1),
    member(P,Range2).
check(NumberOfShifts,Range1,Range2):-
	Res is NumberOfShifts//2,
	M is Res,
	P is NumberOfShifts-Res,
    member(M,Range2),
    member(P,Range1).


possible_facts(Name1,Name2,NumberOfShifts):-
    worker(Name1,MinShiftsWorker1,MaxShiftsWorker1),
    worker(Name2,MinShiftsWorker2,MaxShiftsWorker2),
    create_range(MinShiftsWorker1,MaxShiftsWorker1,MinShiftsWorker2,MaxShiftsWorker2,Range1,Range2),
    check(NumberOfShifts,Range1,Range2),!, 
    write('Possible').
% possible_facts predicate:- Checks if a Sequence of Shift is possible between two workers.
% possible_facts(danny, ann, 6).

% possible_terms predicate:- Checks if a Sequence of Shift is possible between two workers.
% possible_terms([worker(danny,3,7),worker(jeff,2,2),worker(ann,2,4)],jeff,ann,4).

possible_terms(WorkerList,Name1,Name2,NumberOfShifts):-
    member(worker(Name1,MinShiftsWorker1,MaxShiftsWorker1), WorkerList),
    member(worker(Name2,MinShiftsWorker2,MaxShiftsWorker2), WorkerList),
    create_range(MinShiftsWorker1,MaxShiftsWorker1,MinShiftsWorker2,MaxShiftsWorker2,Range1,Range2),
    check(NumberOfShifts,Range1,Range2),!, 
    write('Possible').
