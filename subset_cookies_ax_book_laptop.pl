item(ax, 50, 40).
item(book, 50, 50).
item(box, 10, 5).
item(laptop, 99, 60).

subset([], []).
subset([First|Rest], [First|Sub]):- subset(Rest, Sub).
subset([_First|Rest], Sub):- subset(Rest, Sub).

sum([], 0, 0).
sum([item(_Item, Weight, Value)|T], TotalWeight, TotalValue):-
    sum(T, PartialWeight, PartialValue),
    TotalWeight is Weight + PartialWeight,
    TotalValue is Value + PartialValue.

solve(MaxWeight, MaxValue, Res):-
    findall(item(Item , Weight, Value), item(Item , Weight, Value), List),
    subset(List, Res), sum(Res, TotalWeight, TotalValue),
    TotalWeight < MaxWeight, TotalValue > MaxValue.
    
highest(Res):- 
    findall(Value, item(_Item , _Weight, Value), List),
    sort(List, SortedList),
    reverse(SortedList, [HighestValue|_T]),
    item(Item , Weight, HighestValue),
	Res=item(Item ,Weight, HighestValue).
    
