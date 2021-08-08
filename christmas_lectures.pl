nextto(X, Y, [X, Y|_]).
nextto(X, Y, [_|Zs]):- nextto(X, Y, Zs).

near(X, Y, List):- nextto(X, Y, List); nextto(Y, X, List).

solution(Sol):-
	Courses = [C1, C2, C3, C4, C5],
    Days = [monday, tuesday, wednesday, thursday, friday],
    FirstName = [FN1, FN2, FN3, FN4, FN5],
    LastName = [LN1, LN2, LN3, LN4, LN5],
    Sex = [S1, S2, S4, S4, S5],
    
    Sol = [[FN1, LN1, C1, monday, S1], [FN2, LN2, C2, tuesday, S2], [FN3, LN3, C3, wednesday, S3], [FN4, LN4, C4, thursday, S4], [FN5, LN5, C5, friday, S5]],
    
    permutation(Courses, [bioinformatics, hygiene, art, nutrition, habits]),
    permutation(FirstName, [alice, bernadette, charles, duane, eddie]),
    permutation(LastName, [felicidad, garber, haller, itakura, jeffreys]),
    permutation(Sex, [woman, woman, man, man, man]),
    
    member([alice, _, _, monday, woman], Sol),
    member([charles, _, hygiene, CharlesDay, man], Sol), CharlesDay \= friday,
    member([_, jeffreys, nutrition, _, _], Sol),
    member([_, _, art, _, man], Sol),
    member([_, itakura, _, ItakuraDay, _], Sol), member([_, _, habits, HabitsDay, _], Sol), near(ItakuraDay, HabitsDay, Days),
    member([_, haller, _, HallerDay, _], Sol), member([eddie, _, _, EddieDay, man], Sol), nextto(EddieDay, HallerDay, Days),
    member([duane, felicidad, _, DuaneDay, man], Sol), member([_, _, art, ArtDay, _], Sol), nextto(DuaneDay, ArtDay, Days).



:- use_module(library(clpfd)).

sol2:- 


    FirstName = [Alice, Bernadet, Charles, Duane, Eddie],
    LastName = [Felicidad, Garber, Haller, Itakura, Jeffreys],
    Lectures = [Bioinformatics, Hygiene, Art, Nutrition , Habits],
    Days = [Monday, Tuesday, Wednesday, Thursday, Friday],
    
    FirstName ins 1..5, LastName ins 1..5, Lectures ins 1..5, Days ins 1..5,
    all_different(FirstName), all_different(LastName), all_different(Lectures), all_different(Days), 
    % Alice, Bernadet, 2 women
    % Charles, Duane, Eddie, 3 men
    
    Alice #= Monday, 
    Charles #= Hygiene, Charles #\= Friday,
    Jeffreys #= Nutrition,
    
    Charles #= Art #\/ Duane #= Art #\/ Eddie #= Art,
    Itakura #= Alice #\/  Itakura #= Bernadet,
    consecutive(Itakura, Habits),
    Haller #= Eddie + 1, 
    Duane #= Felicidad, Duane #= Art - 1,
    labeling([], FirstName), labeling([], LastName), labeling([], Lectures), labeling([], Days), 
    write(result( FirstName, LastName, Lectures, Days)).
    
    
consecutive(Itakura, Habits):- Itakura - Habits #= 1.
consecutive(Itakura, Habits):- Habits - Itakura #= 1.
