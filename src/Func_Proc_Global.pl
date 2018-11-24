get_random_position(X, Y) :-
    random(1, 8, X),
    random(1, 8, Y).

is_pos_same(X1, Y1, X2, Y2, Boolean) :-
    X1=\=X2,
    Boolean is false, !.
is_pos_same(X1, Y1, X2, Y2, Boolean) :-
    Y1=\=Y2,
    Boolean is false, !.
is_pos_same(X1, Y1, X2, Y2, Boolean) :-
    Boolean is true, !.