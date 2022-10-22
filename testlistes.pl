/**********************************************************
 * SUITE DE TESTS UNITAIRES POUR LISTES
 **********************************************************/

%
% Recharger la base de règles
% 

:- include(listes).

%
% expect_true(Description, Predicat): ce prédicat est évalué à vrai si Description est affichée ET
% - Predicat est vrai et le message de réussite est affiché OU
% - Predicat est faux et le message d'échec est affiché.
%
% Utilisé pour évaluer une condition vraie.
%

expect_true(Description, Predicat) :-
    write("TEST: "), write(Description),
    (Predicat -> write("\x1B[32m\tTEST RÉUSSI\x1B[0m"), nl) ;
    (\+(Predicat) -> write("\x1B[31m\tTEST ECHOUE\x1B[0m"), nl).

%
% expect_false(Description, Predicat): évalué à vrai si Description est affichée ET
% - Predicat est faux et le message de réussite est affiché
% - Predicat est vrai et le message d'échec est affiché.
%
% Utilisé pour évaluer un prédicat qui doit retourner faux.
%

expect_false(Description, Predicat) :-
    write("TEST: "), write(Description),
    (\+(Predicat) -> write("\x1B[32m\tTEST RÉUSSI\x1B[0m"), nl) ; 
    (Predicat -> write("\x1B[31m\tTEST ECHOUE\x1B[0m"), nl).

%
% Listes tests
%

lt_vide([]).
lt_un([1]).
lt_deux([1, 2]).
lt_trois([1, 2, 3]).
lt_26([2, 3, 4, 5, 6]).
lt_36([3, 4, 5, 6]).
lt_six([1, 2, 3, 4, 5, 6]).

%
% TESTS
%

%
% cardinal
%

?- expect_true("Liste vide, cardinal nul", cardinal([], 0)).
?- expect_false("Liste vide, cardinal non-nul faux", cardinal([], 1)).
?- expect_true("Liste 6, cardinal 6", (lt_six(L), cardinal(L, 6))).
?- expect_false("Liste 6, cardinal 5, faux", (lt_six(L), cardinal(L, 5))).

%
% element
%

?- expect_false("liste vide n'a aucun élément", element(1, [])).
?- expect_true("liste 6 élément valide", element(1, [1, 2, 3, 4, 5, 6])).
?- expect_true("liste 6 dernier élément", element(6, [1, 2, 3, 4, 5, 6])).
?- expect_false("liste 6 élément invalide", element(26, [1, 2, 3, 4, 5, 6])).

%
% element/3
%

?- expect_true("Liste vide 0 occurrences", element(1, [], 0)).
?- expect_true("Liste 6 éléments, un présent", element(3, [1, 2, 3, 4, 5], 1)).
?- expect_true("Liste 6 éléments, répétition", element(3, [1, 3, 2, 3, 4, 3], 3)).

%
% concatenation
%

?- expect_true("lt_six = vide + lt_six", (lt_six(L), concatenation([], L, L))).
?- expect_true("lt_six = lt_six + vide", (lt_six(L), concatenation(L, [], L))).
?- expect_true("lt_six = lt_un+lt_26", (lt_un(L1), lt_26(L26), lt_six(L6), concatenation(L1, L26, L6))).
?- expect_true("lt_six = lt_deux+lt_36", (lt_deux(L2), lt_36(L36), lt_six(L6), concatenation(L2, L36, L6))).
?- expect_false("lt_six = lt_un+lt_36, faux", (lt_un(L1), lt_36(L36), lt_six(L6), concatenation(L1, L36, L6))).

%
% prefixe/2
%

?- expect_true("liste prefixe d'elle-même", (lt_six(L6), prefixe(L6, L6))).
?- expect_true("liste vide est un prefixe", (prefixe([], [1, 2]))).
?- expect_true("lt_deux prefixe de lt_trois", (lt_deux(L2), lt_trois(L3), prefixe(L2, L3))).
?- expect_true("lt_deux prefixe de lt_six", (lt_deux(L2), lt_six(L6), prefixe(L2, L6))).
?- expect_false("lt_26 prefixe lt_six faux", (lt_26(L26), lt_six(L6), prefixe(L26, L6))).

%
% prefixe/3
%

