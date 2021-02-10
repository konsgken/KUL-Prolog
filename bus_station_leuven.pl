shifts(danny,3,7).
shifts(jef, 2, 2).
shifts(ann, 2, 4).

create_range(Min1, Max1, Min2, Max2, Range1, Range2):-
	range(Min1, Max1, Range1),
	range(Min2, Max2, Range2).
	
check(Range1, Range2):-
	 
	

possible(Worker1, Worker2):-
	shifts(Worker1, Min1, Max1),
	shifts(Worker2, Min2, Max2),
	create_range(Min1, Max1, Min2 , Max2, Range1, Range2),
	
	check(Range1, Range2),
	write('Possible').