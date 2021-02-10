preorder(nil, []).
preorder(t(L,V,R),ValueList):-
    preorder(L, VL),
    preorder(R, VR),
    append([V], VL ,X),
    append(X, VR, ValueList).
    
% Implementation od preorder using difference of Lists. 
append_dl(A1-B1,A2-B2,A1-B2) :- B1 =A2.

value_begin(V, A-B, X-B):- X = [V|A].

preorder_dl(T,List) :- preorder2(T,List-[]).
preorder2(nil, A-A).
preorder2(t(L,V,R),X-D):-
    preorder2(L, A-B),
    preorder2(R, C-D),
    value_begin(V, A-B , X - B),
    append_dl(X-B, C-D, X-D).

% ?- preorder(t(t(nil,[f(a,b)],t(nil,[21,22,23],nil)),[root,1,2], t(t(nil,[a],nil), [child,4], nil)),Res)
% ?- preorder_dl(t(t(nil,[f(a,b)],t(nil,[21,22,23],nil)),[root,1,2], t(t(nil,[a],nil), [child,4], nil)),Res)
% The are not needed in order to answer the exercise. It is just for practice with trees.
lin(nil, []).
lin(t(L,V,R), ValueList):-
    lin(L, VL),
    lin(R, VR),
    append(VL, [V|VR], ValueList).

max(El1, El2, Res):- El1=<El2, Res=El2,!.
max(El1, El2, Res):- El1>El2, Res=El1.

depth(nil, 0).
depth(t(L,_V,R), Depth):-
    depth(L,DL),
    depth(R,DR),
    max(DL,DR,D1),
    Depth is D1+1.

intree(Element, t(_,Element,_)).
intree(Element, t(L,_V,_R)):- intree(Element,L).
intree(Element, t(_L,_V,R)):- intree(Element,R).

count_leaves1(nil,0).
count_leaves1(t(nil,_,nil),1) :- !.
count_leaves1(t(L,_,R),N) :-  count_leaves1(L,NL), count_leaves1(R,NR), N is NL+NR.


leaves1(nil,[]).
leaves1(t(nil,X,nil),[X]) :- !.
leaves1(t(L,_,R),S) :- 
    leaves1(L,SL), leaves1(R,SR), append(SL,SR,S).

internals1(nil,[]).
internals1(t(nil,_,nil),[]) :- !.
internals1(t(L,X,R),[X|S]) :- 
    internals1(L,SL), internals1(R,SR), append(SL,SR,S).

atlevel(nil,_,[]).
atlevel(t(_,X,_),1,[X]).
atlevel(t(L,_,R),D,S) :- D > 1, D1 is D-1,
   atlevel(L,D1,SL), atlevel(R,D1,SR), append(SL,SR,S).

allthesame(Tree):- allts(Tree, _Value).
allts(nil, _).
allts(t(L,V,R),V):- allts(L,V), allts(R,V)