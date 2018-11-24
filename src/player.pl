:-include('Func_Proc_Global.pl').
:-dynamic(player/2).
:-dynamic(player/3).
:-dynamic(enemy/2).
:-dynamic(enemy/3).


/*init_player :-
	new_player_Pos,
	new_enemy_pos,
	player(position,X,Y),
	assertz(position(X,Y,P)),
	enemy(position,X1,Y1),
	assertz(position(X1,Y1,E)).*/

/* Player */
player(health,100).
player(armor,0).
player(weapon,none).
player(ammo,0).
player(position,3,3).

new_player_Pos:-
	get_random_position(X, Y),
	retract(player(position, 0, 0)),
	assert(player(position, X, Y)).

/* Enemy */

enemy(health, 100).
enemy(armor, 0).
enemy(weapon, none).
enemy(ammo, 0).
enemy(position, 0, 0).

new_enemy_pos:-
	get_random_position(X, Y),
	retract(enemy(position, 0, 0)),
	assert(enemy(position, X, Y)).

enemy_move:-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=1,
	XBar is X,
	YBar is Y+1,
	retract(enemy(position, X, Y)),
	assert(enemy(position, XBar, YBar)).
	
enemy_move:-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=2,
	XBar is X+1,
	YBar is Y,
	retract(enemy(position, X, Y)),
	assert(enemy(position, XBar, YBar)).

enemy_move:-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=3,
	XBar is X,
	YBar is Y-1,
	retract(enemy(position, X, Y)),
	assert(enemy(position, XBar, YBar)).

enemy_move:-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=4,
	XBar is X-1,
	YBar is Y,
	retract(enemy(position, X, Y)),
	assert(enemy(position, XBar, YBar)).


enemy_attack:-
	print("Nanti dikerjain").

