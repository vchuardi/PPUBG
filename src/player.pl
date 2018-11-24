:-include('Func_Proc_Global.pl').
:-dynamic(player/2).
:-dynamic(player/3).
:-dynamic(enemy/3).
:-dynamic(enemy/4).


init_player :-
	new_player_pos,
	player(position,X,Y),
	assertz(position(X,Y,P)).
	

init_enemy(N):-
	NLama is N,
	make_n_enemy(N),
	change_n_enemy_pos(NLama).

/* Player */
player(health,100).
player(armor,0).
player(weapon,none).
player(ammo,0).
player(position,3,3).

new_player_pos:-
	get_random_position(X, Y),
	retract(player(position, 0, 0)),
	assert(player(position, X, Y)).


/* Enemy */
make_n_enemy(N) :-
/* Assert sebanyak N enemy */
	N=:=1,
	/* Untuk sekarang enemynya pas drop in lsg punya senjata, armor, dan ammo */
	asserta(enemy(1, health, 100)),
	asserta(enemy(1, armor, 50)),
	asserta(enemy(1, weapon, revolver)),
	asserta(enemy(1, ammo, 100)),
	asserta(enemy(1, psosition, 0, 0)), !.
make_n_enemy(N) :-
	asserta(enemy(N, health, 100)),
	asserta(enemy(N, armor, 50)),
	asserta(enemy(N, weapon, revolver)),
	asserta(enemy(N, ammo, 100)),
	asserta(enemy(N, psosition, 0, 0)),
	NBar is N-1,
	make_n_enemy(NBar).

change_n_enemy_pos(N) :-
	N=:=1,
	retract(enemy(1, position, 0, 0)),
	get_random_position(X, Y),
	asserta(enemy(1, position, X, Y)),
	assertz(position(X,Y,E)), !.
change_n_enemy_pos(N) :-
	retract(enemy(N, position, 0, 0)),
	get_random_position(X, Y),
	asserta(enemy(N, position, X, Y)).
	assertz(position(X,Y,E)).


enemy_move(Id) :-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(Id , position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=1,
	XBar is X,
	YBar is Y+1,
	retract(enemy(Id, position, X, Y)),
	asserta(enemy(Id, position, XBar, YBar)),
	assertz(position(XBar,YBar,E)), !.
	
enemy_move(Id) :-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(Id, position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=2,
	XBar is X+1,
	YBar is Y,
	retract(enemy(Id, position, X, Y)),
	asserta(enemy(Id, position, XBar, YBar)),
	assertz(position(XBar,YBar,E)), !.

enemy_move(Id) :-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(Id, position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=3,
	XBar is X,
	YBar is Y-1,
	retract(enemy(Id, position, X, Y)),
	asserta(enemy(Id, position, XBar, YBar)),
	assertz(position(XBar,YBar,E)), !.

enemy_move(Id) :-
	/*1 Diam, 2 Bergerak*/
	random(1, 2, State),
	State=:=2,
	enemy(Id, position, X, Y),
	random(1, 4, Arah),
	/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
	Arah=:=4,
	XBar is X-1,
	YBar is Y,
	retract(enemy(Id, position, X, Y)),
	asserta(enemy(Id, position, XBar, YBar)),
	assertz(position(XBar,YBar,E)), !.


enemy_attack(Id) :-
	player(position, X, Y),
	player(health, PHealth),
	player(armor, PArmor),
	enemy(Id, position, X, Y),
	enemy(Id, weapon, EWeapon),
	weapon(EWeapon, EDmg),
	enemy(Id, ammo, EAmmo),
	EAmmo > 0,
	SisaArmor is PArmor-EDmg,
	SisaArmor =< 0,
	retract(player(armor, PArmor)),
	asserta(player(armor, 0)),
	SisaHealth is PHealth-EDmg+PArmor,
	retract(player(health, PHealth)),
	asserta(player(health, SisaHealth)), !.

enemy_attack(Id) :-
	player(position, X, Y),
	player(health, PHealth),
	player(armor, PArmor),
	enemy(Id, position, X, Y),
	enemy(Id, weapon, EWeapon),
	weapon(EWeapon, EDmg),
	enemy(Id, ammo, EAmmo),
	EAmmo > 0,
	SisaArmor is PArmor-EDmg,
	SisaArmor > 0,
	retract(player(armor, PArmor)),
	asserta(player(armor, SisaArmor)), !.

