score(danny, 20, fai).
score(danny, 15, plpm).
score(toon, 18, plpm).
score(toon, 4, uai).


max(List, Result):-
    sort(List, SortedList),
    g_reverse(SortedList, [], [Result|_Tail]).

g_reverse([], Res, Res).
g_reverse([Head1|Tail1], Acc, Res):-
    g_reverse(Tail1, [Head1|Acc], Res).

topscore_facts(Course, Student):-
    findall(Score, score(_,Score,Course), ScoreList),
    max(ScoreList, MaxScore),
    score(Student, MaxScore, Course).

topscore_terms(ScoreList, Course, Student):-
    findall(Score, member(score(_,Score,Course), ScoreList), ScoreList2),
    max(ScoreList2, MaxScore),
    score(Student, MaxScore, Course).

%topscore_facts(fai, Student)
%topscore_terms([score(danny, 20, fai),score(danny, 15, plpm), score(toon, 18, plpm),score(toon, 4, uai)], plpm, Student)