?- expect_true("liste prefixe d'elle-même", (lt_six(L6), prefixe(L6, L6, []))).
?- expect_true("liste vide est un prefixe", (prefixe([], [1, 2], [1, 2]))).
?- expect_true("lt_deux prefixe de lt_trois", (lt_deux(L2), lt_trois(L3), prefixe(L2, L3, [3]))).
?- expect_true("lt_deux prefixe de lt_six", (lt_deux(L2), lt_six(L6), prefixe(L2, L6, [3, 4, 5, 6]))).
?- expect_false("lt_26 prefixe lt_six faux", (lt_26(L26), lt_six(L6), prefixe(L26, L6, _))).

%
% suffixe
%
?- expect_true("liste vide est un suffixe", (suffixe([], [1, 2, 3]))).
?- expect_true("liste est suffixe d'elle-même", (lt_six(L6), suffixe(L6, L6))).
?- expect_true("suffixe de lt_six", (lt_six(L6), suffixe([4, 5, 6], L6))).
?- expect_false("suffixe non-valide de lt_six", (lt_six(L6), suffixe([4, 5], L6))).

%
% sous_liste
%

?- expect_true("liste vide est une sous-liste", (lt_six(L6), sous_liste([], L6))).
?- expect_true("liste est une sous-liste d'elle-même", (lt_six(L6), sous_liste(L6, L6))).
?- expect_true("sous-liste valide de L6", (lt_six(L6), sous_liste([3, 4, 5], L6))).
?- expect_false("sous-liste non-valide de L6", (lt_six(L6), sous_liste([1, 3, 4], L6))).
?- expect_false("sousl-liste trop longue de L6", (lt_six(L6), sous_liste([0, 1, 2, 3, 4, 5, 6], L6))).

%
% sous_liste
%

?- expect_true("liste vide est une sous-liste", (lt_six(L6), sous_liste([], L6, 0))).
?- expect_true("liste est une sous-liste d'elle-même", (lt_six(L6), sous_liste(L6, L6, 0))).
?- expect_true("sous-liste valide de L6", (lt_six(L6), sous_liste([3, 4, 5], L6, 2))).
?- expect_false("sous-liste non-valide de L6", (lt_six(L6), sous_liste([1, 3, 4], L6, _))).
?- expect_false("sousl-liste trop longue de L6", (lt_six(L6), sous_liste([0, 1, 2, 3, 4, 5, 6], L6, _))).

%
% sous_liste/4
%

?- expect_true("sous-liste valide, 5 éléments", sous_liste([3, 4], [1, 2, 3, 4, 5], 2, [1, 2, 5])).

%
% inverse
%

?- expect_true("inverse vide", (inverse([], []))).
?- expect_true("inverse singleton", (inverse([a], [a]))).
?- expect_true("inverse éléments répétés", (inverse([a, a, a, a], [a, a, a, a]))).
?- expect_true("inverse valide", (inverse([a, b, c, d], [d, c, b, a]))).

%
% enleve_n
%

?- expect_true("enleve aucun element", (lt_six(L6), enleve_n(0, L6, L6))).
?- expect_true("enleve premier element", (lt_six(L6), enleve_n(1, L6, [2, 3, 4, 5, 6]))).
?- expect_true("enleve deux elements", (lt_six(L6), enleve_n(2, L6, [3, 4, 5, 6]))).
?- expect_true("enleve tous les elemens", (lt_six(L6), enleve_n(6, L6, []))).
?- expect_false("enleve trop d'éléments", (lt_six(L6), enleve_n(7, L6, _))).

%
% prend_n
%

?- expect_true("prend aucun element", (lt_six(L6), prend_n(0, L6, []))).
?- expect_true("prend un élément", (lt_six(L6), prend_n(1, L6, [1]))).
?- expect_true("prend deux éléments", (lt_six(L6), prend_n(2, L6, [1, 2]))).
?- expect_true("prend tous les éléments", (lt_six(L6), prend_n(6, L6, L6))).
?- expect_false("prend trop d'éléments", (lt_six(L6), prend_n(7, L6, _))).

%
% enieme
%

?- expect_true("premier element de l6 est 1", (lt_six(L6), enieme(0, L6, 1))).
?- expect_false("premier élément de l6 n'est pas 5", (lt_six(L6), enieme(0, L6, 5))). 
?- expect_true("element 1 de l6 est 2", (lt_six(L6), enieme(1, L6, 2))).
?- expect_false("element 1 de l6 n'est pas 23", (lt_six(L6), enieme(2, L6, 23))).
?- expect_true("element 5 de l6 est 6", (lt_six(L6), enieme(5, L6, 6))).
?- expect_false("element 5 de l6 n'est pas 1", (lt_six(L6), enieme(5, L6, 1))).
?- expect_false("element 7 de L6 false", (lt_six(L6), enieme(7, L6, _))).

