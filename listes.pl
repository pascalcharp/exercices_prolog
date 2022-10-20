
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
% concatenation(L1, L2, L) est vrai si L est la concaténation des listes L1|L2
%   

concatenation([], L1, L1).

concatenation([X|Xs], L1, [X|Ls]) :- concatenation(Xs, L1, Ls).

%
% prefixe(P, L) est vrai si P est un préfixe de la liste L, y-compris L elle-même
%

prefixe(P, L) :- concatenation(P, _, L).

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
% enleve_n(N, L1, L2) est vrai si L2 est la liste L1 sans ses N premiers éléments
%

enleve_n(0, L, L).

enleve_n(N, [_|Xs], L) :-
    enleve_n(N1, Xs, L),
    N is N1 + 1.

%enleve_n(N, [_|Xs], L) :-
%	N1 is N - 1,
%    enleve_n(N1, Xs, L).
   
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














