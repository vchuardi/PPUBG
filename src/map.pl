/* ***************** Map ***************** */

:- dynamic(position/3).
/* Facts */


/* Rules */
/* Create Map */
createMap :- generateMap(1,1), !.
generateMap(X,Y) :- X=<12, Y=<12, assertz(position(X,Y,-)), A is Y+1, generateMap(X,A).
generateMap(X,Y) :- Y>12, A is X+1, generateMap(A,1).
generateMap(11,_).

/* Print Map */
map :- player_setup_map, printMap(1,1).
printMap(X,Y) :- X=<12, Y=<12, position(X,Y,Obj) , write(Obj), write(' '), A is (Y+1), printMap(X,A).
printMap(X,Y) :- Y>12, A is X+1, nl, printMap(A,1).

/* Change Object in Position (X,Y) */
/* Delete Top Most Object in a Position and Assert New Object in a Position in The Lowest Fact */
changeObjectDown(X,Y,Object) :- call(position(X,Y,A)) , retract(position(X,Y,A)) , assertz(position(X,Y,Object)), !.
/* Delete Top Most Object in a Position and Assert New Object in a Position in The Lowest Fact */
changeObjectUp(X,Y,Object) :- call(position(X,Y,A)) , retract(position(X,Y,A)) , asserta(position(X,Y,Object)), !.

/* Creating Deadzone */
/* Change Object in A Line */
changeZoneHorizontal(X,Y1,Y2) :- Y1=<Y2, changeObjectDown(X,Y1,x), change_terrain(X,Y1), A is Y1+1, changeZoneHorizontal(X,A,Y2).
changeZoneVertical(X1,X2,Y) :- X1=<X2, changeObjectDown(X1,Y,x), change_terrain(X1,Y), A is X1+1, changeZoneVertical(A,X2,Y).

/* From The Outer Boundary to The Inner Boundary */
/* Deadzone Level 0 */
deadzone(0) :- changeZoneHorizontal(1,1,12).
deadzone(0) :- changeZoneHorizontal(12,1,12).
deadzone(0) :- changeZoneVertical(1,11,1).
deadzone(0) :- changeZoneVertical(1,11,12).

/* Deadzone Level 1 */
deadzone(1) :- changeZoneHorizontal(2,1,12).
deadzone(1) :- changeZoneHorizontal(11,1,12).
deadzone(1) :- changeZoneVertical(1,9,2).
deadzone(1) :- changeZoneVertical(1,9,11).

/* Deadzone Level 2 */
deadzone(2) :- changeZoneHorizontal(3,1,12).
deadzone(2) :- changeZoneHorizontal(10,1,12).
deadzone(2) :- changeZoneVertical(1,9,3).
deadzone(2) :- changeZoneVertical(1,9,10).

/* Deadzone Level 3 */
deadzone(3) :- changeZoneHorizontal(4,1,12).
deadzone(3) :- changeZoneHorizontal(9,1,12).
deadzone(3) :- changeZoneVertical(1,9,4).
deadzone(3) :- changeZoneVertical(1,9,9).

/* Deadzone Level 4 */
deadzone(4) :- changeZoneHorizontal(5,1,12).
deadzone(4) :- changeZoneHorizontal(8,1,12).
deadzone(4) :- changeZoneVertical(1,9,5).
deadzone(4) :- changeZoneVertical(1,9,8).

/* Deadzone Level 5 */
deadzone(5) :- changeZoneHorizontal(6,1,12).
deadzone(5) :- changeZoneHorizontal(7,1,12).
deadzone(5) :- changeZoneVertical(1,9,6).
deadzone(5) :- changeZoneVertical(1,9,7).

/* Terrain */
:- dynamic(terrain/3).

terrain(2,2,hole).
terrain(2,3,hut).
terrain(2,4,town).
terrain(2,5,forest).
terrain(2,6,road).
terrain(2,7,desert).
terrain(2,8,warehouse).
terrain(2,9,tundra).
terrain(2,10,cliff).
terrain(2,11,cave).

terrain(3,2,garden).
terrain(3,3,forbiddenForest).
terrain(3,4,chamber).
terrain(3,5,backyard).
terrain(3,6,artRoom).
terrain(3,7,base).
terrain(3,8,dorm).
terrain(3,9,eigen).
terrain(3,10,geyser).
terrain(3,11,seaSide).

