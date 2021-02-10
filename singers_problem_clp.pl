:- use_module(library(clpfd)).

singers:-
    Voices = [Soprano, Mezzo_Soprano, Tenor1, Tenor2, Bass],
    FirstName = [Chris, JP, Lee, Pat, Val],
	LastName = [Kingsley, Robinson1, Robinson2, Ulrich, Walker],
    FirstName ins 1..5,
    LastName ins 1..5,
    Voices ins 1..5,
    all_different(FirstName),
    all_different(LastName),
    all_different(Voices),
    
    % 1.first and second student are Pat and the bass in some order
    Pat + Bass #= 3,
    %someorder(Pat, Bass),
    % 2. the second and the third students include at least one tenor
    oneormore(Tenor1, Tenor2),
    % 3. fifth is not Robinson, Kingsley and the fifth were a mezzo and a tenor
    %5 #\= Robinson1, 5 #\= Robinson2 , % It can be done also with this way
    Robinson1 #\= 5, Robinson2 #\= 5,
    tenorormezzo(Kingsley,Mezzo_Soprano, Tenor1, Tenor2),
    % 4. third student is a Robinson, neither the third nor Walker has the first name Chris
    (Robinson1 #= 3 #\/ Robinson2 #= 3),
    Chris #\= Walker,  Chris #\= 3,
    %5. Ulrich is not a bass or mezzo
    Ulrich #\= Bass , Ulrich #\= Mezzo_Soprano,
	%6. neither Lee or Val (who is not third) is a tenor
    Lee#\= Tenor1,Lee #\= Tenor2, 
	Val#\= Tenor1,Val #\= Tenor2, Val #\= 3,
	%7. JP was not third and Chris was not fifth
	JP #\= 3, Chris #\= 5,
	% 8. the bass isn't named Robinson
	Bass #\= Robinson1, Bass #\= Robinson2,
	labeling([],FirstName),labeling([],LastName), labeling([],Voices),
    write(result(FirstName, LastName, Voices)),nl.

someorder(Pat, Bass):- Pat #= 1 #<==> B1, Bass #=2 #<==> B2, B1 + B2 #=2.
someorder(Pat, Bass):- Pat #= 2 #<==> B1, Bass #=1 #<==> B2, B1 + B2 #=2.

oneormore2(Tenor1, Tenor2):- Tenor1 #= 2 #<==> B1, Tenor2 #= 3 #<==> B2, B1 + B2 #>= 1.
oneormore2(Tenor1, Tenor2):- Tenor1 #= 3 #<==> B1, Tenor2 #= 2 #<==> B2, B1 + B2 #>= 1.

oneormore(Tenor1,Tenor2):- Tenor1#=3 #\/ Tenor1#=2 #\/ Tenor2#=3 #\/ Tenor2#=2.
tenorormezzo(Kingsley,Mezzo_Soprano, Tenor1, Tenor2):- Kingsley #= Mezzo_Soprano, (Tenor1 #=5 #\/ Tenor2 #=5).
tenorormezzo(Kingsley,Mezzo_Soprano, Tenor1, Tenor2):- 5#=Mezzo_Soprano, (Tenor1 #= Kingsley #\/ Tenor2 #= Kingsley).
    