# Bibliothèque de prédicats pour les listes en prolog

## Fichier listes.pl: règles

- cardinal(L, N) N est le nombre d'éléments de L.
- element(E, L) E appartient à L
- element(E, L, N) E apparait N fois dans L
- concatenation(L1, L2, L) L1:L2 donne L
- prefixe(P, L) P est un préfixe de L
- prefixe(P, L, M) P:M donne L
- suffixe(S, L) S est un suffixe de L
- sous_liste(S, L) S est une sous-liste de L
- sous_liste(S, L, N) S est une sous-liste de L débutant en position N
- sous_liste(S, L, N, M) S est une sous-liste de L en position N et M=L\S
- inverse(L, M) M est L inversée
- enleve_n(N, L1, L2) L1 sans ses N premiers éléments est L2
- prend_n(N, L1, L2) L2 contient les N premiers éléments de L1
- enieme(N, L, E) E est le N-ième élément de L (débutant à 0)
- insere_enieme(N, L, E, M) E est le N-ième élément de L et M=L\E
- trancher(L, P, D, M) est est la tranche de L des positions  P à D inclusivement
- enleve_premiere_occurrence(L, E, M) M vaut L sans la première occurrence de E
- enleve_toutes_occurrences(L, E, M) M vaut L dont on retire tous les E
- elements_pairs(L, P, N) P est la liste des N éléments pairs de L
- elements_pairs(L, P) P est la liste des éléments pairs de L
- elements_parite(L, P, I, Np, Ni) P est la liste des Np éléments pairs et I est la liste des Ni éléments impairs de L
-  tri_insertion(L, T) L triée -> T
- tri_fusion(L, T) L triée -> T
- tri_rapide(L, T) L triée -> T

## Fichier testlistes.pl: tests unitaires