terrain(4,2,graveyard).
terrain(4,3,underwater).
terrain(4,4,cannal).
terrain(4,5,cemetary).
terrain(4,6,town).
terrain(4,7,meadow).
terrain(4,8,bunker).
terrain(4,9,attractionField).
terrain(4,10,lawn).
terrain(4,11,yard).

terrain(5,2,hotel).
terrain(5,3,barn).
terrain(5,4,oakTree).
terrain(5,5,citadel).
terrain(5,6,pyramid).
terrain(5,7,hillside).
terrain(5,8,aeroplane).
terrain(5,9,kiosk).
terrain(5,10,oasis).
terrain(5,11,marsh).

terrain(6,2,pineTree).
terrain(6,3,airship).
terrain(6,4,hilltop).
terrain(6,5,city).
terrain(6,6,beach).
terrain(6,7,nutField).
terrain(6,8,pond).
terrain(6,9,basement).
terrain(6,10,reefs).
terrain(6,11,den).

terrain(7,2,rook).
terrain(7,3,nebula).
terrain(7,4,cargo).
terrain(7,5,sewer).
terrain(7,6,airport).
terrain(7,7,oakTree).
terrain(7,8,raft).
terrain(7,9,marsh).
terrain(7,10,barn).
terrain(7,11,coast).

terrain(8,2,roof).
terrain(8,3,bushes).
terrain(8,4,village).
terrain(8,5,oasis).
terrain(8,6,camp).
terrain(8,7,weeds).
terrain(8,8,basement).
terrain(8,9,vault).
terrain(8,10,nutField).
terrain(8,11,suburb).

terrain(9,2,circus).
terrain(9,3,hill).
terrain(9,4,paddyField).
terrain(9,5,openField).
terrain(9,6,aeroplane).
terrain(9,7,windmill).
terrain(9,8,beach).
terrain(9,9,lakeside).
terrain(9,10,beach).
terrain(9,11,pyramid).

terrain(10,2,stadium).
terrain(10,3,rockPlain).
terrain(10,4,yacht).
terrain(10,5,boat).
terrain(10,6,basement).
terrain(10,7,pond).
terrain(10,8,maze).
terrain(10,9,restaurant).
terrain(10,10,beach).
terrain(10,11,nebula).

terrain(11,1,dirtField).
terrain(11,2,rockField).
terrain(11,3,mineField).
terrain(11,4,openField).
terrain(11,5,stoneField).
terrain(11,6,glassField).
terrain(11,7,crystalField).
terrain(11,8,metalField).
terrain(11,9,wheatField).
terrain(11,10,cornField).

terrain(1,1,deadZone).
terrain(1,2,deadZone).
terrain(1,3,deadZone).
terrain(1,4,deadZone).
terrain(1,5,deadZone).
terrain(1,6,deadZone).
terrain(1,7,deadZone).
terrain(1,8,deadZone).
terrain(1,9,deadZone).
terrain(1,10,deadZone).
terrain(1,11,deadZone).
terrain(1,12,deadZone).
terrain(1,1,deadZone).
terrain(2,1,deadZone).
terrain(3,1,deadZone).
terrain(4,1,deadZone).
terrain(5,1,deadZone).
terrain(6,1,deadZone).
terrain(7,1,deadZone).
terrain(8,1,deadZone).
terrain(9,1,deadZone).
terrain(10,1,deadZone).
terrain(11,1,deadZone).
terrain(12,1,deadZone).
terrain(12,1,deadZone).
terrain(12,2,deadZone).
terrain(12,3,deadZone).
terrain(12,4,deadZone).
terrain(12,5,deadZone).
terrain(12,6,deadZone).
terrain(12,7,deadZone).
terrain(12,8,deadZone).
terrain(12,9,deadZone).
terrain(12,10,deadZone).
terrain(12,11,deadZone).
terrain(12,12,deadZone).
terrain(1,12,deadZone).
terrain(2,12,deadZone).
terrain(3,12,deadZone).
terrain(4,12,deadZone).
terrain(5,12,deadZone).
terrain(6,12,deadZone).
terrain(7,12,deadZone).
terrain(8,12,deadZone).
terrain(9,12,deadZone).
terrain(10,12,deadZone).
terrain(11,12,deadZone).
terrain(12,12,deadZone).

change_terrain(X,Y) :- retract(terrain(X,Y,Z)),asserta(terrain(X,Y,deadZone)). 

player_setup_map :- 
    player(position,X,Y),
    changeObjectUp(X,Y,'P').