%
% insere_enieme
%

?- expect_true("insere au debut", (lt_six(L6), insere_enieme(0, L6, 23, [23, 1, 2, 3, 4, 5, 6]))).
?- expect_true("insere au milieu", (lt_six(L6), insere_enieme(3, L6, 23, [1, 2, 3, 23, 4, 5, 6]))).
?- expect_true("insere en fin", (lt_six(L6), insere_enieme(6, L6, 23, [1, 2, 3, 4, 5, 6, 23]))).
?- expect_false("insertion non valide", (lt_six(L6), insere_enieme(8, L6, 23, _))).

%
% trancher
%

?- expect_true("trancher valide", trancher([1, 2, 3, 4, 5], 1, 3, [2, 3, 4])).
%
% enleve_premiere_occurrence
%

?- expect_true("enleve premiere occurrence milieu", (enleve_premiere_occurrence([1, 2, 3], 2, [1, 3]))).
?- expect_true("enleve premiere occurrence debut", (enleve_premiere_occurrence([1, 2, 3], 1, [2, 3]))).
?- expect_true("enleve premiere occurrence fin", (enleve_premiere_occurrence([1, 2, 3], 3, [1, 2]))).
?- expect_true("enleve premiere occurrence multiples", (enleve_premiere_occurrence([1, 1, 1], 1, [1, 1]))).
?- expect_true("enleve premiere occurrence absent", (enleve_premiere_occurrence([1, 2, 3], 8, [1, 2, 3]))).

%
% enleve_toutes_occurrences
%

?- expect_true("enleve toutes occurrences", (enleve_toutes_occurrences([1, 1, 2, 1, 3, 4, 1, 6], 1, [2, 3, 4, 6]))).
?- expect_true("enleve toutes occurences absent", (enleve_toutes_occurrences([1, 1, 2, 1, 3, 4, 1, 6], 57, [1, 1, 2, 1, 3, 4, 1, 6]))).
?- expect_true("enleve_toutes_occurrences_vide", (enleve_toutes_occurrences([], 1, []))).
?- expect_true("enleve_toutes_occurrences_total", (enleve_toutes_occurrences([1, 1, 1, 1, 1], 1, []))).

%
% elements_pairs
%

?- expect_true("elements pairs vide est vide", (elements_pairs([], []))).
?- expect_true("elements pairs tous impairs", (elements_pairs([1, 3, 5, 7, 9], []))).
?- expect_true("elements pairs tous pairs", (elements_pairs([0, 2, 4, 6, 8], [0, 2, 4, 6, 8]))).
?- expect_true("elements pairs mixtes", (elements_pairs([0, 1, 2, 3, 4, 5], [0, 2, 4]))).

%
% elements_pairs_n
%

?- expect_true("elements pairs n vide est vide", (elements_pairs_n([], [], 0))).
?- expect_true("elements pairs n tous impairs", (elements_pairs_n([1, 3, 5, 7, 9], [], 0))).
?- expect_true("elements pairs n tous pairs", (elements_pairs_n([0, 2, 4, 6, 8], [0, 2, 4, 6, 8], 5))).
?- expect_true("elements pairs n mixtes", (elements_pairs_n([0, 1, 2, 3, 4, 5], [0, 2, 4], 3))).

%
% elements_parite
%

?- expect_true("elements parite vide est vide", (elements_parite([], [], [], 0, 0))).
?- expect_true("elements parite tous impairs", (elements_parite([1, 3, 5, 7, 9], [], [1, 3, 5, 7, 9], 0, 5))).
?- expect_true("elements parite tous pairs", (elements_parite([0, 2, 4, 6, 8], [0, 2, 4, 6, 8], [], 5, 0))).
?- expect_true("elements parite mixtes", (elements_parite([0, 1, 2, 3, 4, 5], [0, 2, 4], [1, 3, 5], 3, 3))).
?- expect_false("elements parite mixtes faux", (elements_parite([0, 1, 2, 3, 4, 5], [0, 4], [1, 3, 5], 1, 3))).

%
%
%





