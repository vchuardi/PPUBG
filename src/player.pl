:-include('Func_Proc_Global.pl').
:-dynamic(player/2).
:-dynamic(player/3).
:-dynamic(enemy/2).
:-dynamic(enemy/3).


/*init_player :-
	new_player_Pos,
	new_enemy_pos,
	player(position,X,Y),
<<<<<<< HEAD
	assertz(position(X,Y,P)),
	enemy(position,X1,Y1),
	assertz(position(X1,Y1,E)).*/
=======
	assertz(position(X,Y,P)).
	

init_enemy(N):-
	asserta(NBEnemy(N)),
	NLama is N,
	make_n_enemy(N),
	change_n_enemy_pos(NLama).
>>>>>>> 78e3fb705e12354b5e3fe94ff1d5a72c2cd2fa43

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

<<<<<<< HEAD

enemy_attack:-
	print("Nanti dikerjain").
=======
enemy_attack(Id) :-
	player(position, X, Y),
	player(health, PHealth),
	player(armor, PArmor),
	enemy(Id, position, X, Y),
	enemy(Id, weapon, EWeapon),
	damage(EWeapon, EDmg),
	enemy(Id, ammo, EAmmo),
	EAmmo > 0,
	SisaAmmo is EAmmo-1,
	retract(enemy(Id, ammo, EAmmo)),
	asserta(enemy(Id, ammo, SisaAmmo)),
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
	damage(EWeapon, EDmg),
	enemy(Id, ammo, EAmmo),
	EAmmo > 0,
	SisaAmmo is EAmmo-1,
	retract(enemy(Id, ammo, EAmmo)),
	asserta(enemy(Id, ammo, SisaAmmo)),
	SisaArmor is PArmor-EDmg,
	SisaArmor > 0,
	retract(player(armor, PArmor)),
	asserta(player(armor, SisaArmor)), !.
>>>>>>> 78e3fb705e12354b5e3fe94ff1d5a72c2cd2fa43

clean_up_enemy(N):-
    N=:=1,
	retract(enemy(N, health, 0)),
	retract(enemy(N, position, _, _)),
	retract(enemy(N, weapon, _)),
	retract(enemy(N, ammo, _)),
	retract(enemy(N, armor, _)).
clean_up_enemy(N):-
	retract(enemy(N, health, 0)),
	retract(enemy(N, position, _, _)),
	retract(enemy(N, weapon, _)),
	retract(enemy(N, ammo, _)),
	retract(enemy(N, armor, _)),
    NBar is N-1,
    clean_up_enemy(NBar).
clean_up_enemy(N):-
	\+ retract(enemy(N, health, 0)),
    NBar is N-1,
    clean_up_enemy(NBar).
