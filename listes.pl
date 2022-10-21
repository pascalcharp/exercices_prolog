
unload_file('listes').

%
% cardinal(L, N) est vrai si N est le nombre d'éléments dans la liste L.
%

cardinal([], 0 ) :- !.

cardinal([_|Xs], N) :-
	cardinal(Xs, N1),
    N is N1 +1.

%
% element(E, L) est vrai si E est élément de la liste L.
%

element(E, [E|_]) :- !.

element(E, [_|Xs]) :- element(E, Xs).

%
% element(E, L, N) est vrai si N est le nombre d'occurrence de E dans L.
%

element(_, [], 0).

element(E, [E|Xs], N) :-
    element(E, Xs, N1),
    N is N1 + 1.

element(E, [X|Xs], N) :-  
    \+ (X=E),
    element(E, Xs, N).

%
% concatenation(L1, L2, L) est vrai si L est la concaténation des listes L1|L2
%   

concatenation([], L1, L1).

concatenation([X|Xs], L1, [X|Ls]) :- concatenation(Xs, L1, Ls).

%
% prefixe(P, L) est vrai si P est un préfixe de la liste L, y-compris L elle-même
%

prefixe(P, L) :- concatenation(P, _, L).

%
% prefixe(P, L, M) est vrai si P est un préfixe de la liste L, et que M est 
% identique à L sans le préfixe.
%

prefixe(P, L, M) :- concatenation(P, M, L).

%
% suffixe(S, L) est vrai si S est un suffixe de la liste L, y-compris L elle-même
%
 
suffixe(S, L) :- concatenation(_, S, L).

%
% sous_liste(S, L) est vrai si S est une sous-liste de L
%

sous_liste(S, L) :- prefixe(S, L), !.

sous_liste(S, [_|Xs]) :- sous_liste(S, Xs).

%
% sous_liste(S, L, N) est vrai si S est une sous-liste de L débutant 
% à la position N
%

sous_liste(S, L, 0) :- prefixe(S, L), !.

sous_liste(S, [_|Xs], N) :- sous_liste(S, Xs, N1), N is N1 + 1.

%
% sous_liste(S, L, N, M) est vrai si S est une sous-liste de L à la position
% N et que M est identique à L sans la sous-liste en question
%



%
% inverse(L, M) si M contient les éléments de L en ordre inverse.
%

inverse(L, M) :- aux_inverse(L, [], M).

aux_inverse([], Acc, Acc) :- !.

aux_inverse([X|Xs], Acc, Inv) :-
    aux_inverse(Xs, [X|Acc], Inv).
        
%
% enleve_n(N, L1, L2) est vrai si L2 est la liste L1 sans ses N premiers éléments
%

enleve_n(0, L, L).

enleve_n(N, [_|Xs], L) :-
    enleve_n(N1, Xs, L),
    N is N1 + 1.

%
% prend_n(N, L1, L2) est vrai si L2 contient les N premiers éléments de L1
%

prend_n(0, _, []) :- !.

prend_n(N, [X|Xs], [X|Ys]) :- 
    prend_n(N1, Xs, Ys),
    N is N1+1.

prend_n(N, [X|Xs], [X|Ys]) :- 
	N1 is N-1,
    prend_n(N1, Xs, Ys).

%
% enieme(N, L, E) est vrai si E est le n-ième élément de la liste L, compté à-partir de zéro!!!
%

enieme(N, L, E) :- enleve_n(N, L, [E|_]).

%
% insere_enieme(N, L, E, M) vrai si M est la liste L après insertion de E en position N
% 

insere_enieme(N, L, E, M) :-  
    prend_n(N, L, Pref),
    enleve_n(N, L, Suf),
    concatenation(Pref, [E|Suf], M).

%
% trancher(L, P, D, M) si M est la sous-liste de L allant des indices
% P à D.
%

trancher(L, P, D, M) :-
    Tranche is D - P + 1,
    enleve_n(P, L, Suf),
    prend_n(Tranche, Suf, M).

%
% enleve_premiere_occurrence(L, E, M) est vrai si M est identique à L sauf que la 
% premiere occurrence de E a été retirée.
%

enleve_premiere_occurrence([], _, []) :- !.

enleve_premiere_occurrence([E|Xs], E, Xs) :- !.

enleve_premiere_occurrence([X|Xs], E, [X|M]) :-
    enleve_premiere_occurrence(Xs, E, M).

%
% enleve_toutes_occurrences(L, E, M) la liste M est identique à L mais ne contient aucun E
%

enleve_toutes_occurrences([], _, []) :- !.

enleve_toutes_occurrences([E|Xs], E, M) :-
    enleve_toutes_occurrences(Xs, E, M), !.

enleve_toutes_occurrences([X|Xs], E, [X|M]) :-
    \+(X=E), 
    enleve_toutes_occurrences(Xs, E, M).

%
% elements_pairs(L, P) est vrai si P contient les éléments pairs de L
%

elements_pairs([], []).

elements_pairs([X|Xs], [X|Ps]) :- 
    (X mod 2 =:= 0), 
    elements_pairs(Xs, Ps).

elements_pairs([X|Xs], Ps) :- 
    (X mod 2 =\= 0), 
    elements_pairs(Xs, Ps).

%
% elements_pairs_n(L, P, N) est vrai si P contient les éléments pairs de L et N le cardinal de P
%

elements_pairs_n([], [], 0).

elements_pairs_n([X|Xs], [X|Ps], N) :- 
    (X mod 2 =:= 0), 
    elements_pairs_n(Xs, Ps, N1), 
    N is N1+1.

elements_pairs_n([X|Xs], Ps, N) :- 
    (X mod 2 =\= 0), 
    elements_pairs_n(Xs, Ps, N).

%
% elements_parite(L, P, I, Np, Ni) est vrai si P contient les éléments pairs de L et Np le cardinal de P,
% et si I contient les éléments impairs de L et Ni le cardinal de I.
%

elements_parite([], [], [], 0, 0).

elements_parite([X|Xs], [X|Ps], I, Np, Ni) :- 
    (X mod 2 =:= 0),
    elements_parite(Xs, Ps, I, Np1, Ni),
    Np is Np1 + 1.

elements_parite([X|Xs], P, [X|Is], Np, Ni) :-
    (X mod 2 =\= 0),
    elements_parite(Xs, P, Is, Np, Ni1),
    Ni is  Ni1 + 1.

%
% tri fusion(L, Lt) est vrai si Lt contient tous les éléments de L en ordre croissant.
%

fusion(L, [], L) :- !.

fusion([], L, L) :- !.

fusion([G|Gs], [D|Ds], [G|F]) :-
    G < D,
    fusion(Gs, [D|Ds], F).

fusion([G|Gs], [D|Ds], [D|F]) :-
    D =< G,
    fusion([G|Gs], Ds, F).

separe(L, Lg, Ld) :-
    cardinal(L, N),
    Mid is div(N, 2)-1,
    trancher(L, 0, Mid, Lg),
    Midp1 is Mid + 1,
    Nm1 is N - 1,
    trancher(L, Midp1, Nm1, Ld).

tri_fusion([], []) :- !.

tri_fusion([X], [X]) :- !.

tri_fusion(L, Lt) :-
    separe(L, Lg, Ld),
    tri_fusion(Lg, Lgt),
    tri_fusion(Ld, Ldt),
    fusion(Lgt, Ldt, Lt).




















%
%
%













