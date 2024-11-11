
parent(john, mary).
parent(mary, susan).
parent(mary, tom).
parent(tom, anny).

friend(mary, suman).
friend(suman, anny).

grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

ancestor(X, Y) :-
    parent(X, Y).

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% X and Y are friends if Y and X are friends (friendship is mutual)
friend(X, Y) :-
    friend(Y, X).

% Define a rule to check if X and Y are connected through a chain of friends
connected_through_friends(X, Y) :-
    friend(X, Y).

connected_through_friends(X, Y) :-
    friend(X, Z),
    connected_through_friends(Z, Y).

