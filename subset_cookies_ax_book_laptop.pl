%Solution
item(ax,50,40).
item(book,50,50).
item(cookies,10,5).
item(laptop,99,60).

%Creating the subsets of the given elements in a list
subset([],[]).
subset([First|Rest], [First|Sub]):-subset(Rest, Sub).
subset([_First|Rest], Sub):- subset(Rest, Sub).

%The solution is considered whereas the input is given as the list of facts
%solve([item(ax,50,40),item(book,50,50),item(cookies,10,5),item(laptop,99,60)],90,40,Result)

solve(List_of_items,W,V,ItemsOut):-findall(L1,subset(List_of_items,L1),Result_combinations),
       findall(H,(member(H,Result_combinations),sum_of_list(H,SumW,SumV),SumW<W,SumV>V),ItemsOut).

sum_of_list([],0,0).
sum_of_list([item(_,W1,V1)|T],SumW,SumV):-sum_of_list(T,SumWTail,SumVTail),SumW is SumWTail+W1,SumV is SumVTail+V1.


%Sub question-3. The highest V value is asked. Highest V Values in the question is bit ambiguous.

solve_highest(List_of_items, HighV):- findall(Value, member(item(_,_, Value), List_of_items), ValueList),
    									sort(ValueList, SortedValueList),
    									last(SortedValueList, HighV).
last([Last], Last).
last([_Head|Tail], Last):-
    last(Tail, Last).


%Query
%solve([item(ax,50,40),item(book,50,50),item(cookies,10,5),item(laptop,99,60)],90,40,Result)

%Result
%[[item(ax, 50, 40), item(cookies, 10, 5)], [item(book, 50, 50), item(cookies, 10, 5)], [item(book, 50, 50)]]

%Query - Highest
%solve_highest([item(ax,50,40),item(book,50,50),item(cookies,10,5),item(laptop,99,60)],Result),write('Highest V value is..'),write(Result)

%Result
%Highest V value is..60
