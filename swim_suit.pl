
swim(Sol):-
	FN = [FN1, FN2, FN3, FN4, FN5],
    LN = [LN1, LN2, LN3, LN4, LN5],
    Color = [C1, C2, C3, C4, C5],
    Type = [T1, T2, T3, T4, T5],
    Place = [P1, P2, P3, P4, P5],
    
    Sol = [[FN1, LN1, C1, T1, P1], [FN2, LN2, C2, T2, P2], [FN3, LN3, C3, T3, P3], [FN4, LN4, C4, T4, P4], [FN5, LN5, C5, T5, P5]],
    permutation(FN, [amelia, julia, melony, rachel, sarah]),
    permutation(LN, [couch, james, sanford, travers, west]),
    permutation(Color, [black , blue, red, white, yellow]),
    permutation(Type, [one, one, one, two, two]),
    permutation(Place, [1, 2, 3, 4, 5]),
    member([rachel , travers, RachelColor, _, RachelPlace], Sol), RachelColor \= red, 
    member([_, _, white, one, WhitePlace], Sol), RachelPlace is WhitePlace - 1,
    member([melony,MelonyLast, _ ,_, 1], Sol), MelonyLast \= james,
    member([_, _, _, one, 2], Sol),
    member([_, _, yellow, one, _], Sol),
    member([amelia, AmeliaLN, _, _, _], Sol), AmeliaLN \= west,
    member([_, _, black, two, _], Sol),
    member([julia, JuliaLN,_,_,_], Sol), JuliaLN \= couch,
    member([_,james,_,two,_], Sol),
    
    member([rachel, _,_,_,PlaceRachel], Sol),
    member([_, couch, _,_,PlaceCouch], Sol),
    member([_,_,blue,_,PlaceBlue], Sol), PlaceRachel is PlaceCouch - 1, PlaceBlue is PlaceRachel - 2.

:- use_module(library(clpfd)).

onesuit(One1, One2, One3, 2, Yellow, Amelia):- One1 #=2, One2 #=Yellow, One3#=Amelia.
onesuit(One1, One2, One3, 2, Yellow, Amelia):- One1 #= Amelia, One2#= 2, One3#= Yellow.
onesuit(One1, One2, One3, 2, Yellow, Amelia):- One1 #= Yellow, One2#= Amelia,  One3 #= 2.

sol:- 
    FirstName = [Amelia, Julia, Melony, Rachel, Sarah],
    LastName =  [Couch, James, Sanford, Travers, West],
    Color = [Black , Blue, Red, White, Yellow],
    Type = [One1, One2, One3, Two1, Two2],
    
    FirstName ins 1..5, LastName ins 1..5, Color ins 1..5, Type ins 1..5,
    all_different(FirstName), all_different(LastName), all_different(Color), all_different(Type),
    
    Rachel #= Travers, Rachel #\= Red, 
    Rachel #= White - 1, White #= One1 #\/ White #= One2 #\/ White#= One3,
    Melony #\= James, Melony #= 1,
    
    onesuit(One1, One2, One3, 2, Yellow, Amelia),
    
    Amelia #\= West,
    Rachel #= Couch -1, Rachel #= Blue + 2,
    Julia #\= Couch, 
    James #= Two1 #\/ James #= Two2,
    Black #= Two1 #\/ Black #= Two2,
    
    labeling([], FirstName), labeling([], LastName), labeling([], Color), labeling([], Type), 
    write(result(FirstName, LastName, Color, Type)).
