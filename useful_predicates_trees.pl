create([], nil).
create(List, t(T1,M,T2)):- length(List, Length), Mid is Length // 2, length(L1, Mid), append(L1, [M|L2], List),
    create(L1, T1), create(L2, T2).

/*
          1
        / \
       /   \
      /     \
     2       3
    / \     /
   4   5   6
  /       / \
 7       8   9

preorder:    1 2 4 7 5 3 6 8 9
inorder:     7 4 2 5 1 8 6 9 3
postorder:   7 4 5 2 8 9 6 3 1
level-order: 1 2 3 4 5 6 7 8 9

 preorder(t(t(t(t(nil, 7,nil),4,nil),2,t(nil,5,nil)),1,t(t(t(nil,8,nil),6,t(nil,9,nil)),3,nil)),V)
*/ 
preorder(nil, []).
preorder(t(L,V,R),ValueList):-
    preorder(L, VL),
    preorder(R, VR),
    append([V], VL ,X),
    append(X, VR, ValueList).
    
inorder(nil, []).
inorder(t(L, V, R), S):- 
    inorder(L, SL),
    inorder(R, SR) ,
    append(SL, [V], X), 
    append(X, SR, S).

postorder(nil, []).
postorder(t(L, V, R), ValueList):-
    postorder(L, VL),
    postorder(R, VR),
    append(VL, VR, X),
    append(X, [V], ValueList).

atlevel(nil,_,[]).
atlevel(t(_,X,_),1,[X]).
atlevel(t(L,_,R),D,S) :- D > 1, D1 is D-1,
   atlevel(L,D1,SL), atlevel(R,D1,SR), append(SL,SR,S).

depth(nil, 0).
depth(t(L, _V, R), Depth):- depth(L, DL), depth(R, DR), D1 is max(DL, DR), Depth is D1 + 1.

flatten([],[]).
flatten(X, [X]):- atomic(X), X\==[].
flatten([H|T], L3) :- flatten(H, L1), flatten(T, L2), append(L1, L2, L3).

level_order(Tree, ValueList):- depth(Tree, Depth), bfs(Tree, Depth, Res), reverse(Res, V1), flatten(V1, ValueList).

bfs(_, 0, []).
bfs(Tree, Depth , [Nodes|Res]):- atlevel(Tree, Depth, Nodes), Depth > 0, TempDepth is Depth -1 , bfs(Tree, TempDepth, Res).
