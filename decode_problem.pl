pref(Prefix, HCodes):- append(Prefix, _, HCodes).

prefix(_, [], []).
prefix(Prefix, [HCodes|TCodes], [HCodes|TRestCodes]):- \+ pref(Prefix, HCodes), prefix(Prefix, TCodes, TRestCodes).
prefix(Prefix, [HCodes|TCodes], TRestCodes):-  pref(Prefix, HCodes), prefix(Prefix, TCodes, TRestCodes).

acceptableCode(_, []).
acceptableCode(Codes, [HCodesSoFaR|TCodesSoFaR]):-  \+ pref(Codes, HCodesSoFaR), \+ pref(HCodesSoFaR, Codes), acceptableCode(Codes, TCodesSoFaR).

generate(1, Codes, [Codes]).
generate(N, Codes, [HRes|TRes]):-
    N > 1,
    N1 is N - 1,
    append(HRes, L2, Codes),
    HRes \= [],
    L2 \=[],
    generate(N1, L2, TRes).
    
check_prefix([]).
check_prefix([HRes|TRes]):- acceptableCode(HRes, TRes), check_prefix(TRes). 

decode(N, Codes, Res):-
    generate(N, Codes, Res),
    check_prefix(Res).
