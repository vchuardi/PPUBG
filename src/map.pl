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
/*  */
changeZoneHorizontal(X,Y1,Y2) :- Y1=<Y2, changeObjectDown(X,Y1,x), A is Y1+1, changeZoneHorizontal(X,A,Y2).
changeZoneVertical(X1,X2,Y) :- X1=<X2, changeObjectDown(X1,Y,x), A is X1+1, changeZoneHorizontal(A,X2,Y).

/* From The Outer Boundary to The Inner Boundary */
deadzone(1) :- changeZoneHorizontal(1,1,10), changeZoneHorizontal(10,1,10), changeZoneVertical(2,9,1), changeZoneVertical(2,9,10).
deadzone(2) :- changeZoneHorizontal(2,1,10), changeZoneHorizontal(9,1,10), changeZoneVertical(2,9,2), changeZoneVertical(2,9,9).
deadzone(3) :- changeZoneHorizontal(3,1,10), changeZoneHorizontal(8,1,10), changeZoneVertical(2,9,3), changeZoneVertical(2,9,8).
deadzone(4) :- changeZoneHorizontal(4,1,10), changeZoneHorizontal(7,1,10), changeZoneVertical(2,9,4), changeZoneVertical(2,9,7).
deadzone(5) :- changeZoneHorizontal(5,1,10), changeZoneHorizontal(6,1,10), changeZoneVertical(2,9,5), changeZoneVertical(2,9,6).