/* ***************** Map ***************** */

:- dynamic(position/3).
/* Facts */


/* Rules */
/* Create Map */
createMap :- generateMap(1,1).
generateMap(X,Y) :- X=<10, Y=<10, assertz(position(X,Y,-)), A is Y+1, generateMap(X,A).
generateMap(X,Y) :- Y>10, A is X+1, generateMap(A,1).
generateMap(11,_).

/* Print Map */
map :- printMap(1,1).
printMap(X,Y) :- X=<10, Y=<10, position(X,Y,Obj) , write(Obj), A is (Y+1), printMap(X,A).
printMap(X,Y) :- Y>10, A is X+1, nl, printMap(A,1).

/* Change Object in Position (X,Y) */
/* Delete Top Most Object in a Position and Assert New Object in a Position in The Lowest Fact */
changeObjectDown(X,Y,Object) :- call(position(X,Y,A)) , retract(position(X,Y,A)) , assertz(position(X,Y,Object)), !.
/* Delete Top Most Object in a Position and Assert New Object in a Position in The Lowest Fact */
changeObjectUp(X,Y,Object) :- call(position(X,Y,A)) , retract(position(X,Y,A)) , asserta(position(X,Y,Object)), !.

/* Creating Deadzone */
deadzone(X,Y) :- Y=<10, changeObjectDown(X,Y,x), A is Y+1, deadzone(X,A).
deadzone(X,Y) :- X=>2, X=<9, changeObjectDown(X,1,x), changeObjDown(X,10,x), A is X+1, deadzone(A,1).
deadzone(X,Y) :- X=:=10, Y=<10, changeObjectDown(X,Y